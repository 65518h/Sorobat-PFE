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
        Active,

        NotFound,

        Inactive,

        NoProject
    }
}