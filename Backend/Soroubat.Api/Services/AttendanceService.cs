using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les APIs Business Central EmpAttendanceHeaderAPI (page 50152)
    /// et EmpAttendanceLineAPI (page 50153) pour la gestion des fiches de pointage salarié.
    /// </summary>
    public class AttendanceService : BaseService, IEmpAttendanceService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<AttendanceService> _logger;

        /// <summary>Sérialisation en écriture : ignore les propriétés null pour ne pas écraser les valeurs BC.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsWrite = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        /// <summary>Désérialisation en lecture : insensible à la casse, nommage camelCase.</summary>
        private static readonly JsonSerializerOptions SerializerOptionsRead = new()
        {
            PropertyNameCaseInsensitive = true,
            PropertyNamingPolicy        = JsonNamingPolicy.CamelCase
        };

        public AttendanceService(HttpClient httpClient, ILogger<AttendanceService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }

        // ── HELPERS PRIVÉS ────────────────────────────────────────────────────

        /// <summary>
        /// Récupère un en-tête et vérifie qu'il appartient au projet du chef connecté.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(EmpAttendanceReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(
            Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"employeeAttendanceHeaders({id})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La fiche de pointage '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content
                .ReadFromJsonAsync<EmpAttendanceReadDto>(SerializerOptionsRead);

            if (header == null)
                throw new KeyNotFoundException(
                    $"La fiche de pointage '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo?.Trim(), projectNo?.Trim(), StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Attendance] Accès refusé : fiche {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette fiche de pointage n'appartient pas à votre projet.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (header, etag);
        }

        /// <summary>
        /// Récupère une ligne et vérifie qu'elle appartient au projet du chef connecté
        /// via le document parent.
        /// Lève <see cref="KeyNotFoundException"/> si introuvable.
        /// Lève <see cref="UnauthorizedAccessException"/> si le projet ne correspond pas.
        /// </summary>
        private async Task<(EmpAttendanceLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            var lineResponse = await _httpClient.GetAsync($"employeeAttendanceLines({lineId})");

            if (lineResponse.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException(
                    $"La ligne de pointage '{lineId}' est introuvable dans Business Central.");

            if (!lineResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(lineResponse);

            var line = await lineResponse.Content
                .ReadFromJsonAsync<EmpAttendanceLineReadDto>(SerializerOptionsRead);

            if (line == null || string.IsNullOrEmpty(line.DocumentNo))
                throw new KeyNotFoundException(
                    $"La ligne de pointage '{lineId}' est introuvable dans Business Central.");

            // Vérification de sécurité via l'en-tête parent
            var headerUrl      = $"employeeAttendanceHeaders?$filter=no eq '{line.DocumentNo}'";
            var headerResponse = await _httpClient.GetAsync(headerUrl);

            if (!headerResponse.IsSuccessStatusCode)
                await HandleErrorResponseAsync(headerResponse);

            var headerResult = await headerResponse.Content
                .ReadFromJsonAsync<BCResponse<EmpAttendanceReadDto>>(SerializerOptionsRead);

            var header = headerResult?.Value?.FirstOrDefault();

            if (header == null)
                throw new KeyNotFoundException(
                    $"La fiche parente '{line.DocumentNo}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo?.Trim(), projectNo?.Trim(), StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Attendance] Accès refusé ligne {LineId} : projet {HeaderProject} ≠ {UserProject}",
                    lineId, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre projet.");
            }

            var etag = lineResponse.Headers.ETag?.ToString();
            return (line, etag);
        }

        // ── EN-TÊTES ──────────────────────────────────────────────────────────

        public async Task<IEnumerable<EmpAttendanceReadDto>> GetAllHeadersAsync(string projectNo)
        {
            var url = $"employeeAttendanceHeaders?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[Attendance] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<EmpAttendanceReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<EmpAttendanceReadDto>();
        }

        public async Task<EmpAttendanceReadDto?> GetHeaderByIdAsync(Guid id, string projectNo)
        {
            var url = $"employeeAttendanceHeaders({id})?$expand=employeeAttendanceLines";
            _logger.LogInformation("[Attendance] GetById {Id} pour projet {ProjectNo}", id, projectNo);

            var response = await _httpClient.GetAsync(url);

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                return null;

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var header = await response.Content
                .ReadFromJsonAsync<EmpAttendanceReadDto>(SerializerOptionsRead);

            if (header == null)
                return null;

            if (!string.Equals(header.JobNo?.Trim(), projectNo?.Trim(), StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[Attendance] Accès refusé : fiche {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette fiche de pointage n'appartient pas à votre projet.");
            }

            return header;
        }

        public async Task<EmpAttendanceReadDto> CreateHeaderAsync(EmpAttendanceHeaderCreateDto dto, string projectNo)
        {
            // Construire le payload en forçant jobNo depuis le JWT (ignore toute valeur cliente)
            // On utilise un JsonObject pour injecter jobNo sans l'exposer dans le DTO client
            var node = System.Text.Json.JsonSerializer.SerializeToNode(dto, SerializerOptionsWrite)                as System.Text.Json.Nodes.JsonObject
                ?? new System.Text.Json.Nodes.JsonObject();

            node["jobNo"] = projectNo;
            var json = node.ToJsonString();

            _logger.LogInformation("[Attendance] Création fiche pour projet {ProjectNo}", projectNo);

            var content  = new StringContent(json, Encoding.UTF8, "application/json");
            var response = await _httpClient.PostAsync("employeeAttendanceHeaders", content);

            if (!response.IsSuccessStatusCode)
            {
                var errorDetail = await response.Content.ReadAsStringAsync();
                _logger.LogError("[Attendance] Erreur POST BC — Code : {StatusCode}", (int)response.StatusCode);

                // Détecter le doublon BC et lever une exception métier explicite
                if (errorDetail.Contains("Deja saisie") || errorDetail.Contains("DialogException"))
                    throw new InvalidOperationException(errorDetail);

                await HandleErrorResponseAsync(response);
            }

            return (await response.Content
                .ReadFromJsonAsync<EmpAttendanceReadDto>(SerializerOptionsRead))!;
        }

        public async Task<bool> PatchHeaderAsync(Guid id, EmpAttendanceHeaderPatchDto dto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var json = JsonSerializer.Serialize(dto, SerializerOptionsWrite);
            _logger.LogInformation("[Attendance] PATCH en-tête {Id}", id);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"employeeAttendanceHeaders({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Attendance] PATCH en-tête {Id} — Réponse : {Status}",
                id, (int)response.StatusCode);

            return true;
        }

        public async Task<bool> DeleteHeaderAsync(Guid id, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"employeeAttendanceHeaders({id})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Attendance] Fiche {Id} supprimée.", id);
            return true;
        }

        // ── LIGNES ────────────────────────────────────────────────────────────

        public async Task<bool> CreateLinesAsync(List<EmpAttendanceLineCreateDto> lines, string projectNo)
        {
            if (lines == null || !lines.Any())
                return false;

            foreach (var line in lines)
            {
                var json     = JsonSerializer.Serialize(line, SerializerOptionsWrite);
                var content  = new StringContent(json, Encoding.UTF8, "application/json");
                var response = await _httpClient.PostAsync("employeeAttendanceLines", content);

                if (!response.IsSuccessStatusCode)
                    await HandleErrorResponseAsync(response);
            }

            return true;
        }

        public async Task<bool> PatchLineAsync(Guid lineId, EmpAttendanceLinePatchDto lineDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json = JsonSerializer.Serialize(lineDto, SerializerOptionsWrite);
            _logger.LogInformation("[Attendance] PATCH ligne {LineId}", lineId);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"employeeAttendanceLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Attendance] PATCH ligne {LineId} — Réponse : {Status}",
                lineId, (int)response.StatusCode);

            return true;
        }

        public async Task<bool> DeleteLineAsync(Guid lineId, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"employeeAttendanceLines({lineId})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[Attendance] Ligne {LineId} supprimée.", lineId);
            return true;
        }

        // ── USAGE INTERNE (AlertService) ──────────────────────────────────────

        public async Task<IEnumerable<EmpAttendanceReadDto>> GetAllHeadersWithLinesAsync(string projectNo)
        {
            var url = $"employeeAttendanceHeaders?$filter=jobNo eq '{projectNo}'&$expand=employeeAttendanceLines";
            _logger.LogInformation("[Attendance] GetAllWithLines pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content
                .ReadFromJsonAsync<BCResponse<EmpAttendanceReadDto>>(SerializerOptionsRead);

            return result?.Value ?? Enumerable.Empty<EmpAttendanceReadDto>();
        }

        // ── RECONNAISSANCE FACIALE ────────────────────────────────────────────

        public async Task<bool> MarkPresenceAsync(Guid headerId, string employeeNo, int day, string projectNo)
        {
            if (day < 1 || day > 31)
                throw new ArgumentException(
                    $"Numéro de jour invalide : {day}. Doit être compris entre 1 et 31.");

            // Récupérer la fiche avec ses lignes (vérifie également l'appartenance au projet)
            var header = await GetHeaderByIdAsync(headerId, projectNo);

            if (header == null)
                return false;

            var line = header.Lines?.FirstOrDefault(l =>
                string.Equals(l.EmployeeNo, employeeNo, StringComparison.OrdinalIgnoreCase));

            if (line == null)
                throw new KeyNotFoundException(
                    $"Le salarié '{employeeNo}' n'est pas dans cette fiche de pointage.");

            if (line.Id == null)
                throw new InvalidOperationException(
                    "La ligne de pointage ne possède pas d'identifiant valide.");

            // Construire un DTO de PATCH avec uniquement le jour à marquer ("P" = Présent)
            var patchDto = BuildDayPatch(day, "P");

            return await PatchLineAsync(line.Id.Value, patchDto, projectNo);
        }

        /// <summary>
        /// Construit un <see cref="EmpAttendanceLinePatchDto"/> avec uniquement le jour spécifié renseigné.
        /// Tous les autres jours restent null et ne seront pas envoyés à BC.
        /// Un switch explicite est utilisé — plus sûr qu'une approche par réflexion,
        /// et résistant aux renommages de propriétés lors d'une refactorisation.
        /// </summary>
        private static EmpAttendanceLinePatchDto BuildDayPatch(int day, string value)
        {
            var dto = new EmpAttendanceLinePatchDto();

            switch (day)
            {
                case 1:  dto.Day1  = value; break;
                case 2:  dto.Day2  = value; break;
                case 3:  dto.Day3  = value; break;
                case 4:  dto.Day4  = value; break;
                case 5:  dto.Day5  = value; break;
                case 6:  dto.Day6  = value; break;
                case 7:  dto.Day7  = value; break;
                case 8:  dto.Day8  = value; break;
                case 9:  dto.Day9  = value; break;
                case 10: dto.Day10 = value; break;
                case 11: dto.Day11 = value; break;
                case 12: dto.Day12 = value; break;
                case 13: dto.Day13 = value; break;
                case 14: dto.Day14 = value; break;
                case 15: dto.Day15 = value; break;
                case 16: dto.Day16 = value; break;
                case 17: dto.Day17 = value; break;
                case 18: dto.Day18 = value; break;
                case 19: dto.Day19 = value; break;
                case 20: dto.Day20 = value; break;
                case 21: dto.Day21 = value; break;
                case 22: dto.Day22 = value; break;
                case 23: dto.Day23 = value; break;
                case 24: dto.Day24 = value; break;
                case 25: dto.Day25 = value; break;
                case 26: dto.Day26 = value; break;
                case 27: dto.Day27 = value; break;
                case 28: dto.Day28 = value; break;
                case 29: dto.Day29 = value; break;
                case 30: dto.Day30 = value; break;
                case 31: dto.Day31 = value; break;
            }

            return dto;
        }
    }
}