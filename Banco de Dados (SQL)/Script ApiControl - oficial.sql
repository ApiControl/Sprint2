create database apiControl;

use apiControl;

create table endereco(
idEndereco int primary key auto_increment,
estado char (2),
cidade varchar (40),
cep char (8),
bairro varchar (40),
logradouro varchar (100),
numero varchar (15),
complemento varchar (40)
);

create table empresa(
idempresa int primary key auto_increment,
nome varchar (50),
emailAdmin varchar (100),
senhaAdmin varchar (45),
cnpj char (14),
telefone char (12),
fkEndereco int,
constraint fkEndereco
foreign key (fkEndereco)
	references endereco(idEndereco)
);

create table usuario(
idUsuario int primary key auto_increment,
nome varchar (30),
usuario varchar (30),
senha varchar (30),
tipoUsuario varchar (45),
fkEmpresa int,
constraint fkEmpresa
foreign key (fkEmpresa)
	references empresa(idEmpresa)
);

create table especie(
idEspecie int primary key auto_increment,
nome varchar(40),
tipo varchar (40),
temperaturaMinima float,
temperaturaMaxima float,
umidadeMinima float,
umidadeMaxima float
-- luminosidadeMinima float,
-- luminoidadeMaxima float
);

create table colmeia(
idColmeia int primary key auto_increment,
descricao varchar (200),
statusColmeia varchar (40),
localizacao varchar (40),
fkEmpresa int,
constraint fkEmpresa
foreign key (fkEmpresa)
	references empresa(idEmpresa),
fkEspecie int,
constraint fkEspecie
foreign key (fkEspecie)
	references especie(idEspecie)
);

create table sensores(
idSensor int primary key auto_increment,
tipo varchar (45),
fkColmeia int,
constraint fkColmeia
foreign key (fkColmeia)
	references colmeia(idColmeia)
);

create table registrtos (
idRegistro int primary key auto_increment,
temperatura float,
umidade float,
luminosidade float, 
bloqueio char (1),
dataHora datetime,
fkColmeia int,
constraint fkColmeia
foreign key (fkColmeia)
	references colmeia(idColmeia)
);









