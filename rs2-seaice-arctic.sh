#!/bin/bash

gpt.exe rsat2-sea-arctic.xml -Pifile=$1 -Pofile=${1%.*}.dim
inputdir=${1%.*}.data
tmpfile=$(mktemp)
outfile=${1%.*}.tif
gdalwarp -tr 100 100 ${inputdir}/Sigma0_HH_dB.img ${tmpfile}.tif -dstnodata 0 
gdal_translate -co COMPRESS=JPEG -co JPEG_QUALITY=55 -ot Byte -ot Byte -scale -a_srs "EPSG:5939" ${tmpfile}.tif $outfile
rm ${tmpfile}.tif
