using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Adiciona serviços
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer(); // Necessário para Swagger
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Proposta Service API",
        Version = "v1",
        Description = "API para gerenciamento de propostas",
        Contact = new OpenApiContact
        {
            Name = "Time de Desenvolvimento",
            Email = "dev@empresa.com"
        }
    });
});

 builder.Services.AddOpenApi();

var app = builder.Build();
 
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "Proposta Service API v1");
        c.RoutePrefix = string.Empty; 
    });
     
    app.MapOpenApi();
}

app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

app.Run();
