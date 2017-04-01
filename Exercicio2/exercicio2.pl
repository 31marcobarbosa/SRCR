
% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 2
% Grupo 1

% Adriana Guedes
% Marco Aurélio Barbosa
% Guilherme Guerreiro
% Ricardo Certo

%-----------------------------------------------------------------------
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').

% -------------------------------------------------------------------------------------------
% BASE DE CONHECIMENTO
%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre cuidado prestado, ato médico , utente


:- dynamic(utente/6).
:- dynamic(cuidado_prestado/4).
:- dynamic(atos/6).

% --------------------------------------------------------------
% Extensao do predicado utente : IdUt, Nome, Idade, Rua, Cidade, Contacto-> { V, F , D }

utente( 1,'Carlos',35,'Rua D.Pedro V','Braga','253456789').
utente( 2,'Joao',12,'Rua da Ramada','Guimaraes','929876543').
utente( 3,'Julio',89,'Rua das Victorias','Guimaraes','935436789').
utente( 4,'Ana',25,'Rua Conde Almoster','Lisboa','913456789').
utente( 5,'Carolina',50,'Rua do Caires','Braga','253987654').
utente( 6,'Joana',26,'Av.da Boavista','Porto','961234567').
utente( 7,'Fernando',65,'Rua do Loureiro','Viana do Castelo','966668569').
utente( 8,'Rute',18,'Av. da Liberdade','Braga','916386423').
utente( 9,'Maciel',45,'Rua das Flores','Porto','935731290').
utente( 10,'Filipa',35,'Rua Padre Vitorino','Faro','289347681').
utente( 11,'Mauro',76,'Rua Gil Vicente','Montalegre','276327904').
utente( 12,'Laura',90,'Rua Fernando Mendes','Leiria','244000045').
utente( 13,'Jaime',50,'Av. Norton Matos','Barcelos','914768180').
utente( 14,'Lourenço',26,'Rua da Boavista','Guimaraes','926306127').
utente( 15,'Tiago',16,'Rua Monsenhor de Melo','Vilamoura','936150873').


% --------------------------------------------------------------
% Extensao do predicado cuidado_prestado: IdServ, Descrição, Instituição, Cidade -> { V, F, D }

cuidado_prestado( 1,'Pediatria','Hospital Privado de Braga','Braga').
cuidado_prestado( 2,'Cardiologia','Hospital de Braga','Braga').
cuidado_prestado( 3,'Ortopedia','Hospital de Braga','Braga').
cuidado_prestado( 4,'Oftalmologia','Hospital de Braga','Braga').
cuidado_prestado( 5,'Oncologia','IPO','Porto').
cuidado_prestado( 6,'Urgência','Hospital de Santa Maria','Porto').
cuidado_prestado( 7,'Urgência','Hospital da Luz','Guimaraes').
cuidado_prestado( 8,'Neurologia','Centro Hospitalar Sao Joao','Porto').
cuidado_prestado( 9,'Urgência','Hospital de Braga','Braga').
cuidado_prestado( 10,'Urgência','Hospital Lusiadas','Faro').
cuidado_prestado( 11,'Otorrinolaringologia','Hospital de Vila Real','Vila Real').


% --------------------------------------------------------------
% Extensao do predicado ato_medico:  Data, IdUt, IdServ, CorPulseira, Médico, Custo -> { V, F, D }

