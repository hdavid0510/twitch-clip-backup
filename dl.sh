#!/bin/bash


#### Preparation ####

# Install jq (for JSON parsing)
sudo apt -q  update
sudo apt -yq install jq

# Download twitch-dl if binary not present
TWITCHDL_REPO="https://github.com/ihabunek/twitch-dl/releases/download/2.0.1/twitch-dl.2.0.1.pyz"
TWITCHDL_BIN="twitch-dl"
if [ -f ${TWITCHDL_BIN} ]; then
	wget ${TWITCHDL_REPO} -O ${TWITCHDL_BIN}
fi
chmod +x ${TWITCHDL_BIN}
./${TWITCHDL_BIN}


#### SETTINGS ####

# <<<<EDIT>>>> ID of streamer's twitch ID
STREAMER="sngr__"
mkdir ${STREAMER}

# <<<<EDIT>>>> auth_token of YOUR twitch account. To get token, refer:
# https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods
AUTHTOKEN=""

# auth_token is required.
if [ -z ${AUTHTOKEN}]; then
	echo "ERROR: Twitch auth_token is invalid!"
	exit
fi


#### DOWNLOAD ####

# Download list into json
./${TWITCHDL_BIN} clips ${STREAMER} --json --all > ${STREAMER}/twitchclips.${STREAMER}.json

# Get array of clip URLS from json
arr=( $(jq -r '.[].slug' ${STREAMER}/twitchclips.${STREAMER}.json) )

# Download clips
NAMEFORMAT="{channel_login}__{datetime}__{game}__{id}__{title}.{format}"
TMP="$PWD/.twitchdltemp/${STREAMER}"
for i in "${!arr[@]}"; do 
	printf "%s/%s\t%s\n" "$i" "${#arr[@]}" "${arr[$i]}"
	./${TWITCHDL_BIN} download -q source --auth-token ${AUTHTOKEN} --output ${STREAMER}/${NAMEFORMAT} ${arr[$i]}
done
