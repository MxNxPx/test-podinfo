#!/usr/bin/env bash

set -euo pipefail

HELP="
Usage:

bash $0 UDS_PACKAGE_APP_NAME UDS_PACKAGE_APP_NS [UDS_PACKAGE_APP_HOSTNAME]

UDS_PACKAGE_APP_NAME
   The name for your new UDS package app.

UDS_PACKAGE_APP_NS
   The namespace for your new UDS package app.

UDS_PACKAGE_APP_HOSTNAME (optional)
   The hostname for your new UDS package app to prepend to uds.dev resulting in: "hostname.uds.dev" (defaults to \$UDS_PACKAGE_APP_NAME).
"

prep_repo() {
#  echo ${HELP_UDS_PACKAGE_APP_NAME}
#  echo ${HELP_UDS_PACKAGE_APP_NS}
#  echo ${HELP_UDS_PACKAGE_APP_HOSTNAME}

  export HELP_UDS_PACKAGE_APP_NAME=${HELP_UDS_PACKAGE_APP_NAME}
  export HELP_UDS_PACKAGE_APP_NS=${HELP_UDS_PACKAGE_APP_NS}
  export HELP_UDS_PACKAGE_APP_HOSTNAME=${HELP_UDS_PACKAGE_APP_HOSTNAME}

  find . -type f ! \( -name 'setup.bash' -o -path '*/.git/*' \) -exec sed -i "s|uds-package-app|$HELP_UDS_PACKAGE_APP_NAME|g" '{}' \;
  find . -type f ! \( -name 'setup.bash' -o -path '*/.git/*' \) -exec sed -i "s|ns-for-uds-package|$HELP_UDS_PACKAGE_APP_NS|g" '{}' \;
  find . -type f ! \( -name 'setup.bash' -o -path '*/.git/*' \) -exec sed -i "s|hostname-for-uds-package|$HELP_UDS_PACKAGE_APP_HOSTNAME|g" '{}' \;
}

case "${1:-}" in
"-h" | "--help" | "help" | "")
	printf "%s\n" "$HELP"
	exit 0
	;;
*)
        HELP_UDS_PACKAGE_APP_NAME="$1"
        HELP_UDS_PACKAGE_APP_NS="$2"
        HELP_UDS_PACKAGE_APP_HOSTNAME="${3-$HELP_UDS_PACKAGE_APP_NAME}"
	prep_repo "$@"
	;;
esac
