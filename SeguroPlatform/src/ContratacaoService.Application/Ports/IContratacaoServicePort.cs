using ContratacaoService.Domain.Entities;

namespace ContratacaoService.Application.Ports;

public interface IContratacaoServicePort
{
    Task<Contratacao> ContratarAsync(Guid propostaId);
    Task<List<Contratacao>> ListarContratacoesAsync();
}
