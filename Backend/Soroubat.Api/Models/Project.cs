// Models/ProjectDto.cs
using System.Text.Json.Serialization;

namespace Soroubat.Api.Models
{
    public class ProjectDto
    {
        public string Id { get; set; } = string.Empty;
        public string Number { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public string CustomerName { get; set; } = string.Empty;
        public string Responsible { get; set; } = string.Empty;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public DateTime? ActualStartDate { get; set; }
        public DateTime? ActualEndDate { get; set; }
        public string Status { get; set; } = "En cours";
        public decimal Budget { get; set; }
        public int Progress { get; set; }
        public string? Location { get; set; }
        public List<JobTaskDto>? Tasks { get; set; }
    }
}