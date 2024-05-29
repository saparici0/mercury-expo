% Definición del módulo
:- module main.

% Declaración de la interfaz
:- interface.

% Importar el módulo io en la interfaz
:- import_module io.

% Declaración del predicado suma/3 con tipos de argumentos
:- pred suma(int::in, int::in, int::out) is det.

% Declaración del predicado main/2
:- pred main(io::di, io::uo) is det.

% Sección de implementación
:- implementation.

% Importar los módulos necesarios
:- import_module int.
:- import_module string.
:- import_module list.

% Implementación del predicado suma/3
suma(X, Y, Resultado) :-
    Resultado = X + Y.

% Implementación del predicado main/2
main(!IO) :-
    io.read_line_as_string(Result1, !IO),
    (
        Result1 = ok(Line1),
        ( string.to_int(string.strip(Line1), X) ->
            io.read_line_as_string(Result2, !IO),
            (
                Result2 = ok(Line2),
                ( string.to_int(string.strip(Line2), Y) ->
                    suma(X, Y, Resultado),
                    io.format("La suma de %d y %d es %d\n", [i(X), i(Y), i(Resultado)], !IO)
                ;
                    io.write_string("Error: El segundo valor ingresado no es un número válido.\n", !IO)
                )
            ;
                Result2 = eof,
                io.write_string("Error: Fin de entrada inesperado al leer el segundo número.\n", !IO)
            ;
                Result2 = error(Error),
                io.format("Error al leer el segundo número: %s\n", [s(io.error_message(Error))], !IO)
            )
        ;
            io.write_string("Error: El primer valor ingresado no es un número válido.\n", !IO)
        )
    ;
        Result1 = eof,
        io.write_string("Error: Fin de entrada inesperado al leer el primer número.\n", !IO)
    ;
        Result1 = error(Error),
        io.format("Error al leer el primer número: %s\n", [s(io.error_message(Error))], !IO)
    ).