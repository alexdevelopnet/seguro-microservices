using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using PropostaService.Domain.Entities;
using PropostaService.Application.Ports;
using PropostaService.Infrastructure.Persistence;

namespace PropostaService.Infrastructure.Repositories
{
    public class PropostaRepository : IPropostaRepositoryPort
    {
        private readonly PropostaDbContext _context;
        public PropostaRepository(PropostaDbContext context)
        {
            _context = context;
        }

        public async Task<Proposta> AdicionarAsync(Proposta proposta)
        {
            _context.Propostas.Add(proposta);
            await _context.SaveChangesAsync();
            return proposta;
        }

        public async Task<Proposta?> ObterPorIdAsync(Guid id)
        {
            return await _context.Propostas.FindAsync(id);
        }

        public async Task<List<Proposta>> ListarAsync()
        {
            return await _context.Propostas.ToListAsync();
        }

        public async Task<Proposta> AtualizarAsync(Proposta proposta)
        {
            _context.Propostas.Update(proposta);
            await _context.SaveChangesAsync();
            return proposta;
        }
    }
}
