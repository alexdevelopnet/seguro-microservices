using PropostaService.Domain.Entities;
using PropostaService.Domain.ValueObjects;
using PropostaService.Application.Ports;

namespace PropostaService.Application.Services;

public class PropostaAppService : IPropostaServicePort
{
    private readonly IPropostaRepositoryPort _repository;
    
    public PropostaAppService(IPropostaRepositoryPort repository)
    {
        _repository = repository;
    }

    public async Task<Proposta> CriarPropostaAsync(string cliente, string tipoSeguro, decimal valor)
    {
        var proposta = new Proposta(cliente, tipoSeguro, valor);
        await _repository.AdicionarAsync(proposta);
        return proposta;
    }

    public async Task<List<Proposta>> ListarPropostasAsync()
    {
        return await _repository.ListarAsync();
    }

    public async Task<Proposta?> ObterPropostaPorIdAsync(Guid id)
    {
        return await _repository.ObterPorIdAsync(id);
    }

    public async Task<Proposta> AlterarStatusAsync(Guid id, string novoStatus)
    {
        var proposta = await _repository.ObterPorIdAsync(id);
        if (proposta == null)
            throw new ArgumentException("Proposta não encontrada");

        switch (novoStatus.ToLower())
        {
            case "aprovada":
                proposta.Aprovar();
                break;
            case "rejeitada":
                proposta.Rejeitar();
                break;
            default:
                throw new ArgumentException("Status inválido. Use 'aprovada' ou 'rejeitada'");
        }

        return await _repository.AtualizarAsync(proposta);
    }
}
