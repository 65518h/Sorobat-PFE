using Microsoft.EntityFrameworkCore;
using Soroubat.Api.Models; 
namespace Soroubat.Api.Data
{
    public class AuthDbContext : DbContext //hérite de toutes les fonctionnalités d'Entity Framework Core (EF Core)
    {
        public AuthDbContext(DbContextOptions<AuthDbContext> options) : base(options)
        {
        }

        public DbSet<User> Users { get; set; } //défintion de la table users 
    }
}