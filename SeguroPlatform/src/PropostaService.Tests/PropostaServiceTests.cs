using PropostaService.Application.Services;
using PropostaService.Domain.Entities;
using PropostaService.Domain.ValueObjects;

namespace PropostaService.Tests;

public class PropostaServiceTests
{
    [Fact]
    public void Deve_Criar_Proposta_Com_Status_EmAnalise()
    {
        // Arrange
        var service = new PropostaAppService();
        var nome = "João Batista";

        // Act
        var proposta = service.CriarProposta(nome);

        // Assert
        Assert.Equal(StatusProposta.EmAnalise, proposta.Status);
        Assert.Equal(nome, proposta.Nome);
        Assert.NotEqual(Guid.Empty, proposta.Id);
    }
}
