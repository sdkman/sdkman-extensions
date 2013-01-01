#!/bin/bash

function __gvmtool_switch {
	CANDIDATE="$1"
	if [[ -z "$CANDIDATE" ]]; then
		echo "No candidate provided."
	else
		if [[ -f application.properties && -d "$CANDIDATE-app" ]]; then
			VERSION=$(cat application.properties | grep "app.$CANDIDATE.version" | sed "s!app.$CANDIDATE.version=!!g")
			echo "Switching to $CANDIDATE $VERSION ..."
			__gvmtool_use "$CANDIDATE" "$VERSION"
		else
			echo "Stop! This is not a valid $CANDIDATE project!"
		fi
	fi
}	

