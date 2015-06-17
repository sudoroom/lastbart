#!/bin/bash

NODEPATH="/usr/bin/nodejs"
LASTBARTPATH="/home/jerkey/lastbart/lastbart.js"
BC_CMD="/usr/bin/bc"

FROM_STATION="macarthur"
DESTINATION=$1 # which destination sf fremont pittsburg richmond
DESTINATION_SPEAK=$2 # How to say the destination

LESSTHAN=1800 # begin alerting when there is less than 30 min until last BART
MORETHAN=600 # stop alerting when there is less than 10 min until last BART

CMD="${NODEPATH} ${LASTBARTPATH} -n ${FROM_STATION} to ${DESTINATION}"

SECONDS=`eval $CMD`

# Minutes and seconds left
MIN=`echo "${SECONDS} / 60" | ${BC_CMD}`
SEC=`echo "${SECONDS} % 60" | ${BC_CMD}`

SPEECH="Last bart toward ${DESTINATION_SPEAK} is departing in ${MIN} minutes." # and ${SEC} seconds"

if (( SECONDS < LESSTHAN )) && (( SECONDS > MORETHAN )); then

/usr/bin/mplayer -ao alsa -really-quiet -noconsolecontrols "http://translate.google.com/translate_tts?tl=en&q=${SPEECH}"

fi
