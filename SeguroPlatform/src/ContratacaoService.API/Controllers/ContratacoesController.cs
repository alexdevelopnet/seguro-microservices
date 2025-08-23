using ContratacaoService.Application.Ports;
using Microsoft.AspNetCore.Mvc;

namespace ContratacaoService.API.Controllers
{
  [ApiController]
  [Route("api/[controller]")]
  public class ContratacoesController : ControllerBase
  {
    private readonly IContratacaoServicePort _service;

    public ContratacoesController(IContratacaoServicePort service)
    {
      _service = service;
    }

    [HttpPost]
    public async Task<IActionResult> Contratar([FromBody] ContratarRequest request)
    {
      try
      {
        var contratacao = await _service.ContratarAsync(request.PropostaId);
        return Created($"/api/contratacoes/{contratacao.Id}", contratacao);
      }
      catch (Exception ex)
      {
        return BadRequest(ex.Message);
      }
    }

    [HttpGet]
    public async Task<ActionResult<IEnumerable<object>>> Listar()
    {
      try
      {
        var contratacoes = await _service.ListarContratacoesAsync();
        return Ok(contratacoes);
      }
      catch (Exception ex)
      {
        return StatusCode(500, ex.Message);
      }
    }
  }

  public record ContratarRequest(Guid PropostaId);
}
