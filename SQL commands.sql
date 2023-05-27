CREATE SEQUENCE IF NOT EXISTS id_seq 
INCREMENT 1
MINVALUE 1
MAXVALUE 999999999
START 1
CACHE 1;

CREATE TABLE USUARIO (
ID_USUARIO integer DEFAULT nextval('id_seq') primary key,
NOME VARCHAR(80),
IDADE INTEGER,
EMAIL VARCHAR(60)
);

INSERT INTO USUARIO(nome, idade, email) VALUES('ALLAN VITHANI',24,'ALLANVITHANI@GMAIL.COM');

select * from usuario;

create table bkp_usuario(
	id_bkp_usuario serial primary key,
	id_usuario integer not null,
	nome varchar(80) not null,
	idade integer not null,
	email varchar(60) not null
    );
	
	create or replace function fnc_bkp_usuario()
	returns trigger as $$
	begin
	insert into bkp_usuario(id_usuario,nome,idade,email) values(old.id_usuario, old.nome,old.idade,old.email);
	return OLD;
	end
	$$ language 'plpgsql';
	
	
	create trigger trg_bkp_usuario 
	before delete on usuario
	for each row
	execute procedure fnc_bkp_usuario();
	
	
	
	
	delete from usuario;
	
	select * from bkp_usuario;
