#!/bin/sh

echo "tap: "
brew tap
echo ""
echo "brew: "
brew leaves
echo ""
echo "cask: "
brew cask list
echo ""
echo "npm: "
npm list -g --depth=0
