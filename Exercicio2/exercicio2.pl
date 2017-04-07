
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
utente( 9,'Maciel',45,rua_desconhecida,cidade_desconhecida,'935731290').
utente( 10,'Filipa',35,rua_desconhecida,cidade_desconhecida,contacto_desconhecido).
utente( 11,'Mauro',76,'Rua Gil Vicente','Montalegre',contacto_desconhecido).
utente( 12,'Laura',90,'Rua Fernando Mendes',cidade_desconhecida,'244000045').
utente( 13,'Jaime',50,rua_desconhecida,'Barcelos','914768180').
utente( 14,'Lourenço',idade_desconhecida,'Rua da Boavista','Guimaraes','926306127').
utente( 15,nome_desconhecido,16,'Rua Monsenhor de Melo','Vilamoura','936150873').


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
cuidado_prestado( 12,'Podologia',instituicao_desconhecida,'Vila Real').


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
atos( '30-01-17', 7, 5, cor_desconhecida, 'Dr.Quimio', custo_desconhecido).
atos( '01-02-17', 1, 6, 'Verde', 'Dra.Luisa', custo_desconhecido).
atos( '01-03-17', 10, 6, 'Verde', medico_desconhecido, 25.5).
atos( '10-03-17', 12, 11, cor_desconhecida, 'Dr.Luis', 12.50).


% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%			  		  FUNÇÕES GERAIS
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% Extensao do meta-predicado demo: Questao,Resposta -> {V, F, D}

demo( Questao,verdadeiro ) :- Questao.
demo( Questao, falso ) :- -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V, F, D}

nao( R ) :- R, !, fail.
nao( R ).

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ),!,fail.

evolucao(E) :- solucoes(I,+E::I,L),
               inserir(E),
               teste(L).

teste([]).
teste([X|Y]) :- X , teste(Y).

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento([],0).
comprimento([X|P],N) :- comprimento(P,G) , 
                        N is 1 + G.

remove(T) :- retract(T).

inserir(E) :- assert(E).
inserir(E) :- retract(E),!,fail.

retroceder(E) :- solucoes(I,+E::I,L),
                 teste(L),
                 remove(E).

% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%			  ADIÇÃO E REMOCÃO DE CONHECIMENTO
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


% -------------------------------------------------------------
% Registar utentes
% Extensao do predicado registaUtentes : L,N,O,P -> {V, F, D}

registaUtentes(ID,NM,I,RU,CDD,CNT) :- evolucao(utente(ID,NM,I,RU,CDD,CNT)).  

% -------------------------------------------------------------
% Registar cuidados
% Extensao do predicado registaCuidados : L,M,N,O -> {V, F, D}

registaCuidados(ID,D,I,C) :- evolucao(cuidado_prestado(ID,D,I,C)).

% -------------------------------------------------------------
% Registar atos médicos
% Extensao do predicado registaAtos : L,M,N,O -> {V, F, D}

registaAtos(D,IDUT,IDS,CP,MDC,C) :- evolucao(atos(D,IDUT,IDS,CP,MDC,C)).

% -------------------------------------------------------------
% Remover utentes
% Extensao do predicado removeUtentes : L -> {V, F, D}

removeUtentes(U) :- solucoes((D,U,IDS),atos(D,U,IDS,_,_,_),R),
          removeTodosAtos(R),
          retroceder(utente(U,N,I,RU,CDD,CNT)).

removeTodosAtos([]).
removeTodosAtos([(D,IDUT,IDS)]) :- removeAtos(D,IDUT,IDS).
removeTodosAtos([(D,IDUT,IDS)|As]) :- removeAtos(D,IDUT,IDS),
                        removeTodosAtos(As).

% -------------------------------------------------------------
% Remover cuidados
% Extensao do predicado removeCuidados : L -> {V, F, D}

removeCuidados(I) :- retroceder(cuidado_prestado(I,D,C,Cid)).

% -------------------------------------------------------------
% Remover atos médicos
% Extensao do predicado removeAtos : L -> {V, F, D}

removeAtos(D,IDUT,IDS) :- retroceder(atos(D,IDUT,IDS,_,_,_)).
                               


% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%					    INVARIANTES
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% Invariante Estrutural para utente:
% (não permite a inserção de conhecimento repetido)

+utente(I,Nome,IDD,RU,CDD,CNT) :: (solucoes(I,(utente(I,_,_,_,_,_)),L),
                        comprimento(L,N),
                        N == 1).


% --------------------------------------------------------------
% Invariante Estrutural para cuidado_prestado:
% (não permite a inserção de conhecimento repetido)

+cuidado_prestado(ID,D,I,X) ::(solucoes(ID,(cuidado_prestado(ID,_,_,_)),L),
                                comprimento(L,N),
                                 N == 1).

% --------------------------------------------------------------
% Invariante Estrutural para cuidado_prestado:
% não permite a inserção de conhecimento repetido

+atos(D,IDUT,IDS,CP,MDC,C) :: (solucoes((D,IDUT,IDS),(atos(D,IDUT,IDS,_,_,_)),L),
                              comprimento(L,N),
                              N == 1).

% ---------------------------------------------------------
% Invariante que certifica a existência de um ID de utente e de um ID servico

+atos(D,IDUT,IDS,CP,MDC,C) :: (utente(IDUT,_,_,_,_,_),
                              cuidado_prestado(IDS,_,_,_)).



% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%					CONHECIMENTO NEGATIVO
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


-utente(Id,Nome,Idade,Morada) :-
		nao(utente(Id,Nome,Idade,Morada)) ,
		nao(excecao(utente(Id,Nome,Idade,Morada))).


-atos(D,IdUt,IdServ,C,M,Ct) :- 
	  nao(atos(D,IdUt,IdServ,C,M,Ct)) , 
	  nao(excecao(atos(D,IdUt,IdServ,C,M,Ct))).


-cuidado_prestado(Id,D,I,C) :- 
				nao(cuidado_prestado(Id,D,I,C)) ,
				nao(cuidado_prestado(excecao(Id,D,I,C))).


% Um ato realizado no dia 05-04-17 foi realizado mas a cor da pulseira era
% desconhecida, mas sabemos que nãoe era vermelha

atos( '10-03-17', 10, 10, cor_desconhecida, 'Dr.Luis', 29).
-atos( '10-03-17', 10, 10, 'Vermelho', 'Dr.Luis', 29 ).

% Num cuidado prestado numa dada cidade não sabemos a instituição onde esse
% cuidado é realizado mas sabemos que não é realizado na Clínica Hospitalar de Faro 

cuidado_prestado( 13,'Radiografia',instituicao_desconhecida,'Faro').
-cuidado_prestado( 13,'Radiografia','Clínica Hospitalar de Faro','Faro').

% Um utente registado tem uma idade incerta mas sabemos que não 75 anos 

utente( 18,'Joaquina',idade_desconhecida,'Av.da Liberdade','Lisboa','962525258').
-utente( 18,'Joaquina',75,'Av.da Liberdade','Lisboa','962525258').


% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%					CONHECIMENTO INTERDITO
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% utente 16 tem contacto que ninguém pode conhecer

utente( 16,'Djalo',30,'Rua Tangente II','Arouca',nxpto).
excecao(utente(I,N,Id,R,C,Ct)) :- utente(I,N,Id,R,C,nxpto).
nulo(nxpto).
+utente(I,N,Id,R,C,Ct) :: (solucoes((I,N,Id,R,C,Ct), (utente(16,'Djalo',30,'Rua Tangente II','Arouca',Ct),nao(nulo(Ct))),S), 
							comprimento( S,N ) ,
							N == 0).

% utente 17 tem idade que ninguém pode conhecer

utente( 17,'Maria de Jesus',ixpto,'Rua dos Videiras','Estoril','922225014').
excecao(utente(I,N,Id,R,C,Ct)) :- utente(I,N,ixpto,R,C,Ct).
nulo(ixpto).
+utente(I,N,Id,R,C,Ct) :: (solucoes((I,N,Id,R,C,Ct), (utente(17,'Maria de Jesus',Id,'Rua dos Videiras','Estoril','922225014'),nao(nulo(Id))),S), 
							comprimento( S,N ) ,
							N == 0).

% ato do dia 1-04-2017 tem um medico que ninguém pode conhecer

atos( '01-04-17', 2, 10, 'Verde', medxpto, 27.5).
excecao(atos(D,IdUt,IdS,C,Dt,P)) :- atos(D,IdUt,IdS,C,medxpto,P).
nulo(medxpto).
+atos(D,IdUt,IdS,C,Dt,P) :: ( solucoes((D,IdUt,IdS,C,Dt,P), (atos('01-04-17', 2, 10, 'Verde', Dt, 27.5), nao(nulo(Dt))),S),
							comprimento( S,N ),
							N == 0).

% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%				CONHECIMENTO IMPRECISO (valor nulo impreciso)
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% um ato pode ter custado 50 ou 150 euros
excecao(atos( '1-03-17', 12, 11, 'Sem_pulseira', 'Dr.Luisa', 50)).
excecao(atos( '1-03-17', 12, 11, 'Sem_pulseira', 'Dr.Luisa', 150)).

% uma pulseira pode ter a cor verde ou vermelho euros
excecao(atos( '07-04-17', 12, 11, 'Verde', 'Dr.Luisa', 250)).
excecao(atos( '07-04-17', 12, 11, 'Verde', 'Dr.Luisa', 250)).

% um ato pode ter sido feito pelo Dr.João ou pela Dr.Roberto
excecao(atos( '07-04-17', 12, 11, 'Verde', 'Dr.João', 250)).
excecao(atos( '07-04-17', 12, 11, 'Verde', 'Dr.Roberto', 250)).

% um cuidadado pode ter prestado em dois distintos hospitais
excecao(cuidado_prestado( 13,'Pediatria','Hospital Privado do Alagarve','Faro')).
excecao(cuidado_prestado( 13,'Pediatria','Hospital de Faro','Faro')).

% um utente com o mesmo ID pode estar registado com diferentes
% nomes do seu nome completo
excecao(utente( 18,'Carlos',33,'Avenida 25 de Abril','Santarém','935694789')).
excecao(utente( 18,'Carlos Alberto',33,'Avenida 25 de Abril','Santarém','935694789')).

% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%					CONHECIMENTO INCERTO
% ///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

% UTENTES -----------------------------------------------------
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


% ATOS ---------------------------------------------------------------


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


% CUIDADOS PRESTADOS --------------------------------------------------


% Instituição desconhecida
excecao(cuidado_prestado(Id,D,I,C)) :- 
			cuidado_prestado(Id,D,instituicao_desconhecida,C).
