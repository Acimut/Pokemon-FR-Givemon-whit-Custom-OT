# Rutina givemon con OT personalizado:
Personalización de un menú start a pantalla completa para Pokémon Fire Red.

Abrir el archivo Makefile y editar la línea `export INSERT_INTO := 0x08720000` cambiando 720000 por el offset donde insertarán la rutina.
Compilan ejecutando make con su terminal, y una rom llamada "rom.gba" con la inyección aparecerá en una carpeta llamada build
DevkitARM y ARMIPS son necesarios (versiones más recientes).



# Script de ejemplo:
#dynamic 0x800000
#org @inicio
setvar 0x8000 58 'especie
setvar 0x8001 5  'nivel
setvar 0x8002 1 'item
setvar 0x8003 11 'ball
setvar 0x8004 01234 'otSecretId número menor a 65535
setvar 0x8005 56789 'otId número menor a 65535
setvar 0x8006 1 'si es 0 no pone mote, si es uno o mayor pone mote
virtualbuffer 0 @otname '[buffer1]
virtualbuffer 1 @nickname '[buffer2] sólo si 0x8006 => 1
callasm 0x720001 'offset rutina + 1
msgbox @mensaje 2
end

#org @mensaje
= ¡Cuida de mi [buffer2]!

#org @nickname
= Mote

#org @otname
= OtName


