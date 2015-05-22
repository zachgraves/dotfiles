#!/bin/bash

###   ##  ### #### ### #    #### ####
#  # #  #  #  #     #  #    #    #
#  # #  #  #  ###   #  #    ###  ####
#  # #  #  #  #     #  #    #       #
###   ##   #  #    ### #### #### ####

DIR=~/dev/dotfiles
FILES="tmux.conf vimrc vimrc.bundles zshrc gemrc gitconfig gitmessage"

echo -n "Updating previous symlinks"

for file in $FILES; do
  echo -n "."
  rm ~/.$file                # Remove old file
  ln -s $DIR/.$file ~/.$file # Add new reference.
done

echo "Done!"
