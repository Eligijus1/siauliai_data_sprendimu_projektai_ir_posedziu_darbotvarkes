@echo off

php download.php

git add *
git commit -a -m "Added new data"
git push origin main

pause