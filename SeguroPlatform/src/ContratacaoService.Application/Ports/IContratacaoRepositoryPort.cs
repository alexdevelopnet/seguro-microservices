using ContratacaoService.Domain.Entities;

namespace ContratacaoService.Application.Ports;

public interface IContratacaoRepositoryPort
{
    Task<Contratacao> AdicionarAsync(Contratacao contratacao);
    Task<List<Contratacao>> ListarAsync();
    Task<Contratacao?> ObterPorIdAsync(Guid id);
}
