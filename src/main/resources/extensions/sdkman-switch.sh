#!/bin/bash

function __sdk_switch {
	CANDIDATE="$1"
	if [[ -z "$CANDIDATE" ]]; then
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
		if [[ -z "$CANDIDATE" && -f gradle.properties ]]; then
			$(IFS=" ")
			POSSIBLE_CANDIDATES=( $(cat gradle.properties |grep ".*Version" |sed 's/Version.*//g') )
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
		VERSION=""
		if [[ -f application.properties && -d "$CANDIDATE-app" ]]; then
			VERSION=$(cat application.properties | grep "app.$CANDIDATE.version" | sed "s!app.$CANDIDATE.version=!!g")
		elif [[ -f gradle.properties && -d "$CANDIDATE-app" ]]; then
			VERSION=$(cat gradle.properties | grep ${CANDIDATE}Version | cut -d '=' -f2)
		fi
		if [[ -z "$VERSION" ]]; then
			echo "Stop! This is not a valid $CANDIDATE project!"
		else
			echo "Switching to $CANDIDATE $VERSION ..."
			__sdk_use "$CANDIDATE" "$VERSION"
		fi
	fi
}

