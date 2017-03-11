

% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1
% Grupo 1


%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').


%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre cuidado prestado m ato médico , utente


:- dynamic( utente/3 ).
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




% --------------------------------------------------------------
% Extensao do predicado ato_medico:  Data, IdUt, IdServ, Custo -> { V, F }




% --------------------------------------------------------------
% Invariante Estrutural para utente:
% (não permite a inserção de conhecimento repetido)

+utente(I,N,Idd,M) :: (findall((I,N,Idd,M),(utente(I,N,Idd,M)),L),
						comprimento(L,N),
						N == 1).



% --------------------------------------------------------------
% Extensão do predicado de comprimento: L,Tam -> {V,F} 

comprimento([],0).
comprimento([_|Xs],N) :- comprimento(Xs,G) , N is 1 + G.