using Soroubat.Api.Interfaces;
using Soroubat.Api.Services;
using System.Text;
using System.Text.Json;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Soroubat.Api.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);


var bcConfig = builder.Configuration.GetSection("BusinessCentral");

string rawUrl      = bcConfig.GetValue<string>("BaseUrl")     ?? throw new InvalidOperationException("'BusinessCentral:BaseUrl' est absent de appsettings.json.");
string companyName = bcConfig.GetValue<string>("CompanyName") ?? throw new InvalidOperationException("'BusinessCentral:CompanyName' est absent de appsettings.json.");

string baseUrl = rawUrl.Split("/api/")[0].Split("/ODataV4")[0].TrimEnd('/');

string siteManagementUri = $"{baseUrl}/api/soroubat/siteManagement/v1.0/companies(name='{Uri.EscapeDataString(companyName)}')/";

string lookupsUri = $"{baseUrl}/api/soroubat/lookups/v1.0/companies(name='{Uri.EscapeDataString(companyName)}')/";


var jwtKey = builder.Configuration["Jwt:Key"]
    ?? throw new InvalidOperationException("La clé JWT 'Jwt:Key' est absente de appsettings.json.");

builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer           = true,
            ValidateAudience         = true,
            ValidateLifetime         = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer              = builder.Configuration["Jwt:Issuer"],
            ValidAudience            = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey         = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey)),
            ClockSkew                = TimeSpan.FromMinutes(1)
        };
    });

builder.Services.AddAuthorization();


builder.Services.AddDbContext<AuthDbContext>(options =>
    options.UseSqlite(
        builder.Configuration.GetConnectionString("DefaultConnection")
        ?? "Data Source=auth.db"));



builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
});


builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title   = "Soroubat API",
        Version = "v1",
        Description = "API de pilotage des chantiers — Intégrée à Microsoft Dynamics 365 Business Central"
    });

    c.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Name         = "Authorization",
        Type         = Microsoft.OpenApi.Models.SecuritySchemeType.ApiKey,
        Scheme       = "Bearer",
        BearerFormat = "JWT",
        In           = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Description  = "Entrez 'Bearer' suivi d'un espace et de votre jeton JWT.\n\nExemple : \"Bearer eyJhbGci...\""
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        {
            new Microsoft.OpenApi.Models.OpenApiSecurityScheme
            {
                Reference = new Microsoft.OpenApi.Models.OpenApiReference
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id   = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});


static HttpClientHandler WindowsAuthHandler() =>
    new HttpClientHandler { UseDefaultCredentials = true };

// Configuration partagée pour tous les services siteManagement
void ConfigureSiteManagementClient(HttpClient client)
{
    client.BaseAddress = new Uri(siteManagementUri);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json"));
}

// Configuration partagée pour tous les services lookups
void ConfigureLookupClient(HttpClient client)
{
    client.BaseAddress = new Uri(lookupsUri);
    client.DefaultRequestHeaders.Accept.Clear();
    client.DefaultRequestHeaders.Accept.Add(
        new MediaTypeWithQualityHeaderValue("application/json"));
}


builder.Services
    .AddHttpClient<ISiteManagementService, SiteManagementService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IPurchaseRequestService, PurchaseRequestService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<ITransferService, TransferService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IStockService, StockService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IChefChantierService, ChefChantierService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IVehiculeService, VehiculeService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IGasoilService, GasoilService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IEmpAttendanceService, AttendanceService>(ConfigureSiteManagementClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);


builder.Services
    .AddHttpClient<ILookupService, LookupService>(ConfigureLookupClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);

builder.Services
    .AddHttpClient<IEmployeeService, EmployeeService>(ConfigureLookupClient)
    .ConfigurePrimaryHttpMessageHandler(WindowsAuthHandler);


builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IAlertService, AlertService>();


builder.Services.AddCors(opt => opt.AddPolicy("AllowAngular", p =>
    p.WithOrigins("http://localhost:4200", "http://localhost:4201", "http://127.0.0.1:4201")
     .AllowAnyMethod()
     .AllowAnyHeader()
     .AllowCredentials()));


var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowAngular");
app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/api/auth/ping", () => Results.Ok(new { status = "ok", timestamp = DateTime.UtcNow }));
app.MapControllers();

Console.WriteLine("🚀 Backend démarré sur http://localhost:5227");
Console.WriteLine("📚 Swagger disponible sur http://localhost:5227/swagger");

app.Run();