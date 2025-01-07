# Hops 설치형 서비스

원하는 환경에 Hops를 설치하여 사용해보세요. 이 저장소에 준비된 스크립트와
Docker Compose 환경 설정을 활용하면 5분 안에 Hops를 바로 실행해볼 수 있습니다.

![hops hero image](https://hopsoffice.github.io/misc/public/hops-hero-animated-no-play.png)

## 한 줄 설치

문서를 읽어볼 시간이 없으시다면 아래 명령어로 누구보다 빠르게 홉스를
실행해보세요.

```console
$ bash <(curl -fsSL https://github.com/hopsoffice/hops-self-hosted/releases/download/0.4/download.sh)
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
$ hexdump -vn16 -e '4/4 "%08X"' /dev/urandom | base64
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

## Envoy

### 액세스 로그

커스터마이징을 하시려면 [Envoy AccessLog 문서][EnvoyAccessLogDocs]를 참고하여

`api-envoy-config-map.yaml` 에 있는 `access_log` 설정을 수정하세요.

[EnvoyAccessLogDocs]: https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/accesslog/v3/accesslog.proto#envoy-v3-api-msg-config-accesslog-v3-accesslog

## 기타 문서

- Hops 설치형 서비스에서 사용하는 환경 변수에 대해서 궁금하신가요?
   - 💁 [환경 변수 문서](./docs/env.md)를 참고해주세요.
- Hops 설치형 서비스에 도메인을 연결하여 배포하고 싶으신가요?
   - 💁 [Reverse Proxy로 배포 문서](./docs/reverse-proxy.md)를 참고해주세요.
- 구글 스프레드시트 데이터 소스를 연동하여 사용하고자 하시나요?
   - 💁 [Google Cloud 프로젝트 연동 문서](./docs/google-cloud.md)를 참고해주세요.
