#!/bin/sh

d=`date +%Y.%m.%d_%H-%M-%S`
echo "------------------------- BEGIN $d -----------------------------"

fixFileHtmlPats () {
sed -i 's/\/dist\/siauliai.min.css/resources\/siauliai.min.css/' "$1"
sed -i 's/\/dist\/moment.min.js/resources\/moment.min.js/' "$1"
sed -i 's/\/dist\/vendor.min.js/resources\/vendor.min.js/' "$1"
sed -i 's/\/dist\/core.min.js/resources\/core.min.js/' "$1"
sed -i 's/\/dist\/app.min.js/resources\/app.min.js/' "$1"
sed -i 's/\/static\/img\/siauliai\/logo.png/resources\/logo.png/' "$1"
sed -i 's/\/static\/img\/siauliai\/city.png/resources\/city.png/' "$1"
sed -i 's/\/dist\/fonts\/fa-brands-400.woff2/resources\/fa-brands-400.woff2/' "$1"
sed -i 's/\/dist\/fonts\/fa-solid-900.woff2/resources\/fa-solid-900.woff2/' "$1"
sed -i 's/\/dist\/fonts\/fa-brands-400.woff/resources\/fa-brands-400.woff/' "$1"
sed -i 's/\/dist\/fonts\/fa-brands-400.ttf/resources\/fa-brands-400.ttf/' "$1"
sed -i 's/\/dist\/fonts\/fa-solid-900.ttf/resources\/fa-solid-900.ttf/' "$1"
sed -i 's/\/static\/manifest\/manifest.json/resources\/manifest.json/' "$1"
sed -i 's/\/static\/manifest\/favicon.ico/resources\/favicon.ico/' "$1"
sed -i 's/\/static\/manifest\/favicon-32x32.png/resources\/favicon-32x32.png/' "$1"
sed -i 's/\/static\/manifest\/favicon-16x16.png/resources\/favicon-16x16.png/' "$1"
}

filesLocation="/home/ubuntu/siauliai_data"
currentDay=$(date +%Y-%m-%d)

fileNameMeroDienotvarke="$currentDay"_mero_dienotvarke.html
fileNameMeroPavaduotojo1Darbotvarke="$currentDay"_mero_pavaduotojo_1_darbotvarke.html
fileNameMeroPavaduotojo2Darbotvarke="$currentDay"_mero_pavaduotojo_2_darbotvarke.html
fileNameAdministracijosDirektoriausDarbotvarke="$currentDay"_administracijos_direktoriaus_darbotvarke.html
fileNameAdministracijosDirektoriausPavaduotojo1Darbotvarke="$currentDay"_administracijos_direktoriaus_pavaduotojo_1_darbotvarke.html
fileNameAdministracijosDirektoriausPavaduotojo2Darbotvarke="$currentDay"_administracijos_direktoriaus_pavaduotojo_2_darbotvarke.html

wget -O "$filesLocation/$fileNameMeroDienotvarke" https://www.siauliai.lt/lt/agenda/view/mero-dienotvarke
wget -O "$filesLocation/$fileNameMeroPavaduotojo1Darbotvarke" https://www.siauliai.lt/lt/agenda/view/mero-pavaduotojos-darbotvarke
wget -O "$filesLocation/$fileNameMeroPavaduotojo2Darbotvarke" https://www.siauliai.lt/lt/agenda/view/mero-pavaduotojos-darbotvarke
wget -O "$filesLocation/$fileNameAdministracijosDirektoriausDarbotvarke" https://www.siauliai.lt/lt/agenda/view/administracijos-direktoriaus-darbotvarke
wget -O "$filesLocation/$fileNameAdministracijosDirektoriausPavaduotojo1Darbotvarke" https://www.siauliai.lt/lt/agenda/view/administracijos-direktoriaus-pavaduotojo-darbotvarke
wget -O "$filesLocation/$fileNameAdministracijosDirektoriausPavaduotojo2Darbotvarke" https://www.siauliai.lt/lt/agenda/view/administracijos-direktoriaus-pavaduotojo-e-bivainio-darbotvarke

cd "$filesLocation"

git add .
git commit -a -m "Day $currentDay data."
git push origin main

fixFileHtmlPats "$fileNameMeroDienotvarke"
fixFileHtmlPats "$fileNameMeroPavaduotojo1Darbotvarke"
fixFileHtmlPats "$fileNameMeroPavaduotojo2Darbotvarke"
fixFileHtmlPats "$fileNameAdministracijosDirektoriausDarbotvarke"
fixFileHtmlPats "$fileNameAdministracijosDirektoriausPavaduotojo1Darbotvarke"
fixFileHtmlPats "$fileNameAdministracijosDirektoriausPavaduotojo2Darbotvarke"

ls -I webfonts -I js -I css -I download.log -I .idea -I .gitignore -I README.md -I cron -I index.html -I download.sh -I resources -I data_index.json | jq -R -s -c 'split("\n")[:-1]' > data_index.json

git add .
git commit -a -m "Day $currentDay data updated."
git push origin main

