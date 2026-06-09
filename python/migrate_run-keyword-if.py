#!/usr/bin/env python3

from pathlib import Path

EXTENSIONS = {".robot", ".resource"}

for path in Path(".").rglob("*"):
    if path.suffix not in EXTENSIONS:
        continue

    lines = path.read_text(encoding="utf-8", errors="ignore").splitlines()

    output = []
    i = 0
    modified = False

    while i < len(lines):
        line = lines[i]

        if "Run Keyword If" in line:
            merged = line

            j = i + 1

            while j < len(lines):
                next_line = lines[j].lstrip()

                # Old Robot continuation line:
                if next_line.startswith("\\") and "..." in next_line:
                    pos = next_line.find("...")
                    continuation = next_line[pos + 3:].strip()

                    merged += "    " + continuation
                    modified = True
                    j += 1
                else:
                    break

            output.append(merged)
            i = j
            continue

        output.append(line)
        i += 1

    if modified:
        path.write_text(
            "\n".join(output) + "\n",
            encoding="utf-8"
        )
        print(f"Updated: {path}")
