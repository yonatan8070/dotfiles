#!/usr/bin/env bash

set -euo pipefail

qdbus_cmd() {
    qdbus-qt6 org.kde.keyboard /Layouts setLayout 0
}

dbus-monitor --session "type='signal',interface='org.freedesktop.ScreenSaver',member='ActiveChanged'" |
while IFS= read -r line; do
    if [[ "$line" == *"boolean true"* ]]; then
        qdbus_cmd
    fi
done
