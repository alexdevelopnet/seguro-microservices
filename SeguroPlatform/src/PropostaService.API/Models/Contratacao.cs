
namespace PropostaService.API.Models
{
    public class Contratacao
    {
        public Guid Id { get; private set; } = Guid.NewGuid();
        public Guid PropostaId { get; private set; }
        public DateTime DataContratacao { get; private set; } = DateTime.UtcNow;

        private Contratacao() { }
        public Contratacao(Guid propostaId)
        {
            PropostaId = propostaId;
        }
    }
}