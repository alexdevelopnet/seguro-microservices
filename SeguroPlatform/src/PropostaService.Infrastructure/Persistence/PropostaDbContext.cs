using Microsoft.EntityFrameworkCore;
using PropostaService.Domain.Entities;

namespace PropostaService.Infrastructure.Persistence;

public class PropostaDbContext : DbContext
{
    public PropostaDbContext(DbContextOptions<PropostaDbContext> options) : base(options) { }

    public DbSet<Proposta> Propostas => Set<Proposta>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Proposta>(cfg =>
        {
            cfg.ToTable("proposta");
            cfg.HasKey(x => x.Id);
            cfg.Property(x => x.Cliente).IsRequired().HasMaxLength(120);
            cfg.Property(x => x.TipoSeguro).IsRequired().HasMaxLength(80);
            cfg.Property(x => x.Valor).HasColumnType("numeric(18,2)");
            cfg.Property(x => x.Status).HasConversion<int>().IsRequired();
            cfg.Property(x => x.CriadaEm).HasColumnType("timestamp with time zone");
            cfg.HasIndex(x => new { x.Cliente, x.CriadaEm });
        });
    }
}
