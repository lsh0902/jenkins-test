#!/bin/bash

set -e

VERSION=`cat VERSION`
JAVA_VERSION=`echo -n $VERSION | perl -ne 'if (/^[0-9]+\.[0-9]+\.[0-9]+$/) { print $_ } else { print $_ . "-SNAPSHOT" }'`
GEM_HOST=http://repo.kakao.com/gems

branch=$1
major_version_pos=0
minor_version_pos=1
patch_version_pos=2

update_client_version_dev() {
  PHASE=$1
  VERSION=$2
  if [[ $VERSION == *$PHASE* ]];then
    IFS="${PHASE}" read -r -a array <<< "$VERSION"
    new_version=$((array[${#array[@]} - 1]+1))
    VERSION="${array[0]}$PHASE${new_version}"
  else
    VERSION="$VERSION.${PHASE}1"
  fi
}

get_new_version() {
  case $branch in
    *alpha*)
      update_client_version_dev 'ALPHA' $VERSION
      ;;
    *sandbox*)
      update_client_version_dev 'SANDBOX' $VERSION
      ;;
    *beta/release*)
      update_client_version_dev 'BETARELEASE' $VERSION
      ;;
    *beta*)
      update_client_version_dev 'BETA' $VERSION
      ;;
    *master*)
      IFS='.' read -r -a array <<< "$VERSION"

      if [ ${array[$patch_version_pos]} -eq 99 ];then
        array[$minor_version_pos]=$((array[$minor_version_pos]+1))
        array[$patch_version_pos]=1
      else
        array[$patch_version_pos]=$((array[$patch_version_pos]+1))
      fi
      VERSION=$(IFS=. ; echo "${array[*]}")
      ;;
  esac
}

get_new_version

echo $VERSION > VERSION
