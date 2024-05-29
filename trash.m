:- module trash.
:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list.
:- import_module int. % Importamos el módulo int para operadores aritméticos y relacionales

% Definimos un tipo simple que encapsula un entero
:- type my_data ---> data(int).

% Una función que crea una lista de 'my_data' con n elementos
:- func create_data_list(int) = list(my_data).

create_data_list(N) = (if N =< 0 then [] else [data(N) | create_data_list(N - 1)]).

% Una función que procesa la lista y la convierte en una lista de enteros
:- func process_data_list(list(my_data)) = list(int).

process_data_list([]) = [].
process_data_list([data(X) | Xs]) = [X | process_data_list(Xs)].

main(!IO) :-
    % Creamos una lista de 10 elementos
    DataList = create_data_list(10),
    % Procesamos la lista
    IntList = process_data_list(DataList),
    % Imprimimos la lista procesada
    io.write_list(IntList, ", ", io.write_int, !IO),
    io.nl(!IO),
    % En este punto, DataList y IntList ya no son necesarios y el recolector de basura
    % se encargará de liberar la memoria asociada a estas estructuras.
    io.write_string("Memory has been managed automatically by the garbage collector.", !IO),
    io.nl(!IO).