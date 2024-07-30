using Confluent.Kafka;
using Microsoft.AspNetCore.SignalR;
using System.Text.Json;

namespace ProvaConceitoSignalR;

public class Worker(IHubContext<RelatorioHub> hub) : BackgroundService
{
    private readonly IDictionary<int, int> _repository = new Dictionary<int, int>();

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        await Task.Yield();

        ConsumerConfig config = new()
        {
            BootstrapServers = "broker:29092",
            GroupId = "group_teste",
            AutoOffsetReset = AutoOffsetReset.Earliest
        };

        using IConsumer<Ignore, string> consumer = new ConsumerBuilder<Ignore, string>(config).Build();
        consumer.Subscribe("topic_teste");

        while (!stoppingToken.IsCancellationRequested)
        {
            ConsumeResult<Ignore, string> result = consumer.Consume(stoppingToken);

            Relatorio? relatorio = JsonSerializer.Deserialize<Relatorio>(result.Message.Value);

            if (relatorio == null)
            {
                continue;
            }

            if (!_repository.TryAdd(relatorio.Ano, relatorio.Valor))
            {
                _repository[relatorio.Ano] += relatorio.Valor;
            }

            await hub.Clients.All.SendAsync("ReceiveMessage", _repository, cancellationToken: stoppingToken);
        }
    }
}
