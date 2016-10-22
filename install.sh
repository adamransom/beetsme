#!/bin/sh

# Simply symlink this binary into somewhere (hopefully) in the path
ln -s "$PWD/beetsme" /usr/local/bin/beetsme
# Symlink the beets config into correct location
ln -s "$PWD/beets.config.yaml" ~/.config/beets/config.yaml
