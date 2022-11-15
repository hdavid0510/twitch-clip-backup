# Twitch clip batch downloader

Batch download twitch clips with [twitch-dl](https://github.com/ihabunek/twitch-dl).


## Requirements

* Ubuntu 20.04 with python3 installed
	* confirmed working on WSL


## How to use
* Clone this repository.
* Edit `dl.sh`.
	* Fill in `STREAMER` with the streamer's ID
	* Fill in `AUTHTOKEN` with your twitch auth_token - refer [documentation](https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods) for details.
* Run `dl.sh`.
	* Clips of `STREAMER` will stored inside the directory `STREAMER`.
	* JSON clip list file will also be saved in the directory `STREAMER`.



# 트위치 클립 다운로더

[twitch-dl](https://github.com/ihabunek/twitch-dl)을 이용한 트위치 클립 다운로더입니다.


## 요구사항

* python3이 설치된 Ubuntu 20.04
	* 윈도우 환경의 경우 WSL을 이용하면 사용 가능합니다.


## 사용방법
* 이 리포지토리를 내려받으세요(clone).
* `dl.sh`파일을 수정하세요.
	* `STREAMER`에 스트리머의 채널 ID를 입력하세요.
	* `AUTHTOKEN`에 자신의 트위치 auth_token을 입력하세요. 자세한 설명은 [문서(영문)](https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods)를 참조해주시기 바랍니다.
* `dl.sh`을 실행합니다.
	* `STREAMER`의 클립은 스트리머 ID로 된 폴더가 생성되고 그 안에 저장됩니다.
	* 클립 목록 파일 또한 스트리머 ID로 된 폴더 안에 JSON 형식으로 저장됩니다.
