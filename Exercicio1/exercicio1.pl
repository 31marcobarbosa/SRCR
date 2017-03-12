

% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1
% Grupo 1


%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').


%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre cuidado prestado, ato médico , utente


:- dynamic( utente/4 ).
:- dynamic( cuidado_prestado/4 ).
:- dynamic( ato_medico/4 ).


% --------------------------------------------------------------
% Extensao do predicado utente : IdUt, Nome, Idade, Morada -> { V, F }

utente( 1,carlos,35,braga ).
utente( 2,joao,12,barcelos ).
utente( 3,julio,89,porto ).
utente( 4,ana,25,lisboa ).
utente( 5,carolina,50,braga ).


% --------------------------------------------------------------
% Extensao do predicado cuidado_prestado: IdServ, Descrição, Instituição, Cidade -> { V, F }

cuidado_prestado( 1,pediatria,hospital,braga ).
cuidado_prestado( 2,geral,hospital,braga ).
cuidado_prestado( 3,ortopedia,hospital,braga ).
cuidado_prestado( 4,oftalmologia,hospital,braga ).
cuidado_prestado( 5,oncologia,ipo,porto ).


% --------------------------------------------------------------
% Extensao do predicado ato_medico:  Data, IdUt, IdServ, Custo -> { V, F }

ato_medico( 1-3-17,1,1,25.5 ).
ato_medico( 25-2-17,1,1,12 ).
ato_medico( 3-3-17,1,1,45 ).
ato_medico( 11-1-17,1,1,2 ).
ato_medico( 12-2-17,1,1,13.75 ).


% --------------------------------------------------------------
% Invariante Estrutural para utente:
% (não permite a inserção de conhecimento repetido)

+utente(I,N,Idd,M) :: (findall((I,N,Idd,M),(utente(I,N,Idd,M)),L),
						comprimento(L,N),
						N == 1).


% --------------------------------------------------------------
% Invariante Estrutural para cuidado_prestado:
% (não permite a inserção de conhecimento repetido)

+cuidado_prestado(Id,D,I,L) :: (findall((Id,D,I,L),(cuidado_prestado(Id,D,I,L)),L),
								comprimento(L,N),
								 N == 1).


% --------------------------------------------------------------
% Invariante Estrutural para cuidado_prestado:
% (não permite a inserção de conhecimento repetido)

+ato_medico(D,IDut,IDser,C) :: (findall((D,IDut,IDser,C),(utente(D,IDut,IDser,C)),L),
									comprimento(L,N),
									N == 1).


% --------------------------------------------------------------
% Extensão do predicado de comprimento: L,Tam -> {V,F} 

comprimento([],0).
comprimento([_|Xs],N) :- comprimento(Xs,G) , N is 1 + G.


% -------------------------------------------------------------
% Identificar os utentes por critérios de seleção
% 

% -------------------------------------------------------------
% Identificar as instituições prestadoras de cuidados de saúde
% Extensao do predicado instCuidSaud : I -> {V,F}

instCuidSaud([I]) :- cuidado_prestado(_,_,I,_).
instCuidSaud([X|Xs]) :- cuidado_prestado(_,_,X,_) ,
						instCuidSaud(Xs).

% -------------------------------------------------------------
% Identificar os cuidados prestados por instituição
% Extensao do predicado cuidInst : I, L -> {V,F}

cuidInst(I,[X]) :- cuidado_prestado(_,X,I,_).
cuidInst(I,[X|Xs]) :- cuidado_prestado(_,X,I,_) , 
					  cuidInst(I,Xs).

% -------------------------------------------------------------
% Identificar os cuidados prestados por serviço
% Extensao do predicado cuidServ : I, L -> {V,F}



% -------------------------------------------------------------
% Identificar os utentes de uma Instituição
% Extensao do predicado utentesInstituicao : I, L -> {V,F}

% -------------------------------------------------------------
% Identificar os utentes de um Serviço
% Extensao do predicado utentesServico : I, L -> {V,F}

