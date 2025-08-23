using Microsoft.AspNetCore.Mvc;
using PropostaService.API.DTOs;
using PropostaService.Application.Ports;
using PropostaService.Domain.Entities;

namespace PropostaService.API.Controllers
{
  [ApiController]
  [Route("api/[controller]")]
  public class PropostasController : ControllerBase
  {
    private readonly IPropostaServicePort _service;

    public PropostasController(IPropostaServicePort service)
    {
      _service = service;
    }

    [HttpPost]
    public async Task<ActionResult<Proposta>> Criar([FromBody] CriarPropostaRequest request)
    {
      var proposta = await _service.CriarPropostaAsync(request.Cliente, request.TipoSeguro, request.Valor);
      return CreatedAtAction(nameof(ObterPorId), new { id = proposta.Id }, proposta);
    }


    [HttpGet]
    public async Task<ActionResult<IEnumerable<Proposta>>> Listar()
    {
      var propostas = await _service.ListarPropostasAsync();
      return Ok(propostas);
    }


    [HttpGet("{id}")]
    public async Task<ActionResult<Proposta>> ObterPorId(Guid id)
    {
      var proposta = await _service.ObterPropostaPorIdAsync(id);
      if (proposta == null)
        return NotFound();
      return Ok(proposta);
    }

    [HttpPatch("{id}/status")]
    public async Task<ActionResult<Proposta>> AlterarStatus(Guid id, [FromBody] AlterarStatusRequest request)
    {
      try
      {
        var proposta = await _service.AlterarStatusAsync(id, request.Status);
        return Ok(proposta);
      }
      catch (ArgumentException ex)
      {
        return BadRequest(ex.Message);
      }
      catch (Exception)
      {
        return NotFound();
      }
    }
  }

}
