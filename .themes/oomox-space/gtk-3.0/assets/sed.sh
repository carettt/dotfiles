#!/bin/sh
sed -i \
         -e 's/#221c4f/rgb(0%,0%,0%)/g' \
         -e 's/#fefefa/rgb(100%,100%,100%)/g' \
    -e 's/#3f356d/rgb(50%,0%,0%)/g' \
     -e 's/#f78fc1/rgb(0%,50%,0%)/g' \
     -e 's/#3f356d/rgb(50%,0%,50%)/g' \
     -e 's/#fefefa/rgb(0%,0%,50%)/g' \
	"$@"
