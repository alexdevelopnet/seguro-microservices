using PropostaService.Domain.Entities;

namespace PropostaService.Application.Ports;

public interface IPropostaServicePort
{
    Task<Proposta> CriarPropostaAsync(string cliente, string tipoSeguro, decimal valor);
    Task<List<Proposta>> ListarPropostasAsync();
    Task<Proposta?> ObterPropostaPorIdAsync(Guid id);
    Task<Proposta> AlterarStatusAsync(Guid id, string novoStatus);
}
