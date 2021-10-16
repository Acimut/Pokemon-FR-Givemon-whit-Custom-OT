__aeabi_idiv        = 0x081e3b68|1;
__aeabi_idivmod     = 0x081e3b68|1;
__aeabi_uidiv       = 0x081e3b68|1;
__aeabi_uidivmod    = 0x081e3b68|1;
__divsi3            = 0x081e4018|1;
__udivsi3           = 0x081e460c|1;
__umodsi3           = 0x081e4684|1;
memcpy              = 0x081e5e78|1;
memset              = 0x081e5ed8|1;
strcmp              = 0x081e5f2c|1;
strcpy              = 0x081e5f88|1;
memmove             = 0x081e8e60|1;

/* EWRAM */
gPlayerPartyCount   = 0x02024029;
gPlayerParty        = 0x02024284;

gStringVar1         = 0x02021cd0;
gStringVar2         = 0x02021cf0;
gStringVar3         = 0x02021d04;
gStringVar4         = 0x02021d18;
gUnknownStringVar   = 0x02022100;

gSpecialVar_0x8000 = 0x020370b8;
gSpecialVar_0x8001 = 0x020370ba;
gSpecialVar_0x8002 = 0x020370bc;
gSpecialVar_0x8003 = 0x020370be;
gSpecialVar_0x8004 = 0x020370c0;
gSpecialVar_0x8005 = 0x020370c2;
gSpecialVar_0x8006 = 0x020370c4;
gSpecialVar_0x8007 = 0x020370c6;
gSpecialVar_0x8008 = 0x020370c8;
gSpecialVar_0x8009 = 0x020370ca;
gSpecialVar_0x800A = 0x020370cc;
gSpecialVar_0x800B = 0x020370ce;
gSpecialVar_Result = 0x020370d0;


/* funciones */

/* general */
VarGet      = 0x0806e568|1;
VarSet      = 0x0806e584|1;
FlagSet     = 0x0806e680|1;
FlagClear   = 0x0806e6a8|1;
FlagGet     = 0x0806e6d0|1;
Random      = 0x08044ec8|1;


/*givemon_custom_ot*/
AllocZeroed                     = 0x08002bb0|1;
CreateMon                       = 0x0803da54|1;
GetMonData                      = 0x0803fbe8|1;
SetMonData                      = 0x0804037c|1;
GiveMonToPlayer                 = 0x08040b14|1;
SpeciesToNationalPokedexNum     = 0x08043298|1;
GetSetPokedexFlag               = 0x08088e74|1;
Free                            = 0x08002bc4|1;
CalculateMonStats               = 0x0803e47c|1;
SendMonToPC                     = 0x08040b90|1;
CopyMon                         = 0x08040b08|1;
gSaveBlock2Ptr                  = 0x0300500c;