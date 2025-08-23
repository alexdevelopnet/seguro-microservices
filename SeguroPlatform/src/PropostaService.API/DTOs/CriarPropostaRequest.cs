namespace PropostaService.API.DTOs
{
    public record CriarPropostaRequest(string Cliente, string TipoSeguro, decimal Valor);
}
