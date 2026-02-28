using Soroubat.Api.Services;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// --- 1. CONFIGURATION DES SERVICES ---

builder.Services.AddControllers() 
    .AddJsonOptions(options => //Force l'API à transformer les noms de propriétés (ex: JobNo venant de BC) en minuscules au début (jobNo). Cela garantit que les données correspondent exactement à votre interface TypeScript JobTask.
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
    });builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwaggerGen();

// Configuration du HttpClient avec authentification Windows (NTLM)
// Cette méthode règle l'erreur 401 en envoyant vos identifiants à Business Central
// Tu dis à .NET : "Quand quelqu'un demande IJobTaskService, donne-lui BusinessCentralService" (enregistrement du service )
builder.Services.AddHttpClient<IJobTaskService, BusinessCentralService>()
    .ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
    {
        UseDefaultCredentials = true, // Utilise les identifiants de l'utilisateur actuellement connecté (vous) pour s'authentifier auprès de Business Central. authentification Windows (NTLM) 
        AllowAutoRedirect = true
    });

// Configuration CORS pour autoriser Angular
builder.Services.AddCors(options => //Définit la politique "AllowAngular" qui autorise explicitement l'origine http://localhost:4200. Cela permet à votre application Angular de faire des requêtes vers votre API sans être bloquée par les règles de sécurité du navigateur.
{
    options.AddPolicy("AllowAngular", 
        policy => policy.WithOrigins("http://localhost:4200")
                        .AllowAnyMethod()
                        .AllowAnyHeader());
});

var app = builder.Build();

// --- 2. PIPELINE HTTP ---

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// L'ordre est crucial : CORS doit être AVANT Authorization
app.UseCors("AllowAngular");

// En local, on peut désactiver la redirection HTTPS pour éviter les erreurs de certificat
// app.UseHttpsRedirection();

app.UseAuthorization();
app.MapControllers();

app.Run();