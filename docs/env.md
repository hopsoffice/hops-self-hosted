# 환경 변수

`.env` 파일에 정의되어 있는 환경 변수에 대한 상세한 설명입니다.

- [환경 변수](#환경-변수)
  - [데이터베이스](#데이터베이스)
  - [Hops 데이터소스](#Hops-데이터-소스)
  - [Hops 로그인](#Hops-로그인)
  - [라이센스](#라이센스)
  - [배포 환경](#배포-환경)

## 데이터베이스

Docker Compose 서비스에서 PostgreSQL 데이터베이스 컨테이너가 생성됩니다.
생성된 데이터베이스 컨테이너는 Hops 백엔드의 데이터베이스로 사용하게 됩니다.

| 환경 변수 이름         | 설명                                          | 필수 여부 | 기본값      |
|------------------|---------------------------------------------|-------|----------|
| HOPS_DB_NAME     | 생성되는 데이터베이스의 데이터베이스 이름                      | O     | hops     |
| HOPS_DB_USERNAME | 생성되는 데이터베이스의 계정 유저 이름                       | O     | postgres |
| HOPS_DB_PASSWORD | 생성되는 데이터베이스의 계정 패스워드                        | O     | postgres |
| HOPS_DB_DATA     | 생성되는 데이터베이스의 내부 데이터. PostgreSQL의 데이터 파일입니다. | O     | ./pgdata |

## Hops 데이터 소스

Google Sheets 연동을 위한 정보는 [Google Cloud Console]에서 만드실 수 있습니다.
자세한 내용은 [Google Cloud 프로젝트 연동] 문서를 참조하세요.

[Google Cloud Console]: https://console.cloud.google.com/
[Google Cloud 프로젝트 연동]: ./google-cloud.md

| 환경 변수 이름             | 설명                                                  | 필수 여부 | 기본값 |
|----------------------|-----------------------------------------------------|-------|-----|
| GOOGLE_CLIENT_ID     | Google Sheets 연동을 위한 Google OAuth 2.0 Client ID     | X     |     |
| GOOGLE_CLIENT_SECRET | Google Sheets 연동을 위한 Google OAuth 2.0 Client Secret | X     |     |

## Hops 로그인

첫 번째 실행 시 생성되는 초기 사용자의 정보와 로그인 및 인증 프로세스를
보호하기 위해 비밀 키 정보입니다.  비밀 키는 32바이트 크기의 문자열로 base64로
인코딩된 값이어야 합니다.

| 환경 변수 이름                   | 설명                                        | 필수 여부 | 기본값           |
|----------------------------|-------------------------------------------|-------|---------------|
| HOPS_INITIAL_USER_EMAIL    | 첫번째 설치형 서비스 실행시 생성되는 초기 사용자의 이메일          | O     | test@test.com |
| HOPS_DEFAULT_USER_PASSWORD | 설치형 서비스에 추가되는 계정의 초기 비밀번호                 | O     | test          |
| HOPS_SECRET_KEY            | 로그인 인증을 위한 비밀 키. 자동으로 생성하여 사용하는 것을 권장합니다. | O     |               |

## 라이센스

Hops를 이용하기 위해 필요한 라이센스 정보입니다.  발급을 위해서
[contact@hopsoffice.com]으로 메일을 주시거나 [Hops 상담 신청 페이지]에서 상담을
신청해주세요.  기본값으로 입력되는 라이센스 ID는 유효하지 않은 라이센스입니다.

[contact@hopsoffice.com]: mailto:contact@hopsoffice.com
[Hops 상담 신청 페이지]: https://sendtime.app/ko/reservation?i=Weopd

| 환경 변수 이름        | 설명           | 필수 여부 | 기본값                                  |
|-----------------|--------------|-------|--------------------------------------|
| HOPS_LICENSE_ID | Hops 라이센스 ID | O     | 5272a366-55f7-4c47-95ef-934864d1942d |

## 배포 환경

Hops 설치형 서비스 배포에 관련된 설정입니다.

| 환경 변수 이름           | 설명                  | 필수 여부 | 기본값       |
|--------------------|---------------------|-------|-----------|
| HOPS_DEPLOY_DOMAIN | Hops 설치형 서비스 배포 도메인 | O     | localhost |
