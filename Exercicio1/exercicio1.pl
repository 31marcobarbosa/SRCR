

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