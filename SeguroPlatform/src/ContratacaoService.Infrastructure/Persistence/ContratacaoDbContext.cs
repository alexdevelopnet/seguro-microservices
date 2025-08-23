using ContratacaoService.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace ContratacaoService.Infrastructure.Persistence
{
    public class ContratacaoDbContext : DbContext
    {
        public ContratacaoDbContext(DbContextOptions<ContratacaoDbContext> options) : base(options) { }

        public DbSet<Contratacao> Contratacoes => Set<Contratacao>();

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Contratacao>(cfg =>
            {
                cfg.ToTable("contratacao");
                cfg.HasKey(x => x.Id);
                cfg.Property(x => x.PropostaId).IsRequired();
                cfg.Property(x => x.DataContratacao).HasColumnType("timestamp with time zone");
            });
        }
    }
}
