using PropostaService.Application.Services;
using PropostaService.Domain.Entities;
using PropostaService.Domain.ValueObjects;
using PropostaService.Tests.Fakes;

namespace PropostaService.Tests;

public class PropostaServiceTests
{
    [Fact]
    public async Task Deve_Criar_Proposta_Com_Status_EmAnalise()
    {
        // Arrange
        var fakeRepo = new FakePropostaRepository();
        var service = new PropostaAppService(fakeRepo);
        var cliente = "João Batista";
        var tipoSeguro = "Auto";
        var valor = 1000.00m;

        // Act
        var proposta = await service.CriarPropostaAsync(cliente, tipoSeguro, valor);

        // Assert
        Assert.Equal(StatusProposta.EmAnalise, proposta.Status);
        Assert.Equal(cliente, proposta.Cliente);
        Assert.Equal(tipoSeguro, proposta.TipoSeguro);
        Assert.Equal(valor, proposta.Valor);
        Assert.NotEqual(Guid.Empty, proposta.Id);
    }

    [Fact]
    public async Task Deve_Alterar_Status_Para_Aprovada()
    {
        // Arrange
        var fakeRepo = new FakePropostaRepository();
        var service = new PropostaAppService(fakeRepo);
        var proposta = await service.CriarPropostaAsync("Maria Silva", "Vida", 500.00m);

        // Act
        var propostaAtualizada = await service.AlterarStatusAsync(proposta.Id, "aprovada");

        // Assert
        Assert.Equal(StatusProposta.Aprovada, propostaAtualizada.Status);
    }

    [Fact]
    public async Task Deve_Alterar_Status_Para_Rejeitada()
    {
        // Arrange
        var fakeRepo = new FakePropostaRepository();
        var service = new PropostaAppService(fakeRepo);
        var proposta = await service.CriarPropostaAsync("Pedro Santos", "Residencial", 800.00m);

        // Act
        var propostaAtualizada = await service.AlterarStatusAsync(proposta.Id, "rejeitada");

        // Assert
        Assert.Equal(StatusProposta.Rejeitada, propostaAtualizada.Status);
    }

    [Fact]
    public async Task Deve_Lancarar_Excecao_Para_Status_Invalido()
    {
        // Arrange
        var fakeRepo = new FakePropostaRepository();
        var service = new PropostaAppService(fakeRepo);
        var proposta = await service.CriarPropostaAsync("Ana Costa", "Empresarial", 1200.00m);

        // Act & Assert
        var excecao = await Assert.ThrowsAsync<ArgumentException>(
            () => service.AlterarStatusAsync(proposta.Id, "invalido"));
        
        Assert.Contains("Status inválido", excecao.Message);
    }
}
