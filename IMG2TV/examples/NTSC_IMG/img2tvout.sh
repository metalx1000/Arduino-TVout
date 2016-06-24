#!/bin/bash

#If no input file display help
if [ $# -eq 0 ] 
then
#cat <<EOF
#Usage: $0 <image file>
#Example: $0 logo.png

#Images should be 128x96 or smaller.
#1bit PNG will work best (JPGs are a little Noisy).

#EOF 
  exit 1
fi

#get input image
img=$1
name="$(basename $img|cut -d\. -f1)"

#get image size
size="$(identify $img|awk '{print $3}'|sed 's/x/,/g')"

###Create CPP
c="$name.cpp"
echo "#include \"$name.h\"" > $c
echo "PROGMEM const unsigned char $name[] = {" >> $c
echo "$size," >> $c

echo -n "0b" >> $c 
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
  sed 's/\(.\{8\}\)/\1,\n0b/g'|grep -v "^0b$"|sed '$ s/.$//' >> $c

echo "};" >> $c

###Create h file
h=$name.h
echo "#include <avr/pgmspace.h>" > $h
echo "#ifndef ${name}_H" >> $h
echo "#define ${name}_H" >> $h

echo "extern const unsigned char $name[];" >> $h
echo "#endif" >> $h

##output
echo "Don't forget to copy $c and $h file to project folder"
echo "and add '#include \"$h\"' to the main project file."
echo "Good-bye..." 