% -------------------------------------------------------------
% Identificar os atos médicos realizados por utente
% Extensao do predicado atoUte : I, L -> {V,F}

% -------------------------------------------------------------
% Identificar os atos médicos realizados por instituição
% Extensao do predicado atoInst : I, L -> {V,F}

% -------------------------------------------------------------
% Identificar os atos médicos realizados por serviço
% Extensao do predicado atoServ : I, L -> {V,F}

% -------------------------------------------------------------
% Determinar todas as instituições a que um utente recorreu 
% Extensao do predicado nInstUte : I, L -> {V,F}

% -------------------------------------------------------------
% Determinar todas os serviços a que um utente recorreu 
% Extensao do predicado nServUte : I, L -> {V,F}

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por utente 
% Extensao do predicado custoUte : I, L -> {V,F}

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por serviço 
% Extensao do predicado custoServ : I, L -> {V,F}

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por instituição
% Extensao do predicado custoInst : I, L -> {V,F}

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por data 
% Extensao do predicado custoData : I, L -> {V,F}

% -------------------------------------------------------------
% Registar utentes
% Extensao do predicado registaUtente : L -> {V,F}

registaUtente(Id,N,I,M) :- evolucao(utente(Id,N,I,M)).

% -------------------------------------------------------------
% Registar cuidados
% Extensao do predicado registaCuidados : L -> {V,F}

registaCuidados(Id,D,I,C) :- evolucao(cuidado_prestado(Id,D,I,C)).

% -------------------------------------------------------------
% Registar atos médicos
% Extensao do predicado registaAtos : L -> {V,F}

registaAtos(D,IdUt,IdServ,C) :- evolucao(ato_medico(D,IdUt,IdServ,C)).

% -------------------------------------------------------------
% Remover utentes
% Extensao do predicado removeUtentes : L -> {V,F}

removeUtentes(U) :- findall((U,N,I,M),utente(U,N,I,M), L),
					retractUtentes(L).


retractUtentes([Id,N,I,M]) :- retract(utente(Id,N,I,M)).
retractUtentes([Id,N,I,M|Xs]) :- retract(utente(Id,N,I,M)) ,
								 retractUtentes(Xs).


% -------------------------------------------------------------
% Remover cuidados
% Extensao do predicado removeCuidados : L -> {V,F}

removeCuidados(C) :- findall((C,D,I,Cid),cuidado_prestado(C,D,I,Cid), L),
					 retractCuidados(L).


retractCuidados([C,D,I,Cid]) :- retract(cuidado_prestado(C,D,I,Cid)).
retractCuidados([C,D,I,Cid|Xs]) :- retract(cuidado_prestado(C,D,I,Cid)),
								   retractCuidados(Xs).

% -------------------------------------------------------------
% Remover atos médicos
% Extensao do predicado removeAtos : L -> {V,F}

removeAtos(D,IdUt,IdServ,X) :- findall((D,IdUt,IdServ,X),ato_medico(D,IdUt,IdServ,X), L),
					 		   retractAtos(L).


retractAtos([D,IdUt,IdServ,X]) :- retract(ato_medico(D,IdUt,IdServ,X)).
retractAtos([D,IdUt,IdServ,X|Xs]) :- retract(ato_medico(D,IdUt,IdServ,X)),
									 retractAtos(Xs)







% -------------------------------------------------------------
% Extensao do meta-predicado nao: P -> {V,F}

nao(P) :-
  P, !, fail.
nao(_).


% -------------------------------------------------------------
% Extensão do predicado que permite a evolucao do conhecimento


evolucao(E) :- findall(I,+E::I,L),
			   inserir(E),
			   teste(L).

% assert = adicionar informação
% retract = remover informação

inserir(E) :- assert(E).
inserir(E) :- retract(E),!,fail.

teste([]).
teste([X|xs]) :- X , teste(Xs).