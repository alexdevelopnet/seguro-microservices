using System;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using ContratacaoService.Application.DTOs;
using ContratacaoService.Application.Ports;

namespace ContratacaoService.Infrastructure.Adapters
{
    public class PropostaServiceHttpAdapter : IPropostaServicePort
    {
        private readonly HttpClient _httpClient;
        private readonly string _propostaServiceUrl;
        
        public PropostaServiceHttpAdapter(HttpClient httpClient, IConfiguration configuration)
        {
            _httpClient = httpClient;
            _propostaServiceUrl = configuration["PropostaService:BaseUrl"] ?? "http://localhost:5000";
        }

        public async Task<PropostaDto?> ObterPropostaPorIdAsync(Guid propostaId)
        {
            var response = await _httpClient.GetAsync($"{_propostaServiceUrl}/api/propostas/{propostaId}");
            if (!response.IsSuccessStatusCode)
                return null;
            return await response.Content.ReadFromJsonAsync<PropostaDto>();
        }
    }
}
