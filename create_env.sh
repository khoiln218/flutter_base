#!/bin/bash

ENV_DIR="./env"

# Create env directory if not exist
if [ ! -d "$ENV_DIR" ]; then
  echo "Creating env directory..."
  mkdir -p "$ENV_DIR"
fi

# Function to create env file with default content
create_env_file () {
  FILE_PATH="$ENV_DIR/$1.env"

  if [ -f "$FILE_PATH" ]; then
    echo "$1.env already exists. Skipping."
  else
    echo "Creating $1.env ..."

    if [ "$1" = "develop" ]; then
      BUILD_TYPE="DEV"
    elif [ "$1" = "staging" ]; then
      BUILD_TYPE="STG"
    else
      BUILD_TYPE="PROD"
    fi

    cat <<EOF > "$FILE_PATH"
# $1 environment variables

BASE_URL=https://dummyjson.com/
BUILD_TYPE=$BUILD_TYPE
EOF
  fi
}

# Create files
create_env_file "develop"
create_env_file "staging"
create_env_file "production"

echo "Done!"
