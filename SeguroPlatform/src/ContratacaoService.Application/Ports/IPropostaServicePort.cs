using System;
using System.Threading.Tasks;
using ContratacaoService.Application.DTOs;

namespace ContratacaoService.Application.Ports
{
    public interface IPropostaServicePort
    {
        Task<PropostaDto?> ObterPropostaPorIdAsync(Guid propostaId);
    }
}
