#!/usr/bin/env bash

find . -type f -name Makefile | while read -r makefile; do
    declare -A vars

    # Read all variable assignments from the Makefile
    while IFS= read -r line; do
        if [[ "$line" =~ ^([A-Z0-9_]+):=(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="${BASH_REMATCH[2]}"

            # Trim whitespace
            value="$(echo "$value" | sed 's/^ *//;s/ *$//')"

            vars["$key"]="$value"
        fi
    done < "$makefile"

    pkg_source_url="${vars[PKG_SOURCE_URL]}"
    pkg_source="${vars[PKG_SOURCE]}"

    # Variables allowed for substitution
    allowed_vars=(
        PKG_NAME
        PKG_VERSION
        PKG_REAL_VERSION
        PKG_UPSTREAM_VERSION
        PKG_SOURCE_VERSION
        PKG_SOURCE_SUBDIR
        UGW_BASENAME
        PKG_MINOR
    )

    # Resolve $(VAR) references
    resolve_vars() {
        local value="$1"

        for var in "${allowed_vars[@]}"; do
            replacement="${vars[$var]}"

            value="${value//\$\($var\)/$replacement}"
            value="${value//\$\{$var\}/$replacement}"
        done

        echo "$value"
    }

    pkg_source_url="$(resolve_vars "$pkg_source_url")"
    pkg_source="$(resolve_vars "$pkg_source")"

    if [[ -n "$pkg_source_url" && -n "$pkg_source" ]]; then
        url="${pkg_source_url}/${pkg_source}"

        echo "Downloading: $url"

        curl -L -o "$pkg_source" "$url"
    fi
done