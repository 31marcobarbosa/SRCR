
% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1
% Grupo 1


:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').


%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre cuidado prestado, ato médico , utente


:- dynamic utente/4 .
:- dynamic cuidado_prestado/4 .
:- dynamic atos/4 .


% --------------------------------------------------------------
% Extensao do predicado utente : IdUt, Nome, Idade, Morada -> { V, F }

utente( 1,'carlos',35,'braga' ).
utente( 2,'joao',12,'barcelos' ).
utente( 3,'julio',89,'porto' ).
utente( 4,'ana',25,'lisboa' ).
utente( 5,'carolina',50,'braga' ).


% --------------------------------------------------------------
% Extensao do predicado cuidado_prestado: IdServ, Descrição, Instituição, Cidade -> { V, F }

cuidado_prestado( 1,'Pediatria','Hospital','Braga' ).
cuidado_prestado( 2,'geral','hospital','braga' ).
cuidado_prestado( 3,'ortopedia','hospital','braga' ).
cuidado_prestado( 4,'oftalmologia','hospital','braga' ).
cuidado_prestado( 5,'oncologia','ipo','porto' ).


% --------------------------------------------------------------
% Extensao do predicado ato_medico:  Data, IdUt, IdServ, Custo -> { V, F }

atos( '1-3-17',1,1,'25.5' ).
atos( '25-2-17',1,1,'12' ).
atos( '3-3-17',1,1,'45' ).
atos( '11-1-17',1,1,'2' ).
atos( '12-2-17',1,1,'13.75' ).

% --------------------------------------------------------------
% % Extensão do predicado que permite a evolucao do conhecimento

comprimento([],0).
comprimento([X|P],N) :- comprimento(P,G) , 
                        N is 1 + G.

remove(T) :- retract(T).

inserir(E) :- assert(E).
inserir(E) :- retract(E),!,fail.

evolucao(E) :- solucoes(I,+E::I,L),
               inserir(E),
               teste(L).

teste([]).
teste([X|Y]) :- X , teste(Y).

solucoes(X,Y,Z) :- findall(X,Y,Z).

retroceder(E) :- solucoes(I,+E::I,L),
                 teste(L),
                 remove(E).

% --------------------------------------------------------------
% Invariante Estrutural para utente:
% (não permite a inserção de conhecimento repetido)

+utente(I,Nome,IDD,M) :: (solucoes(I,(utente(I,_,_,_)),L),
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

+atos(D,IDUT,IDS,C) :: (solucoes((D,IDUT,IDS),(atos(D,IDUT,IDS,_)),L),
                              comprimento(L,N),
                              N == 1).

% ---------------------------------------------------------
% Invariante que certifica a existência de um ID de utente e de um ID servico

+atos(D,IDUT,IDS,C) :: (utente(IDUT,_,_,_),
                              cuidado_prestado(IDS,_,_,_)).

% -------------------------------------------------------------
% Identificar os utentes por critérios de seleção 

utentesID(ID,R) :- solucoes((ID,X,Y,Z),utente(ID,X,Y,Z),R).

utentesNome(NM,R) :- solucoes((X,NM,Y,Z),utente(X,NM,Y,Z),R).

utentesIdade(I,R) :- solucoes((X,Y,I,Z),utente(X,Y,I,Z),R).

utentesLugar(L,R) :- solucoes((X,Y,Z,L),utente(X,Y,Z,L),R).

% ---------------------------------------------------------


concat([],L2,L2).
concat(L1,[],L1).
concat([X|L1],L2,[X|L]) :- concat(L1,L2,L).


% -------------------------------------------------------------
% Identificar as instituições prestadoras de cuidados de saúde
% Extensao do predicado instCuidSaud : I -> {V,F}

instCuidSaud(R) :- solucoes(I,cuidado_prestado(_,_,I,_),L),
                   retiraRep(L,R).

retiraRep([],[]).
retiraRep([X|A],R) :- retiraEle(X,A,L),
                      retiraRep(L,T),
                      R = [X|T].

retiraEle(A,[],[]).
retiraEle(A,[A|Y],T) :- retiraEle(A,Y,T).
retiraEle(A,[X|Y],T) :- X \== A,
                        retiraEle(A,Y,R),
                        T = [X|R].

% -------------------------------------------------------------
% Identificar os cuidados prestados por instituição
% Extensao do predicado cuidInst : I, L -> {V,F}

cuidInst(I,R) :- solucoes(C,cuidado_prestado(_,C,I,_),R).

% -------------------------------------------------------------
% Identificar os cuidados prestados por cidade
% Extensao do predicado cuidCid : I, L -> {V,F}

cuidCid(C,R) :- solucoes((C,S),cuidado_prestado(_,S,_,C),P),
                 retiraRep(P,R).


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

regista(E) :- evolucao(E).

registaUtentes(I,N,O,P) :- evolucao(utente(I,N,O,P)).  

% -------------------------------------------------------------
% Registar cuidados
% Extensao do predicado registaCuidados : L -> {V,F}

registaCuidados(ID,D,I,C) :- evolucao(cuidado_prestado(ID,D,I,C)).

% -------------------------------------------------------------
% Registar atos médicos
% Extensao do predicado registaAtos : L -> {V,F}

registaAtos(D,IDUT,IDS,C) :- evolucao(atos(D,IDUT,IDS,C)).

% -------------------------------------------------------------
% Remover utentes
% Extensao do predicado removeUtentes : L -> {V,F}

removeUtentes(U) :- retroceder(utente(U,N,I,M)).

% -------------------------------------------------------------
% Remover cuidados
% Extensao do predicado removeCuidados : L -> {V,F}

removeCuidados(I) :- retroceder(cuidado_prestado(I,D,C,Cid)).

% -------------------------------------------------------------
% Remover atos médicos
% Extensao do predicado removeAtos : L -> {V,F}

removeAtos(D,IDUT,IDS) :- retroceder(atos(D,IDUT,IDS,_)).
                               


