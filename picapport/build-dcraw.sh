#!/bin/sh
mkdir -p /opt/dcraw/src
( cd /opt/dcraw/src && curl -O https://dechifro.org/dcraw/dcraw.c )
mkdir -p /opt/dcraw/bin;
gcc -o /opt/dcraw/bin/dcraw -O4 /opt/dcraw/src/dcraw.c -lm -ljasper -ljpeg -llcms2