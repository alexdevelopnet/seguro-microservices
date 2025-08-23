using ContratacaoService.Domain.Entities;
using ContratacaoService.Application.Ports;
using PropostaService.Domain.ValueObjects;


namespace ContratacaoService.Application.Services
{
    public class ContratacaoAppService : IContratacaoServicePort
    {
        private readonly IPropostaServicePort _propostaServicePort;
        private readonly IContratacaoRepositoryPort _contratacaoRepository;
        
        public ContratacaoAppService(IPropostaServicePort propostaServicePort, IContratacaoRepositoryPort contratacaoRepository)
        {
            _propostaServicePort = propostaServicePort;
            _contratacaoRepository = contratacaoRepository;
        }

        public async Task<Contratacao> ContratarAsync(Guid propostaId)
        {
            var proposta = await _propostaServicePort.ObterPropostaPorIdAsync(propostaId);
            if (proposta is null)
                throw new Exception("Proposta não encontrada");
            if (proposta.Status != StatusProposta.Aprovada)
                throw new Exception("Proposta não está aprovada para contratação");
            var contratacao = new Contratacao { PropostaId = propostaId };
            await _contratacaoRepository.AdicionarAsync(contratacao);
            return contratacao;
        }

        public async Task<List<Contratacao>> ListarContratacoesAsync()
        {
            return await _contratacaoRepository.ListarAsync();
        }
    }
}
