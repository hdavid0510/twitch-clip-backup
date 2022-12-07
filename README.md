# Twitch clip batch downloader

Batch download twitch clips with [twitch-dl](https://github.com/ihabunek/twitch-dl).


## Requirements

* Ubuntu 20.04 with python3 installed
	* Use WSL if using Windows!


## How to use

### Download
Clone Git repository
```
git clone https://github.com/hdavid0510/twitch-clip-backup
```
...or download [script](https://github.com/hdavid0510/twitch-clip-backup/blob/master/dl.sh) directly.

### Run
```
dl.sh DIRECTORY STREAMERID TWITCHTOKEN
```
* `DIRECTORY`: Directory to download clips and twitch-dl binary.
* `STREAMERID`: ID of twitch streamer.
* `TWITCHTOKEN`: Twitch auth token. Refer [documentation](https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods) for details.

  

# 트위치 클립 다운로더

[twitch-dl](https://github.com/ihabunek/twitch-dl)을 이용한 트위치 클립 다운로더입니다.


## 요구사항

* python3이 설치된 Ubuntu 20.04
	* 윈도우 환경의 경우 WSL을 통해서도 사용 가능합니다.


## 사용방법

### 내려받기
Git 리포지토리를 클론하거나
```
git clone https://github.com/hdavid0510/twitch-clip-backup
```
...[스크립트](https://github.com/hdavid0510/twitch-clip-backup/blob/master/dl.sh) 파일 직접 내려받으세요.

### 실행
```
dl.sh 디렉터리 스트리머ID 트위치토큰
```
* `디렉터리`: 클립과 twitch-dl을 다운받을 위치(폴더)입니다.
* `스트리머ID`: 트위치 스트리머의 ID입니다.
* `트위치토큰`: 자신의 트위치 토큰입니다. 자세한 설명은 [문서(영문)](https://twitch-dl.bezdomni.net/commands/download.html#downloading-subscriber-only-vods)를 참조해주시기 바랍니다.
