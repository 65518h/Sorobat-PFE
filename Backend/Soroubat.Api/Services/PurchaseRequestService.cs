using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Text.Json.Serialization;
using Soroubat.Api.Interfaces;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Interagit avec les APIs Business Central PurchaseRequestAPI et PurchaseRequestLineAPI.
    /// </summary>
    public class PurchaseRequestService : BaseService, IPurchaseRequestService
    {
        private readonly HttpClient _httpClient;
        private readonly ILogger<PurchaseRequestService> _logger;

        // paramétres de sérialisation write et read 
        private static readonly JsonSerializerOptions SerializerOptionsWrite = new()
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
        };

        private static readonly JsonSerializerOptions SerializerOptionsRead = new()
        {
            PropertyNameCaseInsensitive = true,
            PropertyNamingPolicy             = JsonNamingPolicy.CamelCase
        };

        public PurchaseRequestService(HttpClient httpClient, ILogger<PurchaseRequestService> logger)
        {
            _httpClient = httpClient;
            _logger     = logger;
        }

        // on a 3 méthodes helpers sérialisation 

        //  ToJsonObject : transforme un dto en JsonObject pour manipulation avant sérialisation finale.( dto , json object , json sérializé (string))
        private static JsonObject ToJsonObject<T>(T dto, JsonSerializerOptions o) =>
            (JsonSerializer.SerializeToNode(dto, o) as JsonObject) ?? new JsonObject();

        // MergeJobNoAndSerialize : ajoute le jobNo au JsonObject puis le sérialise en json string prét 
        // on utilise le type générique T car ca peut étre remplacé par le dto de création ou de patch 
        private static string MergeJobNoAndSerialize<T>(T dto, string projectNo)
        {
            var root = ToJsonObject(dto, SerializerOptionsWrite);
            root["jobNo"] = projectNo;
            return root.ToJsonString();
        }

        // on n'utilise pas un type générique ici car la création de ligne nécessite l'ajout du lineNo qui n'existe pas dans le dto de patch
        private static string MergeJobNoLineNoAndSerialize(PurchaseRequestLineCreateDto dto, string projectNo, int lineNo)
        {
            var root = ToJsonObject(dto, SerializerOptionsWrite);
            root["jobNo"]  = projectNo;
            root["lineNo"] = lineNo;
            return root.ToJsonString();
        }


        // on a 2 méthode helpers pour vérifier l'appartenance au projet du chef chantier connecté et récupérer l'etag pour les opérations de patch

        // on vérifie si le header appartient au projet du chef chantier connecté + on récupère l'etag pour les opérations de patch
        private async Task<(PurchaseRequestReadDto Header, string? ETag)> GetAndVerifyHeaderAsync(Guid id, string projectNo)
        {
            var response = await _httpClient.GetAsync($"purchaseRequests({id})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La demande d'achat '{id}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);
            // on utilise les regles de désérialisation de SerializerOptionsRead
            var header = await response.Content.ReadFromJsonAsync<PurchaseRequestReadDto>(SerializerOptionsRead);

            if (header == null)
                throw new KeyNotFoundException($"La demande d'achat '{id}' est introuvable dans Business Central.");

            if (!string.Equals(header.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[PR] Accès refusé : demande {Id} appartient au projet {HeaderProject}, " +
                    "chef connecté au projet {UserProject}", id, header.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette demande n'appartient pas à votre projet.");
            }
            // l'etag contient la version de la ressource , ca sert pour les opérations de mise à jour (PATCH) pour éviter les conflits de version
            var etag = response.Headers.ETag?.ToString(); 
            return (header, etag);
        }


        private async Task<(PurchaseRequestLineReadDto Line, string? ETag)> GetAndVerifyLineAsync(
            Guid lineId, string projectNo)
        {
            var response = await _httpClient.GetAsync($"purchaseRequestLines({lineId})");

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                throw new KeyNotFoundException($"La ligne '{lineId}' est introuvable dans Business Central.");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var line = await response.Content.ReadFromJsonAsync<PurchaseRequestLineReadDto>(SerializerOptionsRead);

            if (line == null)
                throw new KeyNotFoundException($"La ligne '{lineId}' est introuvable dans Business Central.");

            if (!string.Equals(line.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                _logger.LogWarning(
                    "[PR] Accès refusé ligne {LineId} : projet {LineProject} ≠ {UserProject}",
                    lineId, line.JobNo, projectNo);
                throw new UnauthorizedAccessException(
                    "Accès refusé : cette ligne n'appartient pas à votre projet.");
            }

            var etag = response.Headers.ETag?.ToString();
            return (line, etag);
        }

         
        private async Task<int> GetLastLineNoAsync(string documentNo)
        {
            var url = $"purchaseRequestLines?$filter=documentNo eq '{documentNo}'" +
                      "&$orderby=lineNo desc&$top=1";

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                return 0;

            var content = await response.Content.ReadAsStringAsync();

            using var doc = JsonDocument.Parse(content); // charge content en mémoire pour manipulation 
            var root      = doc.RootElement.GetProperty("value"); // on accéde à la propriété "value" qui contient la liste des lignes retournées par BC

            if (root.GetArrayLength() > 0)
                return root[0].GetProperty("lineNo").GetInt32(); // on extrait le lineNo le plus élevé 

            return 0;
        }
        
        // ici commencent les méthodes métiers de l'interface IPurchaseRequestService
        public async Task<IEnumerable<PurchaseRequestReadDto>> GetAllRequestsAsync(string projectNo)
        {
            var url = $"purchaseRequests?$filter=jobNo eq '{projectNo}'";
            _logger.LogInformation("[PR] GetAll pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.GetAsync(url);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var result = await response.Content.ReadFromJsonAsync<BCResponse<PurchaseRequestReadDto>>(SerializerOptionsRead);
            return result?.Value ?? Enumerable.Empty<PurchaseRequestReadDto>();
        }

        public async Task<PurchaseRequestReadDto?> GetRequestByIdAsync(Guid id, string projectNo)
        {
            var url = $"purchaseRequests({id})?$expand=purchaseRequestLines";
            var response = await _httpClient.GetAsync(url);

            if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                return null;

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            var request = await response.Content.ReadFromJsonAsync<PurchaseRequestReadDto>(SerializerOptionsRead);

            // appartenance de la demande au projet du chef chantier connecté
            if (request != null &&
                !string.Equals(request.JobNo, projectNo, StringComparison.OrdinalIgnoreCase))
            {
                throw new UnauthorizedAccessException("Accès refusé : cette demande n'appartient pas à votre projet.");
            }

            return request;
        }

        public async Task<PurchaseRequestReadDto> CreateHeaderAsync(PurchaseRequestCreateDto header, string projectNo)
        {
            var json    = MergeJobNoAndSerialize(header, projectNo);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _logger.LogInformation("[PR] Création en-tête pour projet {ProjectNo}", projectNo);

            var response = await _httpClient.PostAsync("purchaseRequests", content);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            // le ! sert à indiquer au compilateur que l'on est sûr que le résultat ne sera pas null , n'afficher pas un warning
            return (await response.Content.ReadFromJsonAsync<PurchaseRequestReadDto>(SerializerOptionsRead))!;
        }

        public async Task<bool> CreateLinesAsync(List<PurchaseRequestLineCreateDto> lines, string projectNo)
        {
            if (lines == null || !lines.Any()) return false;

            var firstDocNo = lines.First().DocumentNo; // documentNo est le no du header 

            if (string.IsNullOrWhiteSpace(firstDocNo))
                throw new ArgumentException(
                    "Le numéro de document (DocumentNo) est obligatoire pour créer des lignes.");

            int currentMaxLineNo = await GetLastLineNoAsync(firstDocNo);

            foreach (var line in lines)
            {
                currentMaxLineNo += 10000;

                var json    = MergeJobNoLineNoAndSerialize(line, projectNo, currentMaxLineNo);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                _logger.LogInformation("[PR] Création ligne {DocNo} / LineNo {LineNo}",
                    line.DocumentNo, currentMaxLineNo);

                var response = await _httpClient.PostAsync("purchaseRequestLines", content);

                if (!response.IsSuccessStatusCode)
                    await HandleErrorResponseAsync(response);
            }

            return true;
        }

        public async Task<bool> PatchHeaderAsync(Guid id, PurchaseRequestPatchDto header, string projectNo)
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var json = JsonSerializer.Serialize(header, SerializerOptionsWrite);
            _logger.LogInformation("[PR] PATCH en-tête {Id} — Body: {Json}", id, json);

            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"purchaseRequests({id})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] PATCH en-tête {Id} — Réponse: {Status}",
                id, (int)response.StatusCode);

            return true;
        }

        public async Task<bool> SubmitForApprovalAsync(Guid id, string projectNo)
        {
            var (existing, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var currentStatut = existing.Statut ?? string.Empty;
            if (!string.Equals(currentStatut, "Open", StringComparison.OrdinalIgnoreCase))
                throw new InvalidOperationException(
                    $"Statut actuel '{currentStatut}' — seule une demande 'Open' peut être soumise.");

            var json = """{"statut": "To Approve"}"""; // on échappe les guillemets internes du json
            // on utilise patch car pour l'erp c'est une mise à jour d'une partie de la ressource (le statut) 
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"purchaseRequests({id})") 
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] Demande {Id} soumise pour approbation.", id);
            return true;
        }

        // le comportement de suppression des lignes en casecade est géré par BC , dans la table header dans le trigger onDelete 
        public async Task<bool> DeleteRequestAsync(Guid id, string projectNo) 
        {
            var (_, etag) = await GetAndVerifyHeaderAsync(id, projectNo);

            var request = new HttpRequestMessage(HttpMethod.Delete, $"purchaseRequests({id})");
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] Demande {Id} supprimée.", id);
            return true;
        }


        public async Task<bool> PatchLineAsync(Guid lineId, PurchaseRequestLinePatchDto lineDto, string projectNo)
        {
            var (_, etag) = await GetAndVerifyLineAsync(lineId, projectNo);

            var json    = MergeJobNoAndSerialize(lineDto, projectNo);
            var request = new HttpRequestMessage(new HttpMethod("PATCH"), $"purchaseRequestLines({lineId})")
            {
                Content = new StringContent(json, Encoding.UTF8, "application/json")
            };
            request.Headers.TryAddWithoutValidation("If-Match", etag ?? "*");

            var response = await _httpClient.SendAsync(request);

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            return true;
        }

        public async Task<bool> DeleteLineAsync(Guid lineId, string projectNo)
        {
            await GetAndVerifyLineAsync(lineId, projectNo);

            var response = await _httpClient.DeleteAsync($"purchaseRequestLines({lineId})");

            if (!response.IsSuccessStatusCode)
                await HandleErrorResponseAsync(response);

            _logger.LogInformation("[PR] Ligne {LineId} supprimée.", lineId);
            return true;
        }


    }
}
