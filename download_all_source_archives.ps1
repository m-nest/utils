Get-ChildItem -Path . -Recurse -Filter Makefile | ForEach-Object {
    $pkgSourceUrl = $null
    $pkgSource = $null

    Get-Content $_.FullName | ForEach-Object {
        if ($_ -match '^PKG_SOURCE_URL:=(.+)$') {
            $pkgSourceUrl = $matches[1].Trim()
        }

        if ($_ -match '^PKG_SOURCE:=(.+)$') {
            $pkgSource = $matches[1].Trim()
        }
    }

    if ($pkgSourceUrl -and $pkgSource) {
        $url = "$pkgSourceUrl/$pkgSource"

        Write-Host "Downloading: $url"

        curl.exe `
            --location `
            --output $pkgSource `
            $url
    }
}
