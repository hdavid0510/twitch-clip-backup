# Twitch clip batch downloader

Batch download twitch clips with [twitch-dl](https://github.com/ihabunek/twitch-dl).


## Requirements

* Ubuntu 20.04 with python3 installed
	* confirmed working on WSL


## How to use
* Clone this repository.
* Edit `dl.sh`
	* Fill in `STREAMER` with the streamer's ID
	* Fill in `AUTHTOKEN` with your twitch auth_token - refer [documentation](https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods) for detailed explanation.
* Run `dl.sh`
	* Clips of `STREAMER` will stored inside the directory `STREAMER`.
	* JSON clip list file will also be saved in the directory `STREAMER`.
