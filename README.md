Doctissimo
=============

0. [Git Flow](#0-git-flow)
1. [Prerequisites](#1-prerequisites)
2. [Installation](#2-installation)
3. [Running the server](#3-running-the-server)
4. [Env variables](#4-env-variables)

## 0. Git Flow

| Branch | Role |
| ------------- | ------------- |
| master | Is the production releases branch |
| dev | Is the development branch |
| The pattern : 'feature/' (followed by the feature's name) | Is used to create features and then deploy them by merging on dev |
| The pattern : 'hotfix/' (followed by the hotfix name) | Is used to fix (one or more) bug(s) and then deploy it by merging on dev/master |
| The pattern : 'release/' (followed by the release's name) | Is used to release and test a version and then deploy it by merging on master |

## 1. Prerequisites

- [Open SSL](https://www.openssl.org/source/)
- [Docker CE](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/) >=1.24

## 2. Installation

### 2.a Installing docker

Please install docker, then:

```bash
sudo usermod -a -G docker $USER
sudo chown $USER:$USER ~/.docker/config.json
```

and verify that you can do a `docker ps`

### 2.b Cloning the repository

```bash
git clone --recurse-submodules git@github.com:tifo1985/Doctissimo.git
```

_IF AND ONLY IF ou didnt cloned with `--recurse-submodules` option, you have to do those following command:

```bash
git submodule init
git submodule update
```

### 2.c Installation

Run:
```bash
make install
```
It will generate you a `.env` file, YOU SHOULD verify it
You can see possible variable and explanation on [4. env variable section](#4-env-variables)

## 3. Running the server

When the project is already installed (after a reboot for example), to start it just do a :
```bash
make start
```
