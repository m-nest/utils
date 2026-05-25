#!/usr/bin/env bash

find . -type f -name Makefile | while read -r makefile; do
    declare -A vars

    while IFS= read -r line; do
        if [[ "$line" =~ ^([A-Z0-9_]+):=(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="${BASH_REMATCH[2]}"

            value="$(echo "$value" | sed 's/^ *//;s/ *$//')"

            vars["$key"]="$value"
        fi
    done < "$makefile"

    pkg_source_url="${vars[PKG_SOURCE_URL]}"
    pkg_source="${vars[PKG_SOURCE]}"

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

    resolve_vars() {
        local value="$1"

        # Resolve $(VAR) and ${VAR}
        local changed=1

        while [[ $changed -eq 1 ]]; do
            changed=0

            for var in "${allowed_vars[@]}"; do
                replacement="${vars[$var]}"

                new_value="${value//\$\($var\)/$replacement}"
                new_value="${new_value//\$\{$var\}/$replacement}"

                if [[ "$new_value" != "$value" ]]; then
                    changed=1
                    value="$new_value"
                fi
            done
        done

        # Resolve $(subst FROM,TO,TEXT)
        local subst_regex='\$\(subst[[:space:]]+([^,]+),([^,]+),([^)]+)\)'

        while [[ "$value" =~ $subst_regex ]]; do
            full="${BASH_REMATCH[0]}"
            from="${BASH_REMATCH[1]}"
            to="${BASH_REMATCH[2]}"
            text="${BASH_REMATCH[3]}"

            replaced="${text//${from}/${to}}"

            value="${value//$full/$replaced}"
        done

        echo "$value"
    }

    pkg_source_url="$(resolve_vars "$pkg_source_url")"
    pkg_source="$(resolve_vars "$pkg_source")"

    if [[ -n "$pkg_source_url" && -n "$pkg_source" ]]; then
        url="${pkg_source_url}/${pkg_source}"

        # Download only GitLab URLs
        if [[ "$url" == *gitlab* ]]; then
            echo "Downloading: $url"

            curl -L -o "$pkg_source" "$url"
        else
            echo "Skipping non-GitLab URL: $url"
        fi
    fi
done
