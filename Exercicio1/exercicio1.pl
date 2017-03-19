% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1
% Grupo 1

% Adriana Guedes
% Marco Barbosa 
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
% Extensao do predicado utente : IdUt, Nome, Idade, Rua, Cidade, Contacto-> { V, F }

utente( 1,'Carlos',35,'Rua D.Pedro V','Braga','253456789').
utente( 2,'Joao',12,'Rua da Ramada','Guimaraes','929876543').
utente( 3,'Julio',89,'Rua das Victorias','Guimaraes','935436789').
utente( 4,'Ana',25,'Rua Conde Almoster','Lisboa','913456789').
utente( 5,'Carolina',50,'Rua do Caires','Braga','253987654').
utente( 6,'Joana',23,'Av.da Boavista','Porto','961234567').
utente( 7,'Fernando',65,'Rua do Loureiro','Viana do Castelo','966668569').
utente( 8,'Rute',18,'Avenida da Liberdade','Braga','916386423').
utente( 9,'Maciel',45,'Rua das Flores','Porto','935731290').


% --------------------------------------------------------------
% Extensao do predicado cuidado_prestado: IdServ, Descrição, Instituição, Cidade -> { V, F }

cuidado_prestado( 1,'Pediatria','Hospital Privado de Braga','Braga').
cuidado_prestado( 2,'Cardiologia','Hospital de Braga','Braga').
cuidado_prestado( 3,'Ortopedia','Hospital de Braga','Braga').
cuidado_prestado( 4,'Oftalmologia','Hospital de Braga','Braga').
cuidado_prestado( 5,'Oncologia','IPO','Porto').
cuidado_prestado( 6,'Urgência','Hospital de Santa Maria','Porto').
cuidado_prestado( 7,'Urgência','Hospital da Luz','Guimaraes').
cuidado_prestado( 8,'Neurologia','Centro Hospitalar Sao Joao','Porto').
cuidado_prestado( 9,'Ortopedia','Hospital da Luz','Guimaraes').


% --------------------------------------------------------------
% Extensao do predicado ato_medico:  Data, IdUt, IdServ, CorPulseira, Médico, Custo -> { V, F }

atos( '01-03-17', 1, 6, 'Verde', 'Dra.Luisa', 25.5).
atos( '25-02-17', 1, 2, 'Sem_pulseira', 'Dr.Barroso', 12).
atos( '03-03-17', 3, 1, 'Sem_pulseira', 'Dra.Candida', 45).
atos( '11-01-17', 1, 1, 'Sem_pulseira', 'Dr.Pardal', 2).
atos( '12-02-17', 5, 1, 'Sem_pulseira', 'Dra.Teresa', 13.75).
atos( '27-01-17', 2, 7, 'Amarela', 'Dr.Pedro Martins', 11).
atos( '01-01-17', 6, 6, 'Laranja', 'Dr.Reveillon', 16).
atos( '24-02-17', 8, 4, 'Amarela', 'Dr.Mourao', 4).
atos( '08-03-17', 9, 8, 'Vermelha', 'Dr.Lima', 50).




% --------------------------------------------------------------

% Extensão do predicado comprimento : L , R -> {V,R} 
comprimento([],0).
comprimento([X|P],N) :- comprimento(P,G) , 
                        N is 1 + G.

remove(T) :- retract(T).

inserir(E) :- assert(E).
inserir(E) :- retract(E),!,fail.

% Extensão do predicado que permite a evolucao do conhecimento
evolucao(E) :- solucoes(I,+E::I,L),
               inserir(E),
               teste(L).

teste([]).
teste([X|Y]) :- X , teste(Y).

% Extensão do predicado que permite a procura do conhecimento
solucoes(X,Y,Z) :- findall(X,Y,Z).

% Extensão do predicado que permite o retrodecimento do conhecimento
retroceder(E) :- solucoes(I,+E::I,L),
                 teste(L),
                 remove(E).

% --------------------------------------------------------------
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

% -------------------------------------------------------------
% Identificar os utentes por critérios de seleção 

