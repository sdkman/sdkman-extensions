#!/bin/bash

CANDIDATE="$1"
if [[ -z "$CANDIDATE" ]]; then
	echo "No candidate provided."
	exit 0
fi

if [[ -f application.properties && -d "$CANDIDATE-app" ]]; then
	VERSION=$(cat application.properties | grep 'app.grails.version' | sed 's_app.grails.version=__g')
	echo "Switching to $CANDIDATE $VERSION ..."
	gvm use "$CANDIDATE" "$VERSION"
else
	echo "Stop! This is not a valid $CANDIDATE project!"
fi
