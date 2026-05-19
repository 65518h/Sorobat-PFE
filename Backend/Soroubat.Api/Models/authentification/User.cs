namespace Soroubat.Api.Models
{
    /// <summary>
    /// Représente un utilisateur stocké dans la base SQLite locale.
    /// Sert uniquement à l'authentification — les données métier viennent de Business Central.
    /// </summary>
    public class User
    {
        public int Id { get; set; }

        /// <summary>Adresse e-mail — clé de liaison avec le ChefChantier dans BC.</summary>
        public string Email { get; set; } = string.Empty;

        /// <summary>Hash BCrypt du mot de passe — jamais en clair.</summary>
        public string PasswordHash { get; set; } = string.Empty;
    }
}