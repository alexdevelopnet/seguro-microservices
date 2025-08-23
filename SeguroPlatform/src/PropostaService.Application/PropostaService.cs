using PropostaService.Domain.Entities;

namespace PropostaService.Application.Services;

public class PropostaAppService
{
    public Proposta CriarProposta(string nome)
    {
        return new Proposta(nome);
    }
}
