:- module high.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int.

main(!IO) :-
    factorial(10, Result),
    io.write_string("Factorial de 10 es: ", !IO),
    io.write_int(Result, !IO),
    io.nl(!IO).

:- pred factorial(int::in, int::out) is det.
factorial(N, Result) :-
    ( if N = 0 then
        Result = 1
    else
        factorial(N - 1, SubResult),
        Result = N * SubResult
    ).