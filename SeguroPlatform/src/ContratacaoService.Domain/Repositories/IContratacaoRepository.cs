using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using ContratacaoService.Domain.Entities;

namespace ContratacaoService.Domain.Repositories
{
    public interface IContratacaoRepository
    {
        Task<Contratacao> AdicionarAsync(Contratacao contratacao);
        Task<Contratacao?> ObterPorIdAsync(Guid id);
        Task<List<Contratacao>> ListarAsync();
    }
}
