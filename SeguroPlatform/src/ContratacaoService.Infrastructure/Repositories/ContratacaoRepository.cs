using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using ContratacaoService.Domain.Entities;
using ContratacaoService.Application.Ports;
using ContratacaoService.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace ContratacaoService.Infrastructure.Repositories
{
    public class ContratacaoRepository : IContratacaoRepositoryPort
    {
        private readonly ContratacaoDbContext _context;
        public ContratacaoRepository(ContratacaoDbContext context)
        {
            _context = context;
        }

        public async Task<Contratacao> AdicionarAsync(Contratacao contratacao)
        {
            _context.Contratacoes.Add(contratacao);
            await _context.SaveChangesAsync();
            return contratacao;
        }

        public async Task<Contratacao?> ObterPorIdAsync(Guid id)
        {
            return await _context.Contratacoes.FindAsync(id);
        }

        public async Task<List<Contratacao>> ListarAsync()
        {
            return await _context.Contratacoes.ToListAsync();
        }
    }
}
