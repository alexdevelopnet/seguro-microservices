using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace ContratacaoService.Infrastructure.Persistence
{
    public class ContratacaoDbContextFactory : IDesignTimeDbContextFactory<ContratacaoDbContext>
    {
        public ContratacaoDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ContratacaoDbContext>();
            optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=contratacaodb;Username=postgres;Password=TMKTtmkt123");

            return new ContratacaoDbContext(optionsBuilder.Options);
        }
    }
}
