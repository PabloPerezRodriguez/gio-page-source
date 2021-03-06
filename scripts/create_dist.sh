#!/usr/bin/env bash

export CLONE_LOCATION="$HOME/github-page"
export GIT_ASKPASS="$GITHUB_WORKSPACE/scripts/git_askpass_helper.sh"


# Configure git alias
git config user.email "action@github.com"
git config user.name "GitHub Action"

# Remove the clone location (it seems like it's already created and git doesn't like that)
rm -rf "$CLONE_LOCATION"

# Clone the github.io page repo
git clone "https://pabloworker@github.com/PabloPerezRodriguez/pabloperezrodriguez.github.io" "$CLONE_LOCATION"

# Delete every file in the github.io page repo but keep the CNAME file.
find "$CLONE_LOCATION" -mindepth 1 -regextype posix-extended \! -regex "^$CLONE_LOCATION/(\\.git(/.*)?|CNAME)" -delete


###### Actually build ######

# Install dependencies
cd "$GITHUB_WORKSPACE"
yarn install
yarn build

cp -vr $GITHUB_WORKSPACE/dist/* $CLONE_LOCATION/
