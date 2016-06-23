#!/bin/bash

#get input image
img=$1

#get image size
size="$(identify $img|awk '{print $3}'|sed 's/x/,/g')"

echo "$size,"

echo -n "0b"
convert $img txt:-|\
  grep -v ImageMagick |\
  while read line;
  do 
    if [[ $line == *"white"* ]];
    then 
      echo -n "1";
    else 
      echo -n "0";
    fi;
  done|\
  sed 's/\(.\{8\}\)/\1,\n0b/g'|grep -v "^0b$"|sed '$ s/.$//'
