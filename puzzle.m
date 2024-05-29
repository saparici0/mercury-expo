:- module puzzle.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.
:- implementation.
:- import_module list, string, solutions.

:- type origenes ---> ingles; japones; espanol.
:- type colores ---> rojo; azul; verde.
:- type mascotas ---> jaguar; caracol; cebra.
:- type casa
    --->    casa(
                origen :: origenes,
                color :: colores,
                mascota :: mascotas
            ).

:- pred distinct(casa::in, casa::in) is semidet.
distinct(casa(O1, C1, M1), casa(O2, C2, M2)) :-
    not (O1 = O2; C1 = C2; M1 = M2).

:- pred fila(list(casa)::out) is nondet.
fila([X, Y, Z]) :-
    casa(X), casa(Y), casa(Z),
    % los japoneses viven a la derecha del cuidador de caracoles
    X^mascota = caracol     <=> Y^origen = japones,
    Y^mascota = caracol     <=> Z^origen = japones,
    % el cuidador de los caracoles vive a la izquierda de la casa azul
    Z^color = azul          <=> Y^mascota = caracol,
    Y^color = azul          <=> X^mascota = caracol,
    % los japoneses viven a la derecha del cuidador de caracoles
    not X^origen = japones,
    % el cuidador de los caracoles vive a la izquierda de la casa azul
    not Z^mascota = caracol,
    distinct(X, Y), distinct(Y, Z), distinct(X, Z).

:- pred casa(casa::out) is nondet.
casa(casa(O, C, M)) :-
    origen(O), color(C), mascota(M),
    O = ingles <=> C = rojo,
    O = espanol <=> M = jaguar,
    not (O = japones, M = caracol),
    not (M = caracol, C = azul).

main(!IO) :-
    solutions(fila, Soluciones),
    ( if Soluciones = [] then
        io.write_string("Sin solucion.\n", !IO)
    else
        foldl((pred(L::in, !.IO::di, !:IO::uo) is det :-
            io.print(L, !IO),
            io.nl(!IO)), Soluciones, !IO)
    ).

:- pred origen(origenes::out) is multi.
origen(ingles).
origen(japones).
origen(espanol).

:- pred color(colores).
:- mode color(out) is multi.
:- mode color(in) is det.
color(rojo).
color(azul).
color(verde).

:- pred mascota(mascotas::out) is multi.
mascota(jaguar).
mascota(caracol).
mascota(cebra).