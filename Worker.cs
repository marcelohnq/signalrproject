using Microsoft.AspNetCore.SignalR;

namespace SignalrProject;

public class Worker(IHubContext<RelatorioHub> hub) : BackgroundService
{
    private readonly IHubContext<RelatorioHub> _hub = hub;
    private readonly IDictionary<int, int> _repository = new Dictionary<int, int>();

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            var r = new Random();
            int ano = r.Next(2019, 2025);
            const int valor = 5;

            if (!_repository.TryAdd(ano, valor))
            {
                _repository[ano] += valor;
            }

            await _hub.Clients.All.SendAsync("ReceiveMessage", _repository, cancellationToken: stoppingToken);
            await Task.Delay(10000, stoppingToken);
        }
    }
}