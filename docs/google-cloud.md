# Google Cloud 프로젝트 연동

Hops 설치형 서비스에서 Google Cloud 프로젝트를 연동하여 Google Sheets 데이터
소스를 사용하는 방법에 대해서 설명합니다.  다음 설명을 찬찬히 따라하여 Hops에서
Google Sheets 데이터 소스를 사용할 수 있도록 설정해보세요.

* [Google Cloud 프로젝트 연동](#google-cloud-프로젝트-연동)
  * [Google Cloud 프로젝트 생성](#google-cloud-프로젝트-생성)
  * [Google Sheets, Google Drive API 사용 설정](#google-sheets-google-drive-api-사용-설정)
  * [OAuth 동의 화면 설정](#oauth-동의-화면-설정)
  * [OAuth 클라이언트 ID 만들기](#oauth-클라이언트-id-만들기)
  * [클라이언트 ID 및 비밀번호 적용](#클라이언트-id-및-비밀번호-적용)

## Google Cloud 프로젝트 생성

Google Cloud Console에 접속하여 [프로젝트를 생성]하세요.

[프로젝트를 생성]: https://console.cloud.google.com/projectcreate

## Google Sheets, Google Drive API 사용 설정

1. [Google Sheets API] 페이지로 이동하세요.
2. ‘사용’ 버튼을 클릭하세요.
3. [Google Drive API] 페이지로 이동하세요.
4. ‘사용’ 버튼을 클릭하세요.

[Google Sheets API]: https://console.cloud.google.com/apis/library/sheets.googleapis.com
[Google Drive API]: https://console.cloud.google.com/apis/library/drive.googleapis.com
[API 및 서비스]: https://console.cloud.google.com/apis/dashboard

## OAuth 동의 화면 설정

1. [OAuth 동의 화면] 페이지로 이동하세요.
2. ‘내부’를 선택하시고 ‘다음’을 클릭하세요.
3. 필요한 정보를 입력한 후 ‘저장 후 계속’을 클릭하세요.
4. ‘범위 추가 또는 삭제’를 클릭하세요.
5. 하단의 ‘직접 범위 추가’ 텍스트 박스를 찾아 다음 내용을 붙여 넣습니다.
   ```
   https://www.googleapis.com/auth/userinfo.email
   https://www.googleapis.com/auth/userinfo.profile
   https://www.googleapis.com/auth/drive.metadata.readonly
   https://www.googleapis.com/auth/spreadsheets
   ```
6. ‘테이블에 추가’ 버튼을 클릭한 후 ‘업데이트’ 버튼을 클릭합니다.
7. ‘저장 후 계속’ 버튼을 클릭합니다.
8. 입력한 내용이 잘 적용되었는지 확인한 후 ‘대시보드로 돌아가기’ 버튼을 클릭합니다.

[OAuth 동의 화면]: https://console.cloud.google.com/apis/credentials/consent

## OAuth 클라이언트 ID 만들기

1. [OAuth 클라이언트 ID 만들기] 페이지로 이동하세요.
2. ‘애플리케이션 유형’ 중 ‘웹 애플리케이션’을 선택하세요.
3. ‘승인된 리디렉션 URI’ 항목의 ‘URI 추가’ 버튼을 눌러 다음 값을 추가합니다.
   ```
   http://localhost:3002/login/oauth2/code/google
   ```
   - `localhost` 부분은 [서비스 배포 도메인 설정]에 맞게 변경해주세요.
4. ‘만들기’ 버튼을 클릭합니다.

[OAuth 클라이언트 ID 만들기]: https://console.cloud.google.com/apis/credentials/oauthclient
[서비스 배포 도메인 설정]: ./docs/env.md#배포-환경

## 클라이언트 ID 및 비밀번호 적용

이후 화면에서 만들어진 클라이언트의 ID와 보안 비밀번호가 표시됩니다.
클라이언트의 ID와 보안 비밀번호를 복사하여 [Hops 데이터 소스 설정]에서 각각
Google OAuth 2.0 Client ID와 Google OAuth 2.0 Client Secret의 값으로 설정하면
됩니다. 설정이 완료되면 Hops를 재시작해주세요.

Hops에서 Google Sheets 데이터 소스를 연결하여 사용하는 방법은 Hops 공식 문서 중
[Google Sheets] 문서를 참조하세요.

[Hops 데이터 소스 설정]: ./docs/env.md##Hops-데이터-소스
[Google Sheets]: https://docs.hops.pub/guides/data-source/google-sheets
