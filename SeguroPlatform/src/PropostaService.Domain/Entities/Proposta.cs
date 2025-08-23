using PropostaService.Domain.ValueObjects;

namespace PropostaService.Domain.Entities;

public class Proposta
{
    public Guid Id { get; private set; } = Guid.NewGuid();
    public string Cliente { get; private set; } = default!;
    public string TipoSeguro { get; private set; } = default!;
    public decimal Valor { get; private set; }
    public StatusProposta Status { get; private set; } = StatusProposta.EmAnalise;
    public DateTime CriadaEm { get; private set; } = DateTime.UtcNow;

    private Proposta() { } // EF
    public Proposta(string cliente, string tipoSeguro, decimal valor)
    {
        Cliente = cliente;
        TipoSeguro = tipoSeguro;
        Valor = valor;
    }
    public void Aprovar() => Status = StatusProposta.Aprovada;
    public void Rejeitar() => Status = StatusProposta.Rejeitada;
}
