create database apicontrol;

use apicontrol;

-- Tabela USUÁRIO
create table usuario(
id_usuario int primary key auto_increment,
nome varchar(50),
email varchar(100) unique,
senha varchar(45),
cnpj char(14),
data_cadastro datetime default current_timestamp,
telefone char(12),
fk_endereco int  -- Adicionado a coluna fk_endereco para receber a chave estrangeira da tabela endereco
);

desc usuario;

-- Dados mocados na tabela USUARIO
insert into usuario (nome, email, senha, cnpj, telefone) values 
('Apiario Caminho do Sol', 'caminhodosol@gmail.com', '123456789', '12345678965412', '71956478922'),
('Familia do mel', 'caminho@gmail.com', '123456788', '12345678965XXX', '71952418677'),
('Mel e companhia', 'companhia@gmail.com', '1234569878','56412698745215', '11956325475');

select * from usuario;

-- Tabela ENDEREÇO
create table endereco (
id_endereco int primary key auto_increment,
estado char(2),
cidade varchar(40),
cep char(8),
bairro varchar(40),
logradouro varchar(100),
numero varchar(15),
complemento varchar(20)
) auto_increment = 100;
 
-- Determinando a coluna fk_endereco como a cheve estrangeria da minha tabela usuario
alter table usuario add constraint fkEnd 
	foreign key (fk_endereco) 
		references endereco (id_endereco);

-- Dados mocados na tabela endereço
insert into endereco (estado, cidade, cep, bairro, logradouro, numero, complemento) values
	('BA', 'Salvador', '40015110', 'Rua Julio Carreira', 'Comércio', '55', null),
    ('BA', 'Salvador', '40015035', 'Comércio',' Avenida Jequitaia', 45, null ),
    ('SP', ' Araras', '13607730', 'Jardim Santa Olívia II', 'Rua 7', 103, null);
  
select * from endereco;

update usuario set fk_endereco = 100
	where id_usuario = 2;
    
update usuario set fk_endereco = 101
	where id_usuario = 1;
    
update usuario set fk_endereco = 102
	where id_usuario = 3;
    
select * from usuario;

-- Tabela SENSOR (terá dados adicionados posteriormente pelo aurduino)
create table sensor(
id_sensor int primary key auto_increment,
temperatura float,
data_hora_coleta datetime default current_timestamp
);
    
desc sensor;

insert into sensor (temperatura) values
(32),
(22),
(27),
(18);

select * from sensor;

-- Tabela ESPECIE
create table especie (
id_especie int primary key auto_increment,
nome varchar (40),
tipo varchar(40),
temperatura_minima float null, -- default null
temperatura_maxima float null,
umidade_minima float null,
umidade_maxima float null
)auto_increment = 100;

insert into especie (nome, tipo, media_producao_ano, media_valor_mel_kg) values
	('Abelha Europeia', 'Apis mellifera', 28, 30),
    ('Abelha Mandaçaia', 'Melipona quadrifasciata',null, null),
    ('Abelha Uruçu', 'Melipona scutellaris', null, null),
    ('Abelha jataí', 'Tetragonisca Angustula', 15, 180),
    ('Abelha uruçu-amarela', 'Melipona rufiventris', 5, 400);

select * from especie;

-- Tabela COLMEIA
create table colmeia(
id_colmeia int primary key auto_increment,
descricao varchar(200),
status_colmeia varchar(40),
localizacao varchar(40),
fk_sensor int,
fk_usuario int,
fk_especie int
) auto_increment = 1000; 

-- Definido a coluna fksensor para ser a chave estrangeira, com referencia no idSensor da tabela sensor
alter table colmeia add constraint fkssr
	foreign key (fk_sensor)
		references  sensor(id_sensor);

-- Definindo a coluna fkusuario para ser a chave estrangeria com a referencia do ID da tabela usuario
alter table colmeia add constraint fkusr
	foreign key (fk_usuario)
		references usuario (id_usuario);
        
-- Definindo a coluna fkusuario para ser a chave estrangeria com a referencia do ID da tabela usuario
alter table colmeia add constraint fkepc
	foreign key (fk_especie)
		references especie (id_especie);
        
-- adicionando uma constrain na colmeia
Alter table colmeia add constraint chkstatus 
	check (status_colmeia in ('Ideal','Médio','Crítico')
);

desc colmeia;

insert into colmeia (descricao, status_colmeia, localizacao, fk_sensor, fk_usuario, fk_especie) values
	('Colmeia Revisada recentemente','Ideal', 'Corredor 3', 1, 1, 103),
    ('Colmeia Revisada no ano de 2023 ', 'Crítico', 'Coredor 1', 4, 2, 101),
    ('Esta colmeia produziu bem ano passado', 'Médio', 'Corredor 2', 2, 3, 102);

select * from colmeia;

-- TABELAS API CONTROL
show tables;





-- Exibindo a especie da abela a localizaçãoe e o sensor associado a essa colmeia
select colmeia.especie as ESPECIE_ABELHA, colmeia.localizacao as CORREDOR_COLMEIA, sensor.id_sensor as ID_SENSOR
	from sensor join colmeia
		on id_sensor = fksensor_id;

-- Exibindo a colmeia e a temperatura do sensor de temperatura associado a cada colmeia
select colmeia.especie as ESPECIE_ABELHA, sensor.temperatura as TEMPERATURA_ENXAME 
	from sensor join colmeia
		on id_sensor = fksensor_id;
        
-- Exibindo o a quantidade de enxames que o usuario com o id 1000 tem e o status dessas colmeis
select status_colmeia as STATUS_DA_COLMEIA, usuario.nome as NOME_DO_APIARIO, colmeia.especie as ESPECIE_ABELHA, endereco.estado as ESTADO_EMPRESA
	from usuario join colmeia
		on id_usuario = fk_usuario
			join endereco 
				on id_endereco = fk_endereco
					where id_usuario in (1002, 1000);
                    
select id_usuario, usuario.nome as NOME_APIARIO,  especie.nome as NOME_ABELHA, colmeia.status_colmeia as STATUS_DA_COLMEIA, sensor.temperatura as TEMPERATURA_ATUAL, especie.temperatura_ideal as TEMPERATURA_IDEAL
	from usuario join colmeia
		on id_usuario = fk_usuario
			join especie
				on id_especie = fk_especie
					join sensor
						on id_sensor = fksensor_id
							where id_usuario = 1002;
					
select * from colmeia;
select * from usuario;
select * from sensor;
select * from especie;

truncate table colmeia;

desc colmeia;
