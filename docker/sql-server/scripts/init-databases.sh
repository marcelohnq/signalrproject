until /opt/mssql-tools/bin/sqlcmd -S sql-server -U sa -P !PoCSignalR -Q "SELECT 1" &> /dev/null; do
	echo "Aguadando o servidor SQL Server ficar pronto..."
	sleep 5
done

echo "Iniciando a criação da base de dados"
/opt/mssql-tools/bin/sqlcmd -S sql-server -U sa -P !PoCSignalR -d master -i /tmp/scripts/script-criacao-database.sql
echo "Finalizando a criação da base de dados"

echo "Iniciando a carda de dados na base de dados"
/opt/mssql-tools/bin/sqlcmd -S sql-server -U sa -P !PoCSignalR -d PoCSignalR -i /tmp/scripts/carga-dados.sql
echo "Finalizando a carda de dados na base de dados"