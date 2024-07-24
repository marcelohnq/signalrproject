using Microsoft.AspNetCore.SignalR;

namespace SignalrProject;

public class RelatorioHub : Hub
{
    public async Task SendMessage(string message)
    {
        await Clients.All.SendAsync("ReceiveMessage", message);
    }
}