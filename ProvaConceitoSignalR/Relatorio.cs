using System.Text.Json.Serialization;

namespace ProvaConceitoSignalR;

public class Relatorio
{
    [JsonPropertyName("ano")]
    public int Ano { get; set; }

    [JsonPropertyName("valor")]
    public int Valor { get; set; }
}
