using ProvaConceitoSignalR;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSignalR();
builder.Services.AddHostedService<Worker>();

var app = builder.Build();

app.UseHttpsRedirection();

app.MapHub<RelatorioHub>("/hub");

app.Run();
