#!/bin/bash

function __gvmtool_toggleindy {
	CANDIDATE="$1"
	if [[ -z "$CANDIDATE" ]]; then
		echo "No candidate provided."
	elif [[ "$CANDIDATE" != "groovy" ]]; then
		echo "Stop! The candidate must be groovy!"
	else
		if [[ -L $GROOVY_HOME/lib ]] ; then
			if [[ $(readlink -f $GROOVY_HOME/lib) = $(readlink -f $GROOVY_HOME/lib_indy) ]] ; then
				echo Configuring groovy to use nonindy jars.
				rm $GROOVY_HOME/lib
				ln -s $GROOVY_HOME/lib_nonindy $GROOVY_HOME/lib
			else
				echo Configuring groovy to use indy jars.
				rm $GROOVY_HOME/lib
				ln -s $GROOVY_HOME/lib_indy $GROOVY_HOME/lib
			fi
		else

			echo Doing initial setup for toggleindy.

			# Rename groovy's lib to lib_nonindy.
			mv $GROOVY_HOME/lib $GROOVY_HOME/lib_nonindy

			# Make a lib_indy subdir with symlinks to make it a drop-in
			# replacement for lib.	This allows switching back and forth to
			# indy by just repointing the lib symlink at lib_indy or
			# lib_nonindy.
			mkdir $GROOVY_HOME/lib_indy
			for J in $GROOVY_HOME/lib_nonindy/*.jar; do
				ln -s $J $GROOVY_HOME/lib_indy/$(basename $J)
			done
			for J in $GROOVY_HOME/indy/*-indy.jar; do
				local JARFILE=$(basename $J)
				ln -s -f $J $GROOVY_HOME/lib_indy/${JARFILE%-indy.jar}.jar
			done

			# Make the lib symlink pointing at lib_indy.
			echo configuring groovy to use indy jars
			ln -s $GROOVY_HOME/lib_indy $GROOVY_HOME/lib

			# to reverse this:
			# rm $GROOVY_HOME/lib_indy/*
			# rmdir $GROOVY_HOME/lib_indy
			# rm $GROOVY_HOME/lib
			# mv $GROOVY_HOME/lib_nonindy $GROOVY_HOME/lib

		fi
	fi
}
