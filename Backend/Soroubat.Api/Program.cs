using Soroubat.Api.Services;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// --- 1. CONFIGURATION DES SERVICES ---

builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
    });builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configuration du HttpClient avec authentification Windows (NTLM)
// Cette méthode règle l'erreur 401 en envoyant vos identifiants à Business Central
builder.Services.AddHttpClient<IJobTaskService, BusinessCentralService>()
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