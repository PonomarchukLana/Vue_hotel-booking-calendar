#!/usr/bin/env sh

# abort on errors
set -e

# build the project (replace with your actual build command)
npm run build

# navigate into the build output directory
cd dist

# if you are deploying to a custom domain
# echo 'www.yourcustomdomain.com' > CNAME

git init
git checkout -B main
git add -A
git commit -m 'deploy'

# if deploying to https://<USERNAME>.github.io
# git push -f git@github.com:USERNAME/USERNAME.github.io.git main

# if deploying to https://<USERNAME>.github.io/<REPO>
git push -f git@github.com:PonomarchukLana/vue2_hotel-booking-calendar.git main:gh-pages

cd -
