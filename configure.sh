#!/usr/bin/env bash

echo ':: Database Configurations'
echo
echo 'A PostgreSQL database container will be created in docker compose service.'
echo 'Please enter the information about the database instance will be created.'
echo
read -p 'Database Name [hops]: ' dbName
read -p 'Username [hops]: ' dbUsername
read -sp 'Password [secret]: ' dbPassword
echo
echo
echo

echo ':: Initial User Configuration'
echo
echo 'Initial user will be created on first run.'
echo 'Please enter the information about the initial user.'
echo
read -p 'Initial user email: ' initialUserEmail
while [[ $initialUserEmail == '' ]]
do
    echo 'Please enter the initial user email.'
    read -p "Initial user email: " initialUserEmail
done
read -sp 'Default user password: ' defaultUserPassword
echo
while [[ $defaultUserPassword == '' ]]
do
    echo 'Please enter the default user password.'
    read -sp "Default user password: " defaultUserPassword
    echo
done
echo
echo

echo ':: Secret Key Configuration'
echo
echo 'Please provide a secret key to secure the login and authentication process.'
echo 'Secret key must be base64-encoded value of string of 32 bytes in size.'
echo "If you don't know how to make secret key, please read README.md."
echo
read -sp 'Secret Key: ' secretKey
echo
while [[ $secretKey == '' ]]
do
    echo 'Please enter the secret key.'
    read -sp "Secret Key: " secretKey
    echo
done
echo
echo

echo ':: Deploy Domain Configuration'
echo
echo 'Keeping the settings at their defaults is sufficient for a quick try.'
echo 'However, if you want to actually use it with a reverse proxy or something,'
echo "you'll need to change the settings on docker-compose.yaml."
echo
read -p 'Deploy Domain [localhost]: ' deployDomain
echo
echo

echo ':: Google OAuth 2.0 Client Configuration'
echo
echo 'To add a Google Sheets data source please provide OAuth2 2.0 Client ID and secret.'
echo "Leave an empty value if you don't need it now. You can add it later by modifying .env."
echo
read -p 'Client ID: ' googleClientId
read -sp 'Client Secret: ' googleClientSecret
echo
echo
echo

echo ':: License Configuration'
echo
echo 'You need a license to try Hops. Please enter your license ID.'
echo
read -p "License ID: " licenseId
while [[ $licenseId == '' ]]
do
    echo 'Please enter the license ID.'
    read -p "License ID: " licenseId
done
echo
echo

echo 'Configuration finished! Saving configurations...'

./scripts/build_env.sh \
    "$dbName" "$dbUsername" "$dbPassword" "$initialUserEmail" "$defaultUserPassword" "$secretKey" "$deployDomain" \
    "$googleClientId" "$googleClientSecret" "$licenseId" "" \
    > .env
