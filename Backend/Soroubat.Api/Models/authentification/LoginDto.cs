using System.ComponentModel.DataAnnotations;

namespace Soroubat.Api.Models
{
    /// <summary>
    /// Données envoyées par le client lors d'une tentative de connexion.
    /// </summary>
    public class LoginPostDto
    {
        [Required(ErrorMessage = "L'adresse e-mail est obligatoire.")]
        [EmailAddress(ErrorMessage = "L'adresse e-mail n'est pas valide.")]
        public string Email { get; set; } = string.Empty; // string.Empty évite les warnings de nullabilité

        [Required(ErrorMessage = "Le mot de passe est obligatoire.")]
        [MinLength(6, ErrorMessage = "Le mot de passe doit contenir au moins 6 caractères.")]
        public string Password { get; set; } = string.Empty;
    }
}