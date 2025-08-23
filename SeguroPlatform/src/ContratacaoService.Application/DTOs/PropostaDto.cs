using PropostaService.Domain.ValueObjects;


namespace ContratacaoService.Application.DTOs
{
    public class PropostaDto
    {
        public Guid Id { get; set; }
        public StatusProposta Status { get; set; }
    }
}
