# Reverse Proxy로 배포

Hops 설치형 서비스를 배포하여 외부에서 접근해서 사용하려면 도메인을 할당해야
합니다.  이 문서에서는 nginx의 reverse proxy 기능을 활용하여 Hops 설치형
서비스의 구성 요소들을 배포하는 방법에 대해서 알아봅니다.

* [Reverse Proxy로 배포](#reverse-proxy로-배포)
  * [준비사항](#준비사항)
    * [도메인 결정](#도메인-결정)
    * [nginx](#nginx)
  * [시작하시기 전에](#시작하시기-전에)
    * [nginx 설정 방법](#nginx-설정-방법)
      * [sites-available 및 sites-enabled 디렉터리가 있는 경우](#sites-available-및-sites-enabled-디렉터리가-있는-경우)
      * [디렉터리가 없는 경우](#디렉터리가-없는-경우)
  * [Frontend 서비스 설정](#frontend-서비스-설정)
  * [API 서비스 설정](#api-서비스-설정)
  * [OAuth 서비스 설정](#oauth-서비스-설정)
  * [docker-compose.yaml 파일 수정](#docker-composeyaml-파일-수정)
  * [실행](#실행)
  * [HTTPS 배포](#https-배포)
    * [docker-compose.yaml 파일 수정](#docker-composeyaml-파일-수정-1)

## 준비사항

### 도메인 결정

Hops에서 사용할 도메인을 미리 정해서 Hops 설치형 서비스를 설치한 서버에
연결해주세요. 도메인은 최소 1개에서 최대 3개가 필요합니다. 이 문서에서는 다음과
같은 3개의 도메인을 Hops 설치형 서비스에 연결한다고 가정합니다.

- Frontend 서비스: hops.example.com
- API 서비스: api.hops.example.com
- OAuth 서비스: oauth.hops.example.com

### nginx

[Installing nginx](https://nginx.org/en/docs/install.html) 문서를 참조하여
nginx를 설치합니다.

## 시작하시기 전에

### nginx 설정 방법

Reverse Proxy 설정을 진행하려면 nginx에 설정 파일을 추가하는 작업이 필요합니다.

nginx를 설치하면 설치 환경에 따라 `/etc/nginx/` 디렉터리 밑에 `sites-available`
및 `sites-enabled` 디렉터리가 있거나 없을 수 있습니다.

디렉터리의 존재 여부를 확인하려면 다음 명령어를 실행해보세요:

```console
$ ls /etc/nginx/ | grep sites
```

아래와 같은 결과가 나온다면 디렉터리가 있는 것이고 그렇지 않다면 없는 것입니다.

```
sites-available
sites-enabled
```

디렉터리의 존재 여부를 확인한 후 다음 설명에 따라 추후에 이어지는 목차에서
설명하게 될 파일을 생성해주세요.

#### sites-available 및 sites-enabled 디렉터리가 있는 경우

`/etc/nginx/sites-available/` 디렉터리에 아래에 필요한 파일을 생성한 뒤
`/etc/nginx/sites-enabled/` 디렉터리에 만든 파일의 심볼릭 링크 파일을 만듭니다.

```console
# Frontend 서비스 설정용 hops.example.com 파일을 만드는 경우의 예시입니다.

$ sudo vim /etc/nginx/sites-available/hops.example.com
$ pushd /etc/nginx/sites-enabled
$ sudo ln -s ../sites-available/hops.example.com ./
$ popd
```

#### 디렉터리가 없는 경우

`/etc/nginx/conf.d/` 디렉터리에 필요한 파일을 생성합니다.

```console
# Frontend 서비스 설정용 hops.example.com 파일을 만드는 경우의 예시입니다.

$ sudo vim /etc/nginx/conf.d/hops.example.com
```

## Frontend 서비스 설정

설정 디렉터리에 다음과 같은 파일을 추가합니다.

`server_name` 항목의 도메인은 결정한 도메인으로 변경해주세요.

```
upstream hops {
    server 127.0.0.1:3000 fail_timeout=0;
}

server {
    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_For;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_pass http://hops_bright;
    }
    server_name "hops.example.com";
    listen 80;
}
```

## API 서비스 설정

설정 디렉터리에 다음과 같은 파일을 추가합니다.

`server_name` 항목의 도메인은 결정한 도메인으로 변경해주세요.

다른 서비스의 설정 파일과는 다르게 `proxy_http_version 1.1;` 줄이 추가되어 있는
것에 유의하세요.

```
upstream hops_api {
    server 127.0.0.1:3001 fail_timeout=0;
}

server {
    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_For;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_http_version 1.1;
        proxy_pass http://hops_api;
    }
    server_name "api.hops.example.com";
    listen 80;
}
```

## OAuth 서비스 설정

설정 디렉터리에 다음과 같은 파일을 추가합니다.

`server_name` 항목의 도메인은 결정한 도메인으로 변경해주세요.

```
upstream hops_oauth {
    server 127.0.0.1:3002 fail_timeout=0;
}

server {
    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_For;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $http_host;
        proxy_pass http://hops_oauth;
    }
    server_name "oauth.hops.example.com";
    listen 80;
}
```

## docker-compose.yaml 파일 수정

`docker.compose.yaml` 파일의 `services.frontend.environment` 항목을 다음과 같이
결정한 도메인에 맞게 수정해줍니다.  다른 값은 그대로 유지해주세요.

```yaml
services:
  frontend:
    environment:
      API_URL: "http://api.hops.example.com"
      OAUTH_URL: "http://oauth.hops.example.com"
```

## 실행

이제 nginx 서비스를 재시작하고 Docker Compose 서비스를 시작하면 서버에 연결한
도메인으로 Hops 설치형 서비스를 이용하실 수 있습니다.

```console
$ sudo systemctl restart nginx
$ docker compose up
```

## HTTPS 배포

nginx reverse proxy로 Hops 설치형 서비스를 배포한 경우,
[certbot](https://certbot.eff.org/)을 활용하면 몇 번의 명령어 실행만으로 손쉽게
[Let's Encrypt](https://letsencrypt.org/)의 인증서를 발급받아 HTTPS로 배포할 수
있습니다.  자세한 내용은 [certbot
instructions](https://certbot.eff.org/instructions) 문서를 참조하세요.

### docker-compose.yaml 파일 수정

certbot을 통해 인증서를 발급받아 nginx에 적용한 경우 `docker.compose.yaml`
파일의 `services.frontend.environment` 항목을 다음과 같이 수정해줘야 합니다.
`http`를 `https`로 수정해주시고 다른 값은 그대로 유지해주세요.

```yaml
services:
  frontend:
    environment:
      API_URL: "https://api.hops.example.com"
      OAUTH_URL: "https://oauth.hops.example.com"
```
