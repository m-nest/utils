#!/usr/bin/env bash

find . -type f -name Makefile | while read -r makefile; do
    pkg_source_url=$(grep '^PKG_SOURCE_URL:=' "$makefile" | head -n1 | cut -d= -f2-)
    pkg_source=$(grep '^PKG_SOURCE:=' "$makefile" | head -n1 | cut -d= -f2-)

    if [[ -n "$pkg_source_url" && -n "$pkg_source" ]]; then
        url="${pkg_source_url}/${pkg_source}"

        echo "Downloading: $url"

        bitsadmin.exe /transfer download_job /download /priority normal "$url" "$pkg_source"
    fi
done
