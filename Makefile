DIR_SRC= ./src
DIR_OBJ= ./obj
DIR_OUT=	./_build

DIR_INCLUDE=	./include
DIR_DATA=	./content

OBJ_C = $(wildcard ${DIR_SRC}/*.c )
OBJ_O = $(patsubst %.c,${DIR_OBJ}/%.o,$(notdir ${OBJ_C}))

LDFLAGS+=	-Wl,--allow-multiple-definition
LIBS=	-lSDL2 -lbass -lbass_fx -lm -lSDL2_image -lexpat

TARGET = zuma
CC = clang
CFLAGS += -I $(DIR_INCLUDE)

.PHONY : zuma clean

$(shell mkdir -p $(DIR_OUT))

zuma:${OBJ_O}
	echo $(@)
	$(CC) $(CFLAGS) $(OBJ_O) -o $(DIR_OUT)/$(TARGET) $(LIBS) $(LDFLAGS)
	$(shell cp -r $(DIR_DATA)/* $(DIR_OUT))
    
$(shell mkdir -p $(DIR_OBJ))

${DIR_OBJ}/%.o:$(DIR_SRC)/%.c
	$(CC) $(CFLAGS) -c  $< -o $@
	
clean :
	rm $(DIR_OBJ)/*
	rm -r $(DIR_OUT)/*