atos( '02-01-17', 15, 10, 'Verde', 'Dra.Sara', 17.5).
atos( '24-02-17', 8, 4, 'Sem_pulseira', 'Dr.Mourao', 4).
atos( '25-02-17', 1, 2, 'Sem_pulseira', 'Dr.Barroso', 12).
atos( '28-01-17', 13, 9, 'Laranja', 'Dr.Tomas', 5).
atos( '10-02-17', 4, 3, 'Sem_pulseira', 'Dr.Falcão', 20).
atos( '19-03-17', 3, 8, 'Amarela', 'Dr.Bones', 50).
atos( '11-01-17', 1, 1, 'Sem_pulseira', 'Dr.Pardal', 2).
atos( '12-02-17', 5, 8, 'Sem_pulseira', 'Dra.Teresa', 13.75).
atos( '20-03-17', 11, 11, 'Sem_pulseira', 'Dra.Marta', 13).
atos( '27-01-17', 2, 7, 'Amarela', 'Dr.Pedro Martins', 11).
atos( '01-01-17', 6, 6, 'Laranja', 'Dr.Reveillon', 50).
atos( '03-03-17', 3, 1, 'Sem_pulseira', 'Dra.Candida', 45).
atos( '08-03-17', 9, 9, 'Vermelha', 'Dr.Lima', 50).
atos( '14-02-17', 14, 7, 'Amarela', 'Dra.Mafalda', 23).
atos( '30-01-17', 7, 5, 'Sem_pulseira', 'Dr.Quimio', 10).
atos( '01-02-17', 1, 6, 'Verde', 'Dra.Luisa', 25.5).
atos( '01-03-17', 10, 6, 'Verde', 'Dra.Luisa', 25.5).
atos( '10-03-17', 12, 11, 'Sem_pulseira', 'Dr.Luis', 12.50).


% --------------------------------------------------------------


-utente(Id,Nome,Idade,Morada) :-
		nao(utente(Id,Nome,Idade,Morada)) ,
		nao(excecao(utente(Id,Nome,Idade,Morada))).


% nome desconhecido
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,nome_desconhecido,Idd,R,C,Con).

% idade desconhecida
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,N,idade_desconhecida,R,C,Con).

% rua desconhecida
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,N,Idd,rua_desconhecida,C,Con).

% cidade desconhecida
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,N,Idd,R,cidade_desconhecida,Con).

% contacto desconhecido
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,N,Idd,R,C,contacto_desconhecido).

% rua , cidade e contacto desconhecidos
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,N,Idd,rua_desconhecida,cidade_desconhecida,contacto_desconhecido).

% rua e cidade desconhecidos
excecao(utente(I,N,Idd,R,C,Con)) :- 
		utente(I,N,Idd,rua_desconhecida,cidade_desconhecida,Con).



% --------------------------------------------------------------

-atos(D,IdUt,IdServ,C,M,Ct) :- 
	  nao(atos(D,IdUt,IdServ,C,M,Ct)) , 
	  nao(excecao(atos(D,IdUt,IdServ,C,M,Ct))).


% Cor Pulseira desconhecida
excecao(atos(D,IdUt,IdServ,C,M,Ct)) :-
		 atos(D,IdUt,IdServ,cor_desconhecida,M,Ct).

% Médico desconhecido
excecao(atos(D,IdUt,IdServ,C,M,Ct)) :-
		 atos(D,IdUt,IdServ,C,medico_desconhecido,Ct).

% Custo Desconhecido  
excecao(atos(D,IdUt,IdServ,C,M,Ct)) :-
		 atos(D,IdUt,IdServ,C,M,custo_desconhecido).

% Pulseira e custo desconhecidos
excecao(atos(D,IdUt,IdServ,C,M,Ct)) :-
		 atos(D,IdUt,IdServ,cor_desconhecida,M,custo_desconhecido).


% --------------------------------------------------------------

-cuidado_prestado(Id,D,I,C) :- 
				nao(cuidado_prestado(Id,D,I,C)) ,
				nao(cuidado_prestado(excecao(Id,D,I,C))).

% Instituição desconhecida
excecao(cuidado_prestado(Id,D,I,C)) :- 
			cuidado_prestado(Id,D,instituicao_desconhecida,C).

% --------------------------------------------------------------
% 
% --------------------------------------------------------------

% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :- Questao.
demo( Questao, falso ) :- -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( R ) :- R, !, fail.
nao( R ).

% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%					    INVARIANTES
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\




% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%					CONHECIMENTO INTERDITO
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% utente 16 tem contacto que ninguém pode conhecer

utente( 16,'Djalo',30,'Rua Tangente II','Arouca',nxpto).
excecao(utente(I,N,Id,R,C,Ct)) :- utente(I,N,Id,R,C,nxpto).
