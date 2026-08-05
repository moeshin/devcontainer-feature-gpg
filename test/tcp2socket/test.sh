#!/bin/bash

# set -e

source dev-container-features-test-lib

check 'get gpg version' gpg --version

export gpg_conf_dir

get_gpg_conf_dir() {
  gpg_conf_dir="$(gpgconf --list-dirs homedir)" || exit $?
  echo "gpg_conf_dir=$gpg_conf_dir"
}

check 'get gpg conf dir' get_gpg_conf_dir

check 'list gpg conf dir' ls -l "$gpg_conf_dir"

check 'list keys' gpg -k

sign() {
  echo test | gpg --clearsign
}

check sign sign

check 'show log' find /tmp -maxdepth 1 -type f -name 'feature-gpg-tcp2socket-*' -exec sh -c "echo '> cat {}'; cat {}" \;

reportResults
