#!/bin/bash
read -p 'project: ' PROJECT
read -p 'title: ngGirls @ ' TITLE
read -p 'date (yyyy/mm/dd): ' INPUT_DATE
read -p 'date application (yyyy/mm/dd): ' INPUT_DEADLINE
read -p 'city, country (Berlin, Germany): ' CITY
read -p 'address: ' ADDRESS


# DATE="MONTH, 1st"
# DEADLINE="xxxDeadline"

DateSuffix() {
    if [ "$DAY" -eq "1" ] || [ "$DAY" -eq "21" ] || [ "$DAY" -eq "31" ]
    then
    echo 'st'
    elif [ "$DAY" -eq "2" ] || [ "$DAY" -eq "22" ]
    then
    echo 'nd'
    elif [ "$DAY" -eq "3" ] [ "$DAY" -eq "23" ]
    then
    echo 'rd'
    else
    echo 'th'
    fi   
}

# unset DATE

[ "${#INPUT_DATE}" -ne "10" ] && {
    printf "error: invalid length of date entered.\n"
    exit 1
}
[[ ${INPUT_DATE} =~ ^[0-3][0-9]/[0-1][0-9]/[0-9]{4}$ ]] && {
    printf "error: non digit in date entered.\n"
    exit 1
}

YEAR=${INPUT_DATE:0:4}
MONTH=${INPUT_DATE:5:2}
DAY=${INPUT_DATE:8:2}

LANG=C EVENT_DATE=$(date -d $INPUT_DATE +"%A, %B %d`DateSuffix` %Y")
LANG=C HERO_DATE=$(date -d $INPUT_DATE +" %B %d`DateSuffix`, %Y")
LANG=C DEADLINE_DATE=$(date -d $INPUT_DEADLINE +"%A, %B %d`DateSuffix` %Y")

# #### PROJECT="$1"
PROJECT_FULL="$PROJECT-$YEAR"
SAMPLE="sample-xxxx"
DRAFT="automation/create_workshop/sample/"
ROOT="./"


# ##### cp -r sample/  $1/
# pwd
if [ -d "$ROOT"_includes/"$PROJECT_FULL" ]; then rm -Rf "$ROOT"_includes/"$PROJECT_FULL"; fi
rm "$ROOT"img/sections-background/"$PROJECT".jpg
rm "$ROOT"img/sections-background/"$PROJECT"_small.jpg
if [ -d "$ROOT"img/"$PROJECT_FULL"-mentors/ ]; then rm -Rf "$ROOT"img/"$PROJECT_FULL"-mentors/ ; fi
if [ -d "$ROOT$PROJECT_FULL".html ]; then rm -Rf "$ROOT$PROJECT_FULL".html ; fi

cp -R "$ROOT$DRAFT"_includes/"$SAMPLE/." "$ROOT"_includes/"$PROJECT_FULL/"

# #### cp images
cp "$ROOT$DRAFT"img/sections-background/"$SAMPLE".jpg "$ROOT"img/sections-background/"$PROJECT".jpg
cp "$ROOT$DRAFT"img/sections-background/"$SAMPLE"_small.jpg "$ROOT"img/sections-background/"$PROJECT"_small.jpg
cp "$ROOT$DRAFT"_data/"$SAMPLE".yml "$ROOT"_data/"$PROJECT_FULL".yml
cp -R "$ROOT$DRAFT"img/"$SAMPLE"-mentors/. "$ROOT"img/"$PROJECT_FULL"-mentors/
cp -R "$ROOT$DRAFT$SAMPLE".html "$ROOT$PROJECT_FULL".html

sed -i -e "s/$SAMPLE/$PROJECT_FULL/g" "$ROOT"_includes/"$PROJECT_FULL"/*.html
sed -i -e "s/$SAMPLE/$PROJECT_FULL/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/$SAMPLE/$PROJECT_FULL/g" "$ROOT$PROJECT_FULL".html

sed -i -e "s/<sample>/$PROJECT/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<date>/$EVENT_DATE/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<heroDate>/$HERO_DATE/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<year>/$YEAR/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<city>/$CITY/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<day>/$DAY/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<address>/$ADDRESS/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<deadline>/$DEADLINE_DATE/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<title>/$TITLE/g" "$ROOT"_data/"$PROJECT_FULL".yml
sed -i -e "s/<title>/$TITLE/g" "$ROOT$PROJECT_FULL".html




