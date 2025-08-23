using PropostaService.Domain.ValueObjects;

namespace PropostaService.Domain.Entities;

public class Proposta
{
    public Guid Id { get; set; }
    public string Nome { get; set; }
    public StatusProposta Status { get; set; }
    public Proposta(string nome)
    {
        Id = Guid.NewGuid();
        Nome = nome;
        Status = StatusProposta.EmAnalise;
    }
}
