use master

go

if not exists(select 1 from sys.databases where name = 'PoCSignalR')
begin
	create database PoCSignalR
end


go

use PoCSignalR

go

if not exists (select name from sys.tables where name = 'Estado')
begin

	create table dbo.Estado (
		Id int identity primary key not null,
		Nome varchar(100) not null
	)


	create table dbo.Cidade (
		Id int identity primary key not null,
		Nome varchar(100) not null,
		Populacao int not null,
		IdEstado int not null references dbo.Estado(id)
	)


	create table dbo.Departamento (
		Id int identity primary key not null,
		Nome varchar(50) not null,
		IdCidade int not null references dbo.Cidade(id)
	)

	create table dbo.Pessoa (
		Id int identity primary key not null,
		Nome varchar(50) not null,
		IdDepartamento int not null references dbo.Departamento(id)
	)

end