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

  # Added
  git config --global user.name "$COMMIT_AUTHOR_NAME"
  git config --global user.email "$COMMIT_AUTHOR_EMAIL"

  #using token clone gh-pages branch
  git clone --quiet --branch=gh-pages "https://${GITHUB_TOKEN}@${GITHUB_REF}.git"  gh-pages > /dev/null

  # Remove Old Docs
  rm -rf ./gh-pages/docs/

  # Copy Files
  cp -r ./docs ./gh-pages
  cp -a ./build/. ./gh-pages

  # cd into gh-pages
  cd gh-pages

  # push
  git add --all
  git commit -m "Travis CI: Build $TRAVIS_BUILD_NUMBER - Auto Generated Docs."
  git push -fq origin gh-pages > /dev/null 2>&1

  echo "gh-pages updated";

  # Remove tempGHPages directory
  rm -rf gh-pages

fi