utenteID(ID,R) :- solucoes((ID,X,Y,Z,W,K),utente(ID,X,Y,Z,W,K),R).

utenteNome(NM,R) :- solucoes((X,NM,Y,Z,W,K),utente(X,NM,Y,Z,W,K),R).

utenteIdade(I,R) :- solucoes((X,Y,I,Z,W,K),utente(X,Y,I,Z,W,K),R).

utenteRua(RU,R) :- solucoes((X,Y,Z,RU,W,K),utente(X,Y,Z,RU,W,K),R).

utenteCidade(CDD,R) :- solucoes((X,Y,Z,W,CDD,K),utente(X,Y,Z,W,CDD,K),R).

utenteContacto(CNT,R) :- solucoes((X,Y,Z,W,K,CNT),utente(X,Y,Z,W,K,CNT),R).

% ---------------------------------------------------------
% Predicado que junta duas listas numa nova lista
% Extensao do predicado concat : L1, L2, L -> {V,F}

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

cuidCid(C,R) :- solucoes(S,cuidado_prestado(_,S,_,C),P),
                retiraRep(P,R).

% -------------------------------------------------------------
% Identificar os utentes de uma Instituição
% Extensao do predicado utentesInstituicao : I, L -> {V,F}

utentesInstituicao(I,R) :- solucoes(S, cuidado_prestado(S,_,I,_), P),
                           retiraRep(P,F),
                           utServ(F,R).
                           
utServ([S],R) :- utentesServico(S,R).
utServ([S|Ss],R) :- utentesServico(S,F),
                    utServ(Ss,P),
                    concat(F,P,R).

% -------------------------------------------------------------
% Identificar os utentes de um Serviço
% Extensao do predicado utentesServico : I, L -> {V,F}

utentesServico(S,R) :- solucoes(U, atos(_,U,S,_,_,_), P),
                       retiraRep(P,F),
                       idUt(F,R).

idUt([U],R) :- utenteID(U,R).
idUt([U|Us],R) :- utenteID(U,F),
                  idUt(Us,P),
                  concat(F,P,R).

% -------------------------------------------------------------
% Identificar os atos médicos realizados por utente
% Extensao do predicado atoUte : I, L -> {V,F}

atoUte(U,R) :- solucoes((X,U,Y,Z,W,Q), atos(X,U,Y,Z,W,Q), P),
               retiraRep(P,R).

% -------------------------------------------------------------
% Identificar os atos médicos realizados por instituição
% Extensao do predicado atoInst : I, L -> {V,F}

atoInst(I,R) :- solucoes(S, cuidado_prestado(S,_,I,_), F),
                retiraRep(F,P),
                servAto(P,R).

servAto([S],R) :- atoServ(S,R).
servAto([S|Ss],R) :- atoServ(S,F),
                     servAto(Ss,P),
                     concat(F,P,R). 

% -------------------------------------------------------------
% Identificar os atos médicos realizados por serviço
% Extensao do predicado atoServ : I, L -> {V,F}

atoServ(S,R) :- solucoes((X,Y,S,Z,W,Q), atos(X,Y,S,Z,W,Q), R).

% -------------------------------------------------------------
% Determinar todas as instituições a que um utente recorreu 
% Extensao do predicado nInstUte : I, L -> {V,F}

nInstUte(U,R) :- nServUte(U,F),
                 servicosInstituicao(F,P),
                 retiraRep(P,R).

servicosInstituicao([S],R) :- solucoes(I, cuidado_prestado(S,_,I,_), R).                    
servicosInstituicao([S|Ss],R) :-  solucoes(I, cuidado_prestado(S,_,I,_), P),
                                  servicosInstituicao(Ss,F),
                                  concat(P,F,R).

% -------------------------------------------------------------
% Determinar todas os serviços a que um utente recorreu 
% Extensao do predicado nServUte : I, L -> {V,F}

nServUte(U,R) :- solucoes(S, atos(_,U,S,_,_,_), P),
                 retiraRep(P,R).

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por utente 
% Extensao do predicado custoUte : I, L -> {V,F}

