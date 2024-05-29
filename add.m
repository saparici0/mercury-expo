:- module add.
:- interface.
:- import_module io.

:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module string, int.

:- pred add(int::in, int::in, int::out) is det.
:- pragma foreign_proc("C",
    add(A::in, B::in, Result::out),
    [will_not_call_mercury, promise_pure, thread_safe],
"
    int add(int a, int b) {
        return a + b;
    }

    Result = add(A,B);
").

main(!IO) :-
    io.read_line_as_string(ResultA, !IO),
    (
        ResultA = ok(LineA),
        StrippedA = string.strip(LineA),
        ( if string.to_int(StrippedA, A) then
            io.read_line_as_string(ResultB, !IO),
            (
                ResultB = ok(LineB),
                StrippedB = string.strip(LineB),
                ( if string.to_int(StrippedB, B) then
                    add(A, B, Sum),
                    io.write_string("The sum is: ", !IO),
                    io.write_int(Sum, !IO),
                    io.nl(!IO)
                else
                    B = 0,
                    add(A, B, Sum),
                    io.write_string("The sum is: ", !IO),
                    io.write_int(Sum, !IO),
                    io.nl(!IO)
                )
            ;
                ResultB = eof,
                io.write_string("Unexpected end of second input\n", !IO)
            ;
                ResultB = error(ErrorCode),
                io.write_string(io.error_message(ErrorCode) ++ "\n", !IO)
            )
        else
            A = 0,
            B = 0,
            add(A, B, Sum),
            io.write_string("The sum is: ", !IO),
            io.write_int(Sum, !IO),
            io.nl(!IO)
        )
    ;
        ResultA = eof,
        io.write_string("Unexpected end of first input\n", !IO)
    ;
        ResultA = error(ErrorCode),
        io.write_string(io.error_message(ErrorCode) ++ "\n", !IO)
    ).