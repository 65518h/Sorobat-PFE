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

builder.Services.AddHttpClient<ISiteManagementService, SiteManagementService>(client =>
// AddhttpClient permet de configurer un client HTTP spécifique pour le service ISiteManagementService, en indiquant que l'implémentation concrète à utiliser est SiteManagementService.
// .net s'occupe de créer une instance de HttpClient (httpClient = new HttpClient() avec les configurations spécifiées) pour SiteManagementService et de gérer sa durée de vie, ce qui est important pour éviter les problèmes de socket exhaustion liés à la création excessive d'instances de HttpClient.
// <ISiteManagementService, SiteManagementService> : ca indique que lorsque ISiteManagementService est demandé , on doit passer à une instance de SiteManagementService pour fournir l'implémentation concrète de ce service
{
    client.BaseAddress = new Uri("http://localhost:7048/BC240/api/soroubat/siteManagement/v1.0/"); 
})
.ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler 
    // à chaque fois que .net a besoin de créer une instance de HttpClient pour SiteManagementService, il utilisera la fonction ConfigurePrimaryHttpMessageHandler pour configurer le HttpClientHandler
{
    UseDefaultCredentials = true, // Authentification Windows NTLM lors de la frappe à la porte 7048 de BC
    AllowAutoRedirect = true // ca permet de suivre les redirections HTTP faites par BC au cas de changement d'url ou de redirection vers autre serveur pour un load balancing, etc.
});

builder.Services.AddHttpClient<IPurchaseRequestService, PurchaseRequestService>(client => 
// client représente l'instance de HttpClient qui sera utilisée pour les appels HTTP dans PurchaseRequestService. 
// .net sait que client represente le HttpClient associé à IPurchaseRequestService puisqu'on à l'intérieur de addHttpClient<IPurchaseRequestService, PurchaseRequestService > 
{
    // ca remplace la définition de l'url de base dans le service lui méme , ca grantit la maintenace centralisée , DRY pricipe , speration of concerns (soc) , etc.
    client.BaseAddress = new Uri("http://localhost:7048/BC240/api/soroubat/siteManagement/v1.0/"); 
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