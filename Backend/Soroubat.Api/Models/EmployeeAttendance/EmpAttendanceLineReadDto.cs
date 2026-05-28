using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// GET — ligne pointage salarié BC (page 50153).
    /// Les champs calculés (totaux) portent JsonIgnore WhenWritingNull — ils sont
    /// recalculés automatiquement par BC via CalculateTotals() sur OnInsertRecord/OnModifyRecord.
    /// </summary>
    public class EmpAttendanceLineReadDto
    {
        /// <summary>SystemId BC — assigné par BC à la création, ignoré à l'envoi.</summary>
        [JsonPropertyName("id")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public Guid? Id { get; set; }

        /// <summary>
        /// Numéro du document parent (N° de la fiche en-tête) — lié via SubPageLink dans BC.
        /// Ignoré à l'envoi si null.
        /// </summary>
        [JsonPropertyName("documentNo")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? DocumentNo { get; set; }

        /// <summary>Matricule du salarié.</summary>
        [JsonPropertyName("employeeNo")]
        public string? EmployeeNo { get; set; }

        /// <summary>Nom du salarié — renseigné par BC, ignoré à l'envoi.</summary>
        [JsonPropertyName("employeeName")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public string? EmployeeName { get; set; }

        /// <summary>Affectation du salarié.</summary>
        [JsonPropertyName("assignment")]
        public string? Assignment { get; set; }

        [JsonPropertyName("assignmentDescription")]
        public string? AssignmentDescription { get; set; }

        [JsonPropertyName("day1")]  public string? Day1  { get; set; }
        [JsonPropertyName("day2")]  public string? Day2  { get; set; }
        [JsonPropertyName("day3")]  public string? Day3  { get; set; }
        [JsonPropertyName("day4")]  public string? Day4  { get; set; }
        [JsonPropertyName("day5")]  public string? Day5  { get; set; }
        [JsonPropertyName("day6")]  public string? Day6  { get; set; }
        [JsonPropertyName("day7")]  public string? Day7  { get; set; }
        [JsonPropertyName("day8")]  public string? Day8  { get; set; }
        [JsonPropertyName("day9")]  public string? Day9  { get; set; }
        [JsonPropertyName("day10")] public string? Day10 { get; set; }
        [JsonPropertyName("day11")] public string? Day11 { get; set; }
        [JsonPropertyName("day12")] public string? Day12 { get; set; }
        [JsonPropertyName("day13")] public string? Day13 { get; set; }
        [JsonPropertyName("day14")] public string? Day14 { get; set; }
        [JsonPropertyName("day15")] public string? Day15 { get; set; }
        [JsonPropertyName("day16")] public string? Day16 { get; set; }
        [JsonPropertyName("day17")] public string? Day17 { get; set; }
        [JsonPropertyName("day18")] public string? Day18 { get; set; }
        [JsonPropertyName("day19")] public string? Day19 { get; set; }
        [JsonPropertyName("day20")] public string? Day20 { get; set; }
        [JsonPropertyName("day21")] public string? Day21 { get; set; }
        [JsonPropertyName("day22")] public string? Day22 { get; set; }
        [JsonPropertyName("day23")] public string? Day23 { get; set; }
        [JsonPropertyName("day24")] public string? Day24 { get; set; }
        [JsonPropertyName("day25")] public string? Day25 { get; set; }
        [JsonPropertyName("day26")] public string? Day26 { get; set; }
        [JsonPropertyName("day27")] public string? Day27 { get; set; }
        [JsonPropertyName("day28")] public string? Day28 { get; set; }
        [JsonPropertyName("day29")] public string? Day29 { get; set; }
        [JsonPropertyName("day30")] public string? Day30 { get; set; }
        [JsonPropertyName("day31")] public string? Day31 { get; set; }

        /// <summary>Total jours présents — calculé par BC, ignoré à l'envoi.</summary>
        [JsonPropertyName("totalPresentDays")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? TotalPresentDays { get; set; }

        /// <summary>Total jours absents — calculé par BC, ignoré à l'envoi.</summary>
        [JsonPropertyName("totalAbsentDays")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public int? TotalAbsentDays { get; set; }

        /// <summary>Total heures présentes — calculé par BC, ignoré à l'envoi.</summary>
        [JsonPropertyName("totalHours")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? TotalHours { get; set; }

                [JsonPropertyName("totalCong")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? TotalCong { get; set; }

                [JsonPropertyName("totalCongExp")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? TotalCongExp { get; set; }

                [JsonPropertyName("totalFerier")]
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
        public decimal? TotalFerier { get; set; }
    }



}