using PropostaService.Domain.Entities;

namespace PropostaService.Application.Ports;

public interface IPropostaRepositoryPort
{
    Task<Proposta> AdicionarAsync(Proposta proposta);
    Task<List<Proposta>> ListarAsync();
    Task<Proposta?> ObterPorIdAsync(Guid id);
    Task<Proposta> AtualizarAsync(Proposta proposta);
}
