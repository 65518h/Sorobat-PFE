using Soroubat.Api.Interfaces;
using Soroubat.Api.Services;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// --- 1. CONFIGURATION DES SERVICES ---

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
        options.JsonSerializerOptions.DefaultIgnoreCondition = System.Text.Json.Serialization.JsonIgnoreCondition.WhenWritingNull;
    });

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Remplacez l'ancien enregistrement par celui-ci :
builder.Services.AddHttpClient<ISiteManagementService, SiteManagementService>()
    .ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
    {
        UseDefaultCredentials = true, // Authentification Windows NTLM
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