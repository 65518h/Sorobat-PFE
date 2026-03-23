using System.Text.Json;
using System.Net.Http.Json;
using Soroubat.Api.Models;
public abstract class BaseService 
{
    protected async Task HandleErrorResponse(HttpResponseMessage response)
    {
        var errorContent = await response.Content.ReadAsStringAsync();
        try {
            var bcError = JsonSerializer.Deserialize<BCResponseError>(errorContent);
            throw new Exception(bcError?.Error?.Message ?? errorContent);
        } catch (JsonException) {
            throw new Exception($"Réponse de Business Central illisible. Code HTTP {(int)response.StatusCode}.");
        }
    }
}

