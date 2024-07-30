using Microsoft.AspNetCore.SignalR;

namespace ProvaConceitoSignalR;

public class RelatorioHub : Hub
{
    public async Task SendMessage(string message)
    {
        await Clients.All.SendAsync("ReceiveMessage", message);
    }
}
