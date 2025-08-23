using PropostaService.Domain.Entities;
using PropostaService.Domain.ValueObjects;

namespace PropostaService.Application.Services;

public class PropostaAppService
{
    public Proposta CriarProposta(string nome)
    {
        return new Proposta(nome);
    }
}