custoUte(U,R) :- atoUte(U,F),
                 atoCusto(F,R).

atoCusto([(_,_,_,_,_,C)],R) :- R is C.
atoCusto([(_,_,_,_,_,C)|Cs],R) :- atoCusto(Cs,F),
                              R is C+F.

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por serviço 
% Extensao do predicado custoServ : I, L -> {V,F}

custoServ(S,R) :- atoServ(S,F),
                  atoCusto(F,R).

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por instituição
% Extensao do predicado custoInst : I, L -> {V,F}

custoInst(I,R) :- atoInst(I,F),
                  atoCusto(F,R).

% -------------------------------------------------------------
% Calcular o custo total dos atos médicos por data 
% Extensao do predicado custoData : I, L -> {V,F}

custoData(D,R) :- solucoes((D,X,Y,Z,W,Q), atos(D,X,Y,Z,W,Q), F),
                  atoCusto(F,R).

% -------------------------------------------------------------
% Registar utentes
% Extensao do predicado registaUtentes : L,N,O,P -> {V,F}

registaUtentes(ID,NM,I,RU,CDD,CNT) :- evolucao(utente(ID,NM,I,RU,CDD,CNT)).  

% -------------------------------------------------------------
% Registar cuidados
% Extensao do predicado registaCuidados : L,M,N,O -> {V,F}

registaCuidados(ID,D,I,C) :- evolucao(cuidado_prestado(ID,D,I,C)).

% -------------------------------------------------------------
% Registar atos médicos
% Extensao do predicado registaAtos : L,M,N,O -> {V,F}

registaAtos(D,IDUT,IDS,CP,MDC,C) :- evolucao(atos(D,IDUT,IDS,CP,MDC,C)).

% -------------------------------------------------------------
% Remover utentes
% Extensao do predicado removeUtentes : L -> {V,F}

removeUtentes(U) :- solucoes((D,U,IDS),atos(D,U,IDS,_,_,_),R),
					removeTodosAtos(R),
					retroceder(utente(U,N,I,RU,CDD,CNT)).

removeTodosAtos([]).
removeTodosAtos([(D,IDUT,IDS)]) :- removeAtos(D,IDUT,IDS).
removeTodosAtos([(D,IDUT,IDS)|As]) :- removeAtos(D,IDUT,IDS),
										    removeTodosAtos(As).

% -------------------------------------------------------------
% Remover cuidados
% Extensao do predicado removeCuidados : L -> {V,F}

removeCuidados(I) :- retroceder(cuidado_prestado(I,D,C,Cid)).

% -------------------------------------------------------------
% Remover atos médicos
% Extensao do predicado removeAtos : L -> {V,F}

removeAtos(D,IDUT,IDS) :- retroceder(atos(D,IDUT,IDS,_,_,_)).
                               

% ---------------------------------------------------------
% EXTRAS
% ----------------------------------------------------------
% Numero de serviços de uma Instituição
% Extensão do predicado numeroServicos : I , R -> {V,F}

numeroServicos(I,R) :- solucoes(S, cuidado_prestado(S,_,I,_), P),
                       comprimento(P,T),
                       R is T.

% Numero de Utentes
% Extensão do predicado numeroUtentes : I -> {V,F}

numeroUtentes(R) :- solucoes(U,utente(U,_,_,_,_,_),L),
                    comprimento(L,T),
                    R is T.

% Numero de Atos
% Extensão do predicado numeroAtos : I -> {V,F}

numeroAtos(R) :- solucoes(A,atos(A,_,_,_,_,_),L),
                 comprimento(L,T),
                 R is T.


% Numero de Cores das Pulseira
% Extensão do predicado nCorPul : I -> {V,F}

nCorPul(R) :- solucoes(C,atos(_,_,_,C,_,_),X),
              retiraRep(X,L),
              comprimento(L,T),
              R is T.


% Cores das Pulseira
% Extensão do predicado corPuls : I -> {V,F}

corPuls(R) :- solucoes(C,atos(_,_,_,C,_,_),T),
              retiraRep(T,R).


