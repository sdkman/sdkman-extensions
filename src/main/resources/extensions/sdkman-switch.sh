#!/bin/bash

function __sdk_switch {
	CANDIDATE="$1"
	if [[ -z "$1" ]]; then
		if [[ -f application.properties ]]; then
			$(IFS=" ")
			POSSIBLE_CANDIDATES=( $(cat application.properties | grep "app\..*\.version" | sed 's/app.//' | sed 's/.version.*//g') )
			for c in "${POSSIBLE_CANDIDATES[@]}"
			do
				if [[ "$SDKMAN_CANDIDATES_CSV" == *"${c}"* ]]; then
					CANDIDATE="${c}"
				fi
			done
		fi
	fi

	if [[ -z "$CANDIDATE" ]]; then
		echo "No candidate provided."
	else
		if [[ -f application.properties && -d "$CANDIDATE-app" ]]; then
			VERSION=$(cat application.properties | grep "app.$CANDIDATE.version" | sed "s!app.$CANDIDATE.version=!!g")
			echo "Switching to $CANDIDATE $VERSION ..."
			__sdk_use "$CANDIDATE" "$VERSION"
		else
			echo "Stop! This is not a valid $CANDIDATE project!"
		fi
	fi
}

