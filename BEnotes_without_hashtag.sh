#!/bin/bash

#Lijst met alle open notes in BE aanmaken
wget -O scraped.txt "https://resultmaps.neis-one.org/osm-notes-country-custom?c=Belgium&query=open"
html2text scraped.txt | grep -E "\[[0-9]" | grep -o -P '(?<=\[).*(?=\])' > listofnotes.txt

#Via API alle notes downloaden
while read line; do
cd notes/
echo line $line
wget -O $line https://api.openstreetmap.org/api/0.6/notes/$line
cd ..
done <listofnotes.txt

#In deze notes inverted zoeken naar ..., en hiervan een HTML maken
rm index.html
cd notes/
FILTEREDLIST=`grep -L -i surveyneeded * | awk -F ":" '{ print $1}' | sort | uniq`
COUNT=`echo "$FILTEREDLIST" | wc -l`
while IFS= read -r line ; do 
echo '<a href="https://www.openstreetmap.org/note/'$line'">'$line'</a><br>' >> ../index.html
done <<< "$FILTEREDLIST"
cd ..

DATE=`date`
sed -i "1s/^/<!DOCTYPE html><html><body>Last updated on $DATE<br>Total count is $COUNT<br>\n/" index.html
sed -i '$ s_$_ </body></html>_' index.html

rm scraped.txt
#rm listofnotes.txt
