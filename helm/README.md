# Helm chart

Hops 서비스를 위한 helm chart

## Kubernets Secrets 생성

.env 파일을 `values.yaml`을 참고하여 작성하신 후 아래 스크립트를 실행하세요.

```shell
kubectl create secret generic hops-secrets --namespace hops-self-hosted --from-env-file=.env
```

## Helm 업그레이드

```shell
helm upgrade --install hops -f ./values.yaml . --namespace hops-self-hosted --create-namespace
```

## Envoy

### 액세스 로그

커스터마이징을 하시려면 [Envoy AccessLog 문서][EnvoyAccessLogDocs]를 참고하여

`api-envoy-config-map.yaml` 에 있는 `access_log` 설정을 수정하세요.

[EnvoyAccessLogDocs]: https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/accesslog/v3/accesslog.proto#envoy-v3-api-msg-config-accesslog-v3-accesslog
