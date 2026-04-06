using Soroubat.Api.Interfaces;
using Soroubat.Api.Services;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// --- 1. RÉCUPÉRATION DE LA CONFIGURATION ---
// On extrait les valeurs une seule fois ici pour qu'elles soient 
// accessibles dans tout le fichier.
var bcConfig = builder.Configuration.GetSection("BusinessCentral");
string baseUrl = bcConfig.GetValue<string>("BaseUrl") ?? "";
string companyName = bcConfig.GetValue<string>("CompanyName") ?? "SOROUBATBF-NAV";

// On prépare l'URL complète avec la société (Méthode par Nom car vos IDs sont à zéro)
string fullUri = $"{baseUrl.TrimEnd('/')}/companies(name='{Uri.EscapeDataString(companyName)}')/";

// --- 2. CONFIGURATION DES SERVICES ---

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
        options.JsonSerializerOptions.DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull;
    });

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configuration du premier service
builder.Services.AddHttpClient<ISiteManagementService, SiteManagementService>(client =>
{
    // Maintenant 'fullUri' est bien reconnu ici
    client.BaseAddress = new Uri(fullUri); 
})
.ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler 
{
    UseDefaultCredentials = true,
    AllowAutoRedirect = true
});

// Configuration du deuxième service
builder.Services.AddHttpClient<IPurchaseRequestService, PurchaseRequestService>(client => 
{
    // 'fullUri' est aussi reconnu ici
    client.BaseAddress = new Uri(fullUri); 
})
.ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
{
    UseDefaultCredentials = true,
    AllowAutoRedirect = true
});

// Configuration CORS pour autoriser Angular
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngular", 
        policy => policy.WithOrigins("http://localhost:4200")
                        .AllowAnyMethod()
                        .AllowAnyHeader()
                        .AllowCredentials()); // ← Important pour l'authentification
});

var app = builder.Build();

// --- 2. PIPELINE HTTP ---

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Ordre correct
app.UseCors("AllowAngular");
// app.UseHttpsRedirection(); // Désactivé en dev
app.UseAuthorization();
app.MapControllers();

// Afficher l'URL de démarrage
Console.WriteLine("🚀 Backend démarré sur http://localhost:5227");
Console.WriteLine("📚 Swagger disponible sur http://localhost:5227/swagger");

app.Run();