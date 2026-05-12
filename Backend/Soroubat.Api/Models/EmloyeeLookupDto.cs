namespace Soroubat.Api.Models
{
    public class EmployeeLookupDto
    {
        public Guid Id { get; set; }
        public string Matricule { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Fonction { get; set; }
        public string Chantier { get; set; }
        public string ImageBase64 { get; set; }// Contient le Base64 ou l'URL du média
    }

    public class FaceVerificationPostDto
    {
        public string Matricule { get; set; }
        public string CapturedImageBase64 { get; set; }
    }
}