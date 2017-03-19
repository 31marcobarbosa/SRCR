
% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1
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
% Extensao do predicado utente : IdUt, Nome, Idade, Rua, Cidade, Contacto-> { V, F }

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
% Extensao do predicado cuidado_prestado: IdServ, Descrição, Instituição, Cidade -> { V, F }

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
% Extensao do predicado ato_medico:  Data, IdUt, IdServ, CorPulseira, Médico, Custo -> { V, F }

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


% Numero de Cores de uma dada Pulseira
% Extensão do predicado nCorPul : I , L -> {V,F}

nCorPul(C,R) :- solucoes(C,atos(_,_,_,C,_,_),L),
              comprimento(L,T),
              R is T.


% Cores das Pulseira
% Extensão do predicado corPuls : I -> {V,F}

corPuls(C,R) :- solucoes(C,atos(_,_,_,C,_,_),T),
              retiraRep(T,R).

% Ato Médico Mais Caro Registado até ao Momento
% Extensão do predicado msCro : I -> {V,F}

msCro(R) :- solucoes(Q,atos(_,_,_,_,_,Q),T),
            maxLst(T,0,C),
            solucoes((X,U,Y,Z,W,C), atos(X,U,Y,Z,W,C),K),
            servAtos(K,R).

servAtos([(_,_,S,_,_,_)],R) :- solucoes((S,B,C,D), cuidado_prestado(S,B,C,D), R).
servAtos([(_,_,S,_,_,_)|Cs],R) :- solucoes((S,B,C,D), cuidado_prestado(S,B,C,D), P),
                                  servAtos(Cs,F),
                                  concat(P,F,R). 

maxLst([C],K,R) :- maior(C,K,X),
                   R is X.
maxLst([C|Cs],K,R) :- maior(C,K,X),
                      maxLst(Cs,X,R).

maior(X,Y,X) :- X >= Y.
maior(X,Y,Y) :- Y > X.


% Ordenar os Atos Médicos Registados até ao Momento
% Extensão do predicado ordCst : I -> {V,F}

ordCst(R) :- solucoes(Q,atos(_,_,_,_,_,Q),T),
             ordenaL(T,R). 


ordenaL([X],[X]).
ordenaL([H|T],OL) :- ordenaL(T,OT),
                     insr(H,OT,OL).

insr(X,[],[X]).
insr(X,[H|T],[X,H|T]) :- X =< H.
insr(X,[H|T],[H|NT]) :- X > H, 
                        insr(X,T,NT).

% Médicos de uma dada Instituição
% Extensão do predicado medInst : I, R -> {V,F}

medInst(I,R) :- solucoes(ID,(cuidado_prestado(ID,_,I,_)),L), 
                getDoc(L,R).

getDoc([],[]).
getDoc([X|XS],RS) :- solucoes(M,atos(_,_,X,_,M,_),MS),
                     getDoc(XS,TS),
                     concat(MS,TS,F),
                     retiraRep(F,RS).    
  
% Média dos custos dos atos
% Extensão do precicado mediaCusto : I, R -> {V,F}

mediaCusto(R) :- solucoes((X,U,Y,Z,W,Q), atos(X,U,Y,Z,W,Q), P),
                 atoCusto(P,F),
                 comprimento(P,K),
                 R is F/K.