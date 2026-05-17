namespace Soroubat.Api.Models
{
    /// <summary>
    /// Résultat interne de la tentative d'authentification.
    /// Permet à AuthController de retourner un message d'erreur précis selon le cas d'échec.
    /// </summary>
    public class AuthResult
    {
        public bool Success { get; init; }
        public string? Token { get; init; }
        public string? ErrorCode { get; init; }

        public static AuthResult Ok(string token)
        {
            return new AuthResult { Success = true, Token = token };
        }

        public static AuthResult Fail(string errorCode)
        {
            return new AuthResult { Success = false, ErrorCode = errorCode };
        }
    }
}