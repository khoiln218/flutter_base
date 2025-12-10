#!/bin/bash

VS_DIR="./.vscode"

# create .vscode folder if not exist
if [ ! -d "$VS_DIR" ]; then
  echo "Creating .vscode directory..."
  mkdir -p "$VS_DIR"
fi

FILE_PATH="$VS_DIR/launch.json"

# check exist
if [ -f "$FILE_PATH" ]; then
  echo "launch.json already exists. Skipping."
  exit 0
fi

echo "Creating launch.json ..."

cat <<EOF > "$FILE_PATH"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "dev",
            "program": "lib/main_dev.dart",
            "request": "launch",
            "type": "dart",
            "args": ["--flavor", "dev"]
        },
        {
            "name": "stag",
            "program": "lib/main_stg.dart",
            "request": "launch",
            "type": "dart",
            "args": ["--flavor", "stg"]
        },
        {
            "name": "prod",
            "program": "lib/main_prod.dart",
            "request": "launch",
            "type": "dart",
            "args": ["--flavor", "prod"]
        },
        {
            "name": "dev-release",
            "program": "lib/main_dev.dart",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args": ["--flavor", "dev"]
        },
        {
            "name": "stag-release",
            "program": "lib/main_stg.dart",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args": ["--flavor", "stg"]
        },
        {
            "name": "prod-release",
            "program": "lib/main_prod.dart",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args": ["--flavor", "prod"]
        }
    ]
}
EOF

echo "launch.json created successfully."
