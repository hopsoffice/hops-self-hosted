# Hops Self Hosted

원하는 환경에 Hops를 설치하여 사용해보세요. 이 저장소에 준비된 스크립트와
Docker Compose 환경 설정을 활용하면 5분 안에 Hops를 바로 실행해볼 수 있습니다.

![](https://hopsoffice.github.io/misc/public/hops-hero-animated-no-play.png)

## 한 줄 설치

```console
$ bash <(curl -fsSL https://github.com/hopsoffice/hops-self-hosted/releases/download/0.2/download.sh)
$ cd hops_self_hosted_0.2
$ ./configure.sh
$ docker login registry.hopsoffice.com
$ docker compose up
```

## 준비사항

### Docker, Docker Compose

[Install Docker Engine](https://docs.docker.com/engine/install/) 문서를
참조하여 Docker 및 Docker Compose를 설치하세요.

### 홉스 Docker 이미지 저장소 계정과 라이센스 ID

Hops를 설치하여 사용하려면 홉스 Docker 이미지 저장소에 접근할 수 있는 계정과
라이센스 ID를 발급받아야 합니다.  홉스를 설치하여 사용해보고자 하신다면
[contact@hopsoffice.com](mailto:contact@hopsoffice.com)으로 메일을 주시거나 [이
링크](https://sendtime.app/ko/reservation?i=WeopdU)에서 상담을 신청해주세요.

### 시크릿 키 생성

로그인 및 인증 과정을 안전하게 하기 위해 사용되는 시크릿 키를 설치 과정 중에
입력해야 합니다.  시크릿 키는 32바이트 크기의 문자열을 base64로 인코딩한
값이며, 다음과 같은 명령어로 간단히 생성할 수 있습니다.

```console
$ openssl rand -hex 16 | base64
```

## 설치

저장소를 다운로드받은 후 `configure.sh`를 실행하고 설명대로 진행합니다.

```console
$ ./configure.sh
:: Database Configurations

A PostgreSQL database container will be created in docker compose service.
Please enter the information about the database instance will be created.

Database Name [hops]: hops
Username [hops]: hops
Password [secret]: secret

...

Configuration finished! Saving configurations...
```

실행이 완료되면 입력된 내용을 기반으로 `.env` 파일이 생성됩니다.

## 실행

설치가 완료된 상태에서 Docker Compose 서비스를 실행하면 Hops가 실행됩니다.

```console
$ docker login registry.hopsoffice.com
$ docker compose up
```

이제 브라우저를 열고 설정한 도메인으로 접속하시면 됩니다.  Deploy Domain 값을
기본값으로 설정하신 경우 http://localhost:3000 주소로 접속해보세요.
