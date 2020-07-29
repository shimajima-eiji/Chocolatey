#!/bin/sh
<<README
# Usage
curl -sf https://raw.githubusercontent.com/shimajima-eiji/Chocolatey/master/wsl/update_CHANGELOG.sh | sh -s "-o (your account) -r (repository)"

# Refer
https://github.com/shimajima-eiji/Github_scout/wiki/【手引】更新履歴（CHANGELOG.md）

README

while getopts ":o:r:h" optKey; do
  case "$optKey" in
  o)
    owner="-o ${OPTARG}"
    ;;
  r)
    #require_repository=true
    repository="-r ${OPTARG}"
    ;;
  '-h' | '--help' | *)
    cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -h          Display help
  -o, --owner         (required) owner of the Github repository
  -r, --repository    (required) name of the Github repository
EOM
    ;;
  esac
done

if [ ! "$owner" -o ! "$repository" ]; then
  exit 2
fi

github-changes $owner $repository --use-commit-body -t "更新履歴" -z Asia/Tokyo -m "YYYY年M月D日" -n "最終更新"
echo "complete"
