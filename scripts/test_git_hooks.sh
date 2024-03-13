#!/bin/sh

exec >&2

if [ -z ${NO_COLOR+x} ] && tty -s; then
  RED="\033[91m"
  END="\033[0m"
else
  RED=
  END=
fi

hooks=$(git config core.hooksPath)
if [ "${hooks}" != .githooks ]; then
    printf "${RED}\n"
    cat <<EOF
Git is not configured to use Rev Git hooks, which enforce coding guidelines.

To install the Rev Git hooks, run:

git config core.hooksPath .githooks
EOF
    printf "${END}\n"
    exit 1
fi
