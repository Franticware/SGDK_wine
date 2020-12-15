#!/bin/bash

# This script generates wine wrapper for each exe in the SGDK bin directory.
# It also generates makefile_wine.gen (same as makefile.gen minus line containing "SHELL=").
# It should be run once from within the SGDK bin directory.
# The following command should then be able to build any SGDK project:
# make GDK=/path/to/sgdk -f /path/to/sgdk/makefile_wine.gen

# Tested with SGDK 1.51, see github.com/Stephane-D/SGDK
# Known issues: File names/paths with spaces cause issues.

# By Vojtěch Salajka, 2020-12 
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
echo -n ".exe $" >> $f
echo "@" >> $f
chmod +x $f
done

grep -v SHELL= ../makefile.gen > ../makefile_wine.gen
