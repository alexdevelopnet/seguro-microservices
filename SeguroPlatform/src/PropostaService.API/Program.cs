using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using PropostaService.Application.Services;
using PropostaService.Application.Ports;
using PropostaService.Infrastructure.Persistence;
using PropostaService.Infrastructure.Repositories;


var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(o =>
{
    o.SwaggerDoc("v1", new OpenApiInfo { Title = "PropostaService API", Version = "v1" });
});

var connStr = Environment.GetEnvironmentVariable("PROPOSTA_DB")
              ?? builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<PropostaDbContext>(opt => opt.UseNpgsql(connStr));
builder.Services.AddScoped<IPropostaServicePort, PropostaAppService>();
builder.Services.AddScoped<IPropostaRepositoryPort, PropostaRepository>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "PropostaService API v1"));
}

// aplica migrations automaticamente
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<PropostaDbContext>();
    db.Database.Migrate();
}

app.UseHttpsRedirection();
app.MapControllers();

// Configurar porta específica
app.Run("http://localhost:5000");
