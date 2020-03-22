#!/bin/sh

cd public/

msg="updateing site $(date)"

git add . 
git commit -f -m "$msg"

git push origin master
