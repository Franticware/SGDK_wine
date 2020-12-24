#!/bin/bash

# This script generates wine wrapper for each exe in the SGDK bin directory.
# It also generates makefile_wine.gen (same as makefile.gen with variables 
# RM, CP and MKDIR set to native unix utilities and SHELL removed).
# It should be run once from within the SGDK bin directory.
# The following command should then be able to build any SGDK project:
# make GDK=/path/to/sgdk -f /path/to/sgdk/makefile_wine.gen

# Tested with SGDK 1.60, see github.com/Stephane-D/SGDK/releases

# By Vojtěch Salajka, 2020-12, github.com/Franticware
# License: MIT

for f in $( ls *.exe ); do 
CURRENT=$(pwd)
f=$(echo $f | sed 's/.exe$//')
echo $f
echo "#!/bin/bash" > $f
echo -n "WINEPREFIX=" >> $f
echo -n $CURRENT >> $f
echo -n "/.wineconf wine " >> $f
echo -n $CURRENT >> $f
echo -n "/" >> $f
echo -n $f >> $f
echo -n ".exe \"$" >> $f
echo "@\"" >> $f
chmod +x $f
done

echo "RM= rm" > ../makefile_wine.gen
echo "CP= cp" >> ../makefile_wine.gen
echo "MKDIR= mkdir" >> ../makefile_wine.gen
echo >> ../makefile_wine.gen
cat ../makefile.gen | grep -v SHELL= | grep -v RM= | grep -v CP= | grep -v MKDIR= >> ../makefile_wine.gen
