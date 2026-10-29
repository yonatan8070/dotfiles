#!/usr/bin/env bash

set -euo pipefail

dbus-monitor --session "type='signal',interface='org.freedesktop.ScreenSaver',member='ActiveChanged'" |
while IFS= read -r line; do
    if [[ "$line" == *"boolean true"* ]]; then
        qdbus-qt6 org.kde.keyboard /Layouts setLayout 0
    fi
done
