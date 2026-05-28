using System.Text.Json;
using Soroubat.Api.Models;

namespace Soroubat.Api.Services
{
    /// <summary>
    /// Classe de base partagée par tous les services qui communiquent avec Business Central.
    /// Fournit une gestion centralisée et homogène des réponses d'erreur HTTP de BC.
    /// </summary>
    public abstract class BaseService
    {
        /// <summary>
        /// Lit le corps de la réponse d'erreur BC, extrait le message métier et lève une exception.
        /// Appelé systématiquement après un statut HTTP non-succès.
        /// </summary>
        protected async Task HandleErrorResponseAsync(HttpResponseMessage response)
        {
            var errorContent = await response.Content.ReadAsStringAsync();

            // si le Corps vide alors on génére des messages générique selon le code HTTP
            if (string.IsNullOrWhiteSpace(errorContent))
            {
                throw new HttpRequestException(response.StatusCode switch
                {
                    System.Net.HttpStatusCode.NotFound =>
                        "Ressource introuvable dans Business Central (404). Vérifiez l'URL ou que l'extension est déployée.",
                    System.Net.HttpStatusCode.Unauthorized =>
                        "Authentification refusée par Business Central (401).",
                    System.Net.HttpStatusCode.Forbidden =>
                        "Accès refusé par Business Central (403).",
                    System.Net.HttpStatusCode.UnprocessableEntity =>
                        "Données invalides rejetées par Business Central (422). Vérifiez les champs envoyés.",
                    _ =>
                        $"Erreur Business Central inattendue. Code HTTP : {(int)response.StatusCode}."
                });
            }

            // si Corps présent alros on tente d'extraire le message d'erreur BC (format OData standard)
            try
            {
                var bcError = JsonSerializer.Deserialize<BCResponseError>(errorContent);
                var message = bcError?.Error?.Message;

                throw new HttpRequestException(
                    string.IsNullOrWhiteSpace(message) ? errorContent : message);
            }
            catch (JsonException)
            {
                // Le corps n'est pas du JSON valide 
                throw new HttpRequestException(
                    $"Réponse de Business Central illisible (JSON invalide). " +
                    $"Code HTTP {(int)response.StatusCode}. Contenu : {errorContent}");
            }
        }
    }
}