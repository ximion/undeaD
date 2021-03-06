#_ win32.mak
# Build win32 version of undead
# Needs Digital Mars D compiler to build, available free from:
# http://www.digitalmars.com/d/

DC?=dmd
DEL=del
S=src\undead
O=obj
B=bin

TARGET=undead

DFLAGS=-g -Isrc/
LFLAGS=-L/map/co
#DFLAGS=
#LFLAGS=

.d.obj :
	$(DC) -c $(DFLAGS) $*

SRC= $S\bitarray.d $S\regexp.d $S\datebase.d $S\date.d $S\dateparse.d \
	 $S\cstream.d $S\stream.d $S\socketstream.d $S\doformat.d $S\internal\file.d

SOURCE= $(SRC) win32.mak win64.mak posix.mak LICENSE README.md dub.json

all: $B\$(TARGET).lib

#################################################

$B\$(TARGET).lib : $(SRC)
	$(DC) -lib -of$B\$(TARGET).lib $(SRC) $(DFLAGS)


unittest :
	$(DC) -unittest -main -cov -of$O\unittest.exe $(SRC) $(DFLAGS)
	$O\unittest.exe


clean:
	$(DEL) $O\unittest.exe *.lst


tolf:
	tolf $(SOURCE)


detab:
	detab $(SRC)


zip: detab tolf $(SOURCE)
	$(DEL) undead.zip
	zip32 undead $(SOURCE)
