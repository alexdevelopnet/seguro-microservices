using Microsoft.AspNetCore.Mvc;

namespace ContratacaoService.API.Controllers
{
    
        [ApiController]
        [Route("api/[controller]")]
        public class HealthController : ControllerBase
        {
            [HttpGet]
            public IActionResult Get() => Ok("ContratacaoService está rodando com Swagger Alex!");
        }
    }
 
