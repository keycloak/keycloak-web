#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"
current=$(sed -n 's:.*<version.keycloak>\([^<]*\)</version.keycloak>.*:\1:p' pom.xml)
if [[ ! "$current" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Cannot determine the current Keycloak version from pom.xml" >&2
    exit 1
fi
IFS=. read -r current_major current_minor current_patch <<< "$current"
releases=$(jq -r '.version' versions/keycloak/*.json | sort -Vr)
declare -A seen=()
count=0
while IFS= read -r version; do
    [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || continue
    IFS=. read -r major minor patch <<< "$version"
    if (( major > current_major || (major == current_major && minor >= current_minor) )); then
        continue
    fi
    branch="$major.$minor"
    [[ -z "${seen[$branch]:-}" ]] || continue
    seen[$branch]=1
    count=$((count + 1))
    if (( count == 1 )); then
        echo "-Dversion.keycloak-previous-1=$version"
    else
        echo "-Dversion.keycloak-previous-2=$version"
        break
    fi
done <<< "$releases"
if (( count != 2 )); then
    echo "Expected two archived guide branches before $current" >&2
    exit 1
fi
