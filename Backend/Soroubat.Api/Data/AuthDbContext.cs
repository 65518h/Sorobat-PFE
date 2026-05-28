using Microsoft.EntityFrameworkCore;
using Soroubat.Api.Models; 
namespace Soroubat.Api.Data
{
    public class AuthDbContext : DbContext //hérite de toutes les fonctionnalités d'Entity Framework Core comme la gestion des connexions, le suivi des entités
    {
        public AuthDbContext(DbContextOptions<AuthDbContext> options) : base(options) {}
        // permet de faire passer les options spécifiés dans program.cs à la classe DbContext de base, qui les utilise pour configurer la connexion à la base de données SQLite.
  
        public DbSet<User> Users { get; set; } //défintion de la table users 
    }
}