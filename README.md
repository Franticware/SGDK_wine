# SGDK_wine

The generate_wine.sh script generates a wine wrapper for each exe in the SGDK bin directory. It also generates makefile_wine.gen.

It should be run once from within the SGDK bin directory:
```
PATH_TO_SGDK=/path/to/sgdk
cp generate_wine.sh $PATH_TO_SGDK/bin
cd $PATH_TO_SGDK/bin
sh generate_wine.sh
```
The following command should then be able to build any SGDK project:
```
make GDK=/path/to/sgdk -f /path/to/sgdk/makefile_wine.gen
```
I have tested it only on my Linux distribution (Manjaro). It would be much appreciated if you shared your own experience here:
https://github.com/Franticware/SGDK_wine/discussions/4

More information about SGDK can be found in the official repository: https://github.com/Stephane-D/SGDK
