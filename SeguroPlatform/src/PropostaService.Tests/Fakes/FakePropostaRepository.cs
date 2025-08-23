using System.Threading.Tasks;
using PropostaService.Domain.Entities;
using PropostaService.Application.Ports;

namespace PropostaService.Tests.Fakes
{
    public class FakePropostaRepository : IPropostaRepositoryPort
    {
        public Proposta? LastProposta { get; private set; }
        public Task<Proposta> AdicionarAsync(Proposta proposta)
        {
            LastProposta = proposta;
            return Task.FromResult(proposta);
        }
        public Task<Proposta?> ObterPorIdAsync(System.Guid id) => Task.FromResult(LastProposta);
        public Task<System.Collections.Generic.List<Proposta>> ListarAsync() => Task.FromResult(new System.Collections.Generic.List<Proposta>());
        public Task<Proposta> AtualizarAsync(Proposta proposta) => Task.FromResult(proposta);
    }
}
