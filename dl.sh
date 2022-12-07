#!/bin/bash


## Read settings (Parameter)

function usage(){
	echo -e "usage: $0 DIRECTORY STREAMERID TWITCHTOKEN\n"
	echo -e "DIRECTORY\tDirectory to download clips and twitch-dl binary."
	echo -e "STREAMERID\tID of twitch streamer."
	echo -e "TWITCHTOKEN\tTwitch auth token. How to get this: refer https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods"
	echo -e ""
	return
}
if [ -z "$3" ]; then
	echo -e "ERROR: too few arguments."
	usage
	exit 1
fi
DOWNLOAD_DIR="$1"
STREAMER="$2"
AUTHTOKEN="$3"


## Get jq (for JSON parsing)

echo -e "\n\e[93mInstalling jq for JSON parsing\e[0m"
isjqinstalled=$(dpkg-query -W --showformat='${Status}\n' jq|grep "install ok installed")
if [ "" = "${isjqinstalled}}" ]; then
	sudo apt -qq  update
	sudo apt -qqy install jq
else
	echo "$(jq --version) already present, skipping installation."
	
fi


## Prepare download directory

echo -e "\n\e[93mPreparing download location:\e[0m ${DOWNLOAD_DIR}"
mkdir -p ${DOWNLOAD_DIR}
if [ ! -d ${DOWNLOAD_DIR} ]; then
	echo "ERROR: Unable to use download location"
	exit 1
fi


## Parse streamer ID

echo -e "\n\e[93mLoading streamer ID\e[0m"
if [ -z ${STREAMER} ] || [ "${STREAMER}" == "please_fill_this" ]; then
	echo "ERROR: Streamer ID(${STREAMER}) is not set or invalid!"
	exit 1
fi
echo "Streamer ID: ${STREAMER}"
mkdir -p ${DOWNLOAD_DIR}/${STREAMER}


## Parse Twitch auth token

echo -e "\n\e[93mLoading Twitch auth token\e[0m"
if [ -z ${AUTHTOKEN} ] || [ "${AUTHTOKEN}" == "please_fill_this" ]; then
	echo "ERROR: Twitch auth_token is not set or malformed!"
	echo ""
	exit 1
fi


## Get twitch-dl
TWITCHDL_REPO="https://github.com/ihabunek/twitch-dl/releases/download/2.0.1/twitch-dl.2.0.1.pyz"
TWITCHDL_BIN="${DOWNLOAD_DIR}/twitch-dl"

echo -e "\n\e[93mFetching twitch-dl\e[0m"
if [ -f ${TWITCHDL_BIN} ]; then
	echo "twitch-dl already exists, skipping download."
else
	wget -q ${TWITCHDL_REPO} -O ${TWITCHDL_BIN}
fi
chmod +x ${TWITCHDL_BIN}
./${TWITCHDL_BIN} --version


## Download list into json

echo -e "\n\e[93mFetching clip list\e[0m"
echo + ./${TWITCHDL_BIN} clips ${STREAMER} --json --all > ${DOWNLOAD_DIR}/${STREAMER}/twitchclips.${STREAMER}.json
./${TWITCHDL_BIN} clips ${STREAMER} --json --all > ${DOWNLOAD_DIR}/${STREAMER}/twitchclips.${STREAMER}.json


## Parse list json

echo -e "\n\e[93mExtracting clip URLS from clip list\e[0m"
clips=( $(jq -r '.[].slug' ${DOWNLOAD_DIR}/${STREAMER}/twitchclips.${STREAMER}.json) )
echo -e "${#clips[@]} clips found!"

## Download!
NAMEFORMAT="{channel_login}__{datetime}__{game}__{id}__{title}.{format}"
TMP="${DOWNLOAD_DIR}/.twitchdltemp/${STREAMER}"

echo -e "\n\e[93mDownloading clips!\e[0m"
for i in "${!clips[@]}"; do 
	printf "\n%d of %d %3d%%\t%s\n" "$((i+1))" "${#clips[@]}" "$((100*(i+1)/${#clips[@]}))" "${clips[$i]}"
	./${TWITCHDL_BIN} download --overwrite -q source --auth-token ${AUTHTOKEN} --output ${DOWNLOAD_DIR}/${STREAMER}/${NAMEFORMAT} ${clips[$i]}
done
