#!/bin/bash

OLD_CHANGES_LEVEL= `grep -E "${CHANGES_LEVE}" ${APP_FILE} | grep -o -P '(?<=").*(?=")'`

OLD_VERSION_NAME_STRING=`grep -E "${VERSION_NAME}" ${APP_FILE}`
OLD_VERSION_NAME=`grep -E "${VERSION_NAME}" ${APP_FILE} | grep -oE '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}'`

NEW_VERSION_NAME=$OLD_VERSION_NAME
VERSION_NAME_BIG= 'grep -Po "^[0-9]{1,3}"'
VERSION_NAME_MEDIUM=
VERSION_NAME_SMALL= 'grep -Po "[0-9]{1,3}$"'

NEW_VERSION_NAME_STRING=$OLD_VERSION_NAME_STRING
sed 's/$OLD_VERSION_NAME/$NEW_VERSION_NAME/g' $OLD_VERSION_NAME_STRING
sed 's/$OLD_VERSION_NAME_STRING/$NEW_VERSION_NAME_STRING' ${APP_FILE}

OLD_VERSION_CODE_STRING=`grep -E "${VERSION_CODE}" ${APP_FILE}`
OLD_VERSION_CODE=`grep -E "${VERSION_CODE}" ${APP_FILE} | grep -oE '[0-9]{1,9}'`

NEW_VERSION_CODE=OLD_VERSION_CODE+1

NEW_VERSION_CODE_STRING=$OLD_VERSION_CODE_STRING
sed 's/$OLD_VERSION_CODE/$NEW_VERSION_CODE/g' $OLD_VERSION_CODE_STRING
sed 's/$OLD_VERSION_CODE_STRING/$NEW_VERSION_CODE_STRING' ${APP_FILE}

if [[ "$OLD_CHANGES_LEVEL" == "small" ]]; then
  NEW_VERSION_NAME= 
elif [[ "$OLD_CHANGES_LEVEL" == "medium" ]]; then
  echo "Close enough"
elif [[ "$OLD_CHANGES_LEVEL" == "big" ]]; then
  echo "Close enough"
else
  echo "No way Jose."
fi

hub release create -a ./${APP_FOLDER}/build/outputs/apk/release/app-release.apk -m "${RELEASE_TITLE} - v${VERSION_NAME}" $(date +%Y%m%d%H%M%S)
