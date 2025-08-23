using Microsoft.AspNetCore.Mvc;

namespace PropostaService.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class Health2Controller : Controller
    { 
            [HttpGet]
            public IActionResult Get() => Ok("ContratacaoService está rodando com Swagger Alex!");
        }
    }
 
