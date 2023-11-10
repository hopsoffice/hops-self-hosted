#!/bin/bash
function buildEnv { 
    defaultSecretKey="$(hexdump -vn16 -e'4/4 "%08X" 1 "\n"' /dev/urandom | base64)"
    cat <<EOF
HOPS_DB_NAME="${1:-hops}"
HOPS_DB_USERNAME="${2:-hops}"
HOPS_DB_PASSWORD="${3:-secret}"
HOPS_INITIAL_USER_EMAIL="${4:-"test@test.com"}"
HOPS_DEFAULT_USER_PASSWORD="${5:-test}"
HOPS_SECRET_KEY="${6:-"$defaultSecretKey"}"
HOPS_DEPLOY_DOMAIN="${7:-localhost}"
GOOGLE_CLIENT_ID="${8:-}"
GOOGLE_CLIENT_SECRET="${9:-}"
HOPS_LICENSE_ID="${10:-"5272a366-55f7-4c47-95ef-934864d1942d"}"
HOPS_DB_DATA="${11:-"./pgdata"}"
EOF
}

buildEnv "$@"
