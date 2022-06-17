#!/bin/bash

# Rev. 1.70-1

# This script generates wine wrapper for each exe in the SGDK bin directory.
# It also generates makefile_wine.gen (same as makefile.gen with variables 
# RM, CP and MKDIR set to native unix utilities and SHELL removed).
# It should be run once from within the SGDK bin directory.
# The following command should then be able to build any SGDK project:
# make GDK=/path/to/sgdk -f /path/to/sgdk/makefile_wine.gen

# Tested with SGDK 1.70, see github.com/Stephane-D/SGDK/releases

# By Vojtěch Salajka, 2022-03, github.com/Franticware
# License: MIT

# Known issues: The file makelib.gen does not work with this method.

for f in $( ls *.exe ); do 
CURRENT=$(pwd)
f="$(echo $f | sed 's/.exe$//')"
echo "$f"
echo "#!/bin/bash" > "$f"
echo 'BIN_DIR="$(dirname "$0")"' >> "$f"
echo 'WINEDEBUG=-all WINEPREFIX="$BIN_DIR/.wineconf" wine "$BIN_DIR/$(basename "$0").exe" "$@"' >> "$f"
chmod +x "$f"
done

DIVLINE=$(grep -n -m 1 common.mk ../makefile.gen | sed  's/\([0-9]*\).*/\1/')
WINEGEN="../makefile_wine.gen"
head -n $DIVLINE ../makefile.gen > $WINEGEN
cat >> $WINEGEN <<EOF
# section added by generate_wine.sh
RM= rm
CP= cp
MKDIR= mkdir
CC= \$(GDK)/bin/gcc
LD= \$(GDK)/bin/ld
NM= \$(GDK)/bin/nm
JAVA= java
ECHO= echo
OBJCPY= \$(GDK)/bin/objcopy
ASMZ80= \$(GDK)/bin/sjasm
MACCER= \$(GDK)/bin/mac68k
SIZEBND= \$(JAVA) -jar \$(GDK)/bin/sizebnd.jar
BINTOS= \$(GDK)/bin/bintos
RESCOMP= \$(JAVA) -jar \$(GDK)/bin/rescomp.jar
release: LIBGCC= \$(LIB)/libgcc.a
debug: LIBGCC= \$(LIB)/libgcc.a
# end of section
EOF
tail +$DIVLINE ../makefile.gen | tail +2 >> $WINEGEN
