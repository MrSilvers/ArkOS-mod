#!/bin/bash

# contents list
# ; Item #0 'OFF'
# ; Item #1 'SPK'
# ; Item #2 'HP'
# ; Item #3 'SPK_HP'

# controls list
# numid=5,iface=CARD,name='Headphone Jack'
# numid=2,iface=MIXER,name='Capture MIC Path'
# numid=1,iface=MIXER,name='Playback Path'
# numid=3,iface=MIXER,name='Playback Volume'
# numid=4,iface=MIXER,name='Record Volume'

sudo -s

CARD=0
CTL_NUMID=1

# get current value
PLAYBACK_MUX=$(amixer -c $CARD cget numid=$CTL_NUMID | grep -E "^  : values=" | awk -F= '{print $2}' | tr -d ' ')

if [ "$PLAYBACK_MUX" != "1" ]; then
    echo "[AudioFix] current is not speaker, switch to speaker"
    amixer -c $CARD cset numid=$CTL_NUMID 1 >/dev/null
else
    echo "[AudioFix] current is speaker, no change"
fi