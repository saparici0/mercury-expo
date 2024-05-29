:- module predicados.
:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int, list.

% Predicado determinista: add
:- pred add(int::in, int::in, int::out) is det.
add(X, Y, Z) :- Z = X + Y.

% Predicado semideterminista: is_even
:- pred is_even(int::in) is semidet.
is_even(X) :- X mod 2 = 0.

% Predicado semideterminista: my_member
:- pred my_member(int::in, list(int)::in) is semidet.
my_member(X, [X | _]).
my_member(X, [_ | Tail]) :- my_member(X, Tail).


main(!IO) :-
    % Usando add
    add(3, 4, Sum),
    io.write_string("La suma es: ", !IO),
    io.write_int(Sum, !IO),
    io.nl(!IO),

    % Usando is_even
    ( if is_even(Sum) then
        io.write_string("La suma es par\n", !IO)
    else
        io.write_string("La suma es impar\n", !IO)
    ),

    % Usando list.member
    List = [1, 2, 3, 4],
    ( if list.member(3, List) then
        io.write_string("3 está en la lista\n", !IO)
    else
        io.write_string("3 no está en la lista\n", !IO)
    ).
