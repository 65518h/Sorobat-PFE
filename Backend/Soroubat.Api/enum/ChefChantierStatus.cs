namespace Soroubat.Api.Models
{
    /// <summary>
    /// Résultat de la vérification BC d'un chef de chantier.
    /// Porte à la fois le statut et le numéro de projet pour éviter un double appel BC.
    /// </summary>
    public class ChefChantierCheckResult
    {
        public ChefChantierStatus Status { get; init; }
        public string? ProjectNo { get; init; }

        public static ChefChantierCheckResult Active(string projectNo)
        {
            return new ChefChantierCheckResult
            {
                Status    = ChefChantierStatus.Active,
                ProjectNo = projectNo
            };
        }

        public static ChefChantierCheckResult Fail(ChefChantierStatus status)
        {
            return new ChefChantierCheckResult { Status = status };
        }
    }

    public enum ChefChantierStatus
    {
        /// <summary>Chef actif avec un projet assigné — connexion autorisée.</summary>
        Active,

        /// <summary>Email introuvable dans la table BC.</summary>
        NotFound,

        /// <summary>Chef trouvé dans BC mais marqué inactif (Actif = false).</summary>
        Inactive,

        /// <summary>Chef actif mais sans numéro de projet assigné.</summary>
        NoProject
    }
}