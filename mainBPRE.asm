.gba
.thumb
.open "BPRE0.gba","build/rom_eng.gba", 0x08000000

.align 2
.org insertinto
.importobj "build/linked.o"
.close





