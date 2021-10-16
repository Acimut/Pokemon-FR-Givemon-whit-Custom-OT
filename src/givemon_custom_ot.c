#include "include/global.h"
#include "include/malloc.h"
#include "include/event_data.h"
#include "include/pokedex.h"
#include "include/random.h"
#include "include/script.h"

//string_util.c
extern u8 gStringVar1[32];// [buffer1]
extern u8 gStringVar2[20];// [buffer2]
extern u8 gStringVar3[20];// [buffer3]
extern u8 gStringVar4[1000];
extern u8 gUnknownStringVar[16];

extern u8 SendMonToPC(struct Pokemon* mon);

void CustomGiveMon(void)
{
    //u16 species = gSpecialVar_0x8000;
    //u8 level    = gSpecialVar_0x8001;
    //u16 item    = gSpecialVar_0x8002;
    //u16 ball    = gSpecialVar_0x8003;

    s32 i;
    u16 nationalDexNum;
    u8 heldItem[2];

    u32 otId = gSpecialVar_0x8005 | (gSpecialVar_0x8004 << 16);

    //gSpecialVar_0x8004 = 1234
    //gSpecialVar_0x8005 = 5678
    //gSpecialVar_0x8005 | (gSpecialVar_0x8004 << 16)
    //              5678 | 1234 0000 = 1234 5678

    u8 met_location = 0xFE; //conseguido por intercambio.

    struct Pokemon *mon = AllocZeroed(sizeof(struct Pokemon));

    CreateMon(mon, gSpecialVar_0x8000, gSpecialVar_0x8001, 32, 0, 0, 1, otId);
    heldItem[0] = gSpecialVar_0x8002;
    heldItem[1] = gSpecialVar_0x8002 >> 8;
    SetMonData(mon, MON_DATA_HELD_ITEM, heldItem);

    SetMonData(mon, MON_DATA_OT_NAME, gStringVar1);
    if (gSpecialVar_0x8006)
        SetMonData(mon, MON_DATA_NICKNAME, gStringVar2);
    
	SetMonData(mon, MON_DATA_MET_LOCATION, &met_location);
	SetMonData(mon, MON_DATA_POKEBALL, &gSpecialVar_0x8003);

    //evita ivs menores a 5
    for (int i = 0; i < 6; i++)
    {
        u8 temp = GetMonData(mon, (MON_DATA_HP_IV + i), NULL);
        if (temp < 5)
        {
            temp += 5;
            SetMonData(mon, (MON_DATA_HP_IV + i), &temp);
        }
    }

	CalculateMonStats(mon);

    //GiveMonToPlayer(mon);
    
        SetMonData(mon, MON_DATA_OT_GENDER, &gSaveBlock2Ptr->playerGender);

        for (i = 0; i < PARTY_SIZE; i++)
        {
            if (GetMonData(&gPlayerParty[i], MON_DATA_SPECIES, NULL) == SPECIES_NONE)
                break;
        }

        if (i >= PARTY_SIZE)
        {
            SendMonToPC(mon);
        }
        else
        {
            CopyMon(&gPlayerParty[i], mon, sizeof(*mon));
            gPlayerPartyCount = i + 1;
        }

    nationalDexNum = SpeciesToNationalPokedexNum(gSpecialVar_0x8000);
    GetSetPokedexFlag(nationalDexNum, FLAG_SET_SEEN);
    GetSetPokedexFlag(nationalDexNum, FLAG_SET_CAUGHT);

    Free(mon);
}