create database apiControl;

use apiControl;

-- parte laranja da modelagem lógica ----------------------------
create table empresa(
idEmpresa int primary key auto_increment,
nome varchar (50),
cnpj char (14),
telefone char (12),
emailRepresentante varchar (70)
);

create table endereco(
idEndereco int,
estado char (2),
cidade varchar (40),
cep char (8),
bairro varchar (40),
logradouro varchar (100),
numero varchar (15),
complemento varchar (40), 
fkEmpresa int,
constraint fkEmpresa
foreign key (fkEmpresa)
	references empresa(idEmpresa),
primary key (idEndereco, fkEmpresa)
);

create table usuario(
idUsuario int primary key auto_increment,
nome varchar (30),
usuario varchar (30),
usuarioAdmin char (1),
senha varchar (30),
tipoUsuario varchar (45),
fkEmpresa int,
foreign key (fkEmpresa)
	references empresa(idEmpresa)
);

-- parte verde da modelagem lógica -------------------

create table especie( 
idEspecie int primary key auto_increment,
nome varchar(40),
tipo varchar (40),
temperaturaMinima double,
temperaturaMaxima double,
umidadeMinima double,
umidadeMaxima double,
luminosidadeMinima double,
luminosidadeMaxima double
);

create table colmeia(
idColmeia int primary key auto_increment,
descricao varchar (200),
statusColmeia varchar (40),
localizacao varchar (40),
fkEmpresa int,
foreign key (fkEmpresa)
	references empresa(idEmpresa),
fkEspecie int,
constraint fkEspecie
foreign key (fkEspecie)
	references especie(idEspecie)
);

create table sensores(
idSensor int primary key auto_increment,
nomeSensor varchar (45),
tipo varchar (45),
unidadeMedida varchar (5),
fkColmeia int,
constraint fkColmeia
foreign key (fkColmeia)
	references colmeia(idColmeia)
);

create table registros (
idRegistro int primary key auto_increment,
valorRegistrado double,
dataHora datetime,
fkSensor int,
constraint fkSensor
foreign key (fkSensor)
	references sensores(idSensor)
);

insert into empresa values -- null, nome, cnpj, telfefone, email
(null, 'Bee Happy', '13245967495701', '548739874562', 'BeeHappy@gmail.com'),
(null, 'Mel Brasil', '66574830173021', '433954038763', 'MelBrasil@gmail.com'),
(null, 'Abelhas do Campo', '88750123003467', '866274837400', 'AbelhasDoCampo@gmail.com');

select * from empresa;

insert into endereco values -- id endereco, estado, cidade, cep, bairro, logradouro, numero, complemento, fkempresa
(100, 'RS', 'Santana do Livramento', '12345678', 'Vila Luisiana', 'Rua das Iguanas', '875', null, 1),
(101, 'PR', 'Arapoi', '23456789', 'Jardim Pedrí', 'Rua Macedo Alameda', '42', null, 2),
(102, 'PI', 'Picos do Piauí', '34567890', 'Jardim das Flores', 'Rua Silva Rodovia', '558', null, 3);

select * from endereco;

insert into usuario values -- null, nome, usuario, usuarioAdmin, senha, tipoUsuario, fkEmpresa
(null, 'Andreia da silva Coltinho', 'Andreia Coltinho', '1', 'Bee@1856', 'Administrador', 1),
(null, 'Fábio Campos do Nascimento', 'Fábio Nascimento', '1', 'Mel@2113', 'Administrador', 2),
(null, 'Luana de Lima Mendonça Soares', 'Luana de Lima', '1', 'Abelhas@3095', 'Administrador', 3),
(null, 'Pedro de Paula Magalhães', 'Pedro Magalhães', '0', 'Bee@4634', 'Funcionário', 1),
(null, 'Manuel Barroco Filho', 'Manuel Barroco', '0', 'Mel@5012', 'Funcionário', 2),
(null, 'Gabriela Ferreira dos Campos', 'Gabriela dos Campos', '0', 'Abelhas@6432', 'Funcionário', 3);

select * from usuario;

insert into especie values -- null, nome, tipo, tempMin, tempMax, umiMin, umiMax, luminosidadeMin, luminosidadeMax
(null, 'Jataí', 'Tetragonisca angustula', 25.0, 35.3, 27.1, 64.9, 0, 700),
(null, 'Manduri', 'Melipona marginata', 30.0, 35.0, 27.1, 64.9, 0, 700),
(null, 'Uruçu-cinzenta', 'Melipona fasciculata', 30.0, 35.0, 27.1, 64.9, 0, 700),
(null, 'mandaçaia', 'Melipona quadrifasciata', 30.0, 35.0, 27.1, 64.9, 0,700),
(null, 'Tiúba', 'Melipona compressipes', 30.0, 35.0, 27.1, 64.9, 0, 700),
(null, 'Mirim nigriceps', 'Plebeia nigriceps', 30.0, 35.0, 27.1, 64.9, 0, 700);

select * from especie;

insert into colmeia values -- null, desc, status, localizacao, fkEmp, fkEspecie
(null, 'Abelhas Jataí', 'ideal', 'Bloco A', 1, 1),
(null, 'Abelhas Jataí', 'atenção', 'Bloco A', 1, 1),
(null, 'Abelhas Uruçu-cinzenta', 'alerta', 'Bloco B', 1, 3),
(null, 'Abelhas Uruçu-cinzenta', 'ideal', 'Bloco B', 1, 3);

select * from colmeia;

insert into sensores values -- null, nome, tipo, uniadeMedida, fkColmeia
(null, 'lm35', 'temperatura', '°C', 1),
(null, 'lm35', 'temperatura', '°C', 2),
(null, 'dht11', 'umidade', '%', 1),
(null, 'dht11', 'umidade', '%', 2);

select * from sensores;

insert into registros values -- null, valorRegistrado, dataHora, fkSensor
(null, 32.5, '2023-08-10 10:20:30', 1),
(null, 33, '2023-08-10 10:20:30', 2),
(null, 45, '2023-08-10 10:20:30', 3),
(null, 45, '2023-08-10 10:20:30', 4);

select * from registros;


-- mostrando os valores registrados, seus sensores e suas respectivas colmeias
select * from registros as r
join sensores as s
	on r.fkSensor = s.idSensor
join colmeia as c
	on c.idColmeia = s.fkColmeia;


-- mostrando dados da empresa junto com as colmeias
select * from empresa as e
join colmeia as c
	on c.fkEmpresa = e.idEmpresa
		where idEmpresa = 1;


-- mostrando usuarios e suas relações com as empresas

-- usuário Admin char(1)
select * from usuario as u
join empresa as e
	on e.idEmpresa = u.fkEmpresa;

