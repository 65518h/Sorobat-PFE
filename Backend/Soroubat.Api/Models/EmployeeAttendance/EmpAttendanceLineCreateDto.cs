using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// POST <c>employeeAttendanceLines</c> : champs saisissables côté AL (page 50153).
    /// Exclut id, documentNo géré par la relation, employeeName et totaux (calculés BC).
    /// </summary>
    public class EmpAttendanceLineCreateDto
    {
        [JsonPropertyName("documentNo")]
        public string? DocumentNo { get; set; }

        [JsonPropertyName("employeeNo")]
        public string? EmployeeNo { get; set; }

        [JsonPropertyName("assignment")]
        public string? Assignment { get; set; }

        [JsonPropertyName("qualification")]
        public string? Qualification { get; set; }

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
    }
}