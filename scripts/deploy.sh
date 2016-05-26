#!/bin/bash
set -o errexit

# Logging
echo "Info:";
echo "Branch: $TRAVIS_BRANCH";

# Exit if not a master
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
  echo "Not on master. Skipping Integration !!";
  exit;
else

  # Remove Build Folder
  rm -rf build

  # Build
  npm run build-deploy

  #using token clone gh-pages branch
  git clone --quiet --branch=gh-pages "https://${GITHUB_TOKEN}@${GITHUB_REF}.git"  gh-pages > /dev/null

  # Copy Files
  cp -r ./docs ./gh-pages
  cp -a ./build/. ./gh-pages

  # cd into gh-pages
  cd gh-pages

  # push
  git add --all
  git commit -m "Auto generated documentation $TRAVIS_BUILD_NUMBER by Travis"
  git push -fq origin gh-pages > /dev/null 2>&1

  echo "gh-pages updated";

  # Remove tempGHPages directory
  rm -rf gh-pages

fi
