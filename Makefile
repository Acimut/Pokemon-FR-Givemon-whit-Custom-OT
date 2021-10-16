#-------------------------------------------------------------------------------

ifeq ($(strip $(DEVKITARM)),)
$(error Please set DEVKITARM in your environment. export DEVKITARM=/path/to/devkitARM)
endif

include $(DEVKITARM)/base_tools

#-------------------------------------------------------------------------------

export ROM_CODE := BPRE
export INSERT_INTO := 0x08720000

export BUILD := build
export SRC := src
export RESOURCES := graphics/icons
# resources
export BINARY := $(BUILD)/linked.o

export PREPROC ?= preproc.exe
export ARMIPS ?= armips.exe
export LD := $(PREFIX)ld

export ASFLAGS := -mthumb
	
export INCLUDES := -I $(SRC) #-I include -I gflib
export WARNINGFLAGS :=	-Wall -Wno-discarded-array-qualifiers \
	-Wno-int-conversion
export CFLAGS := -O2 -Wextra -mthumb -mno-thumb-interwork -mcpu=arm7tdmi -mtune=arm7tdmi \
	-march=armv4t -mlong-calls -fno-inline -fno-builtin -std=gnu11 -mabi=apcs-gnu -x c -c \
	-MMD $(WARNINGFLAGS) $(INCLUDES) -O -finline 

#original
#export CFLAGS := -mthumb -mno-thumb-interwork -mcpu=arm7tdmi -mtune=arm7tdmi \
	-march=armv4t -mlong-calls -fno-builtin $(WARNINGFLAGS) $(INCLUDES) \
	-O -finline 

#move item cflags
#CFLAGS = -O2 -mlong-calls -Wall -Wextra -mthumb -mno-thumb-interwork -fno-inline -fno-builtin -std=gnu11 -mabi=apcs-gnu -mcpu=arm7tdmi -march=armv4t -mtune=arm7tdmi -x c -c -MMD $(CPPFLAGS) $(EXTRA_CFLAGS)


export LDFLAGS := --relocatable -T linker.ld -T $(ROM_CODE).ld 
# -r -T linker.ld -T $(ROM_CODE).ld 

#-------------------------------------------------------------------------------
	
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))


# Generated
IMAGES=$(call rwildcard,images,*.png)

# Sources
HEADERS := $(call rwildcard,$(SRC),*.h)
# C_MAIN función principal que inicializa el sistema. Se compila primero que nada.
# CustomStartMenu.c es la función que inicializa el sistema. Cambiar si es necesario.
C_MAIN := $(call rwildcard,$(SRC),main.c)
C_SRC := $(call rwildcard,$(SRC),*.c)
S_SRC := $(call rwildcard,$(SRC),*.s)
#GBAPAL_SRC :=$(call rwildcard,$(RESOURCES),*.gbpal)
#GBA4BPP_SRC :=$(call rwildcard,$(RESOURCES),*.4bpp)
#GBABIN_SRC :=$(call rwildcard,$(RESOURCES),*.lz)
OTHER_SRC := $(call rwildcard,$(RESOURCES),*.s)

# Binaries
C_MAIN := $(C_MAIN:%=$(BUILD)/%.o)
C_OBJ := $(C_SRC:%=$(BUILD)/%.o)
S_OBJ := $(S_SRC:%=$(BUILD)/%.o)
#GBAPAL_OBJ :=$(GBAPAL_SRC:%=$(BUILD)/%.o)
#GBA4BPP_OBJ :=$(GBA4BPP_SRC:%=$(BUILD)/%.o)
#GBABIN_OBJ :=$(GBABIN_SRC:%=$(BUILD)/%.o)
OTHER_OBJ := $(OTHER_SRC:%=$(BUILD)/%.o)

ALL_OBJ := $(C_MAIN) $(C_OBJ) $(S_OBJ) $(OTHER_OBJ) 
# $(GBAPAL_OBJ) $(GBA4BPP_OBJ) $(GBABIN_OBJ)



#-------------------------------------------------------------------------------

.PHONY: all clean rom

all: clean rom

rom: main$(ROM_CODE).asm $(BINARY)
	@echo "\nCreating ROM"
	$(ARMIPS) main$(ROM_CODE).asm -definelabel insertinto $(INSERT_INTO) -sym offsets.txt

clean:
	rm -rf $(BINARY)
	rm -rf $(BUILD)/$(SRC)

$(BINARY): $(ALL_OBJ)
	@echo "\nLinking ELF binary $@"
	@$(LD) $(LDFLAGS) -o $@ $^

$(BUILD)/%.c.o: %.c $(HEADERS)
	@echo "\nCompiling $<"
	@mkdir -p $(@D)
	$(PREPROC) "$<" charmap.txt | $(CC) $(CFLAGS) -MF "$(@:%.o=%.d)" -MT "$@" -o "$@" -

$(BUILD)/%.s.o: %.s $(HEADERS)
	@echo "\nAssembling $<"
	@mkdir -p $(@D)
	@$(AS) $(ASFLAGS) -o $@
	
	
	