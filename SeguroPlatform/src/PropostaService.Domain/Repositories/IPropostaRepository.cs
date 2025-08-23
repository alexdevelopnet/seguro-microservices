using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using PropostaService.Domain.Entities;

namespace PropostaService.Domain.Repositories
{
    public interface IPropostaRepository
    {
        Task<Proposta> AdicionarAsync(Proposta proposta);
        Task<Proposta?> ObterPorIdAsync(Guid id);
        Task<List<Proposta>> ListarAsync();
        Task AtualizarAsync(Proposta proposta);
    }
}
