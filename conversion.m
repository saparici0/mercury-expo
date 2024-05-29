:- module conversion.
:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module string.

:- pred ejemplo_predicado(int::in, string::out) is det.
ejemplo_predicado(X, Y) :-
    % Esto sería un error de tipo en Mercury
    % Y = X + "hola".
    
    % Forma correcta con conversión explícita
    Y = string.from_int(X) ++ " hola".

main(!IO) :-
    T = 1,
    % No puedo asignar otro tipo a una variable creada
    % T = "hola",
    % T = 2,
    ejemplo_predicado(42, Resultado),
    io.write_string(Resultado, !IO),
    io.nl(!IO).
