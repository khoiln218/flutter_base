#!/bin/bash
#### ALL FUNCTIONS

runScript(){    
    cd $appDir && echoInfo "Execute commands in App" && executeCommands
    cd $appDir     
}

executeCommands(){
  for command in "${commands[@]}"; do
    if [ $command == "fix" ]; then
      executeFix
    elif [ $command == "gen" ]; then
      executeGenerate
    elif [ $command == "get" ]; then
      executeGetPackages
    elif [ $command == "clean" ]; then
      executeCleanPackages
    elif [[ $command == "dev" || $command == "stg" || $command == "prod" ]]; then
      executeRunEnv $command
    elif [[ $command == "build-dev" || $command == "build-stg" || $command == "build-prod" ]]; then
      executeBuildEnv $command
    elif [ $command == "help" ]; then
      showHelp
    else
      echoError "Unknown command: $command"
      showHelp
    fi
  done
}

executeFix() {
  echoCommandInfo "AUTO FIX LINT RULES"
  dart fix --apply
  dart format .
  flutter pub run import_sorter:main
}

executeGenerate(){
  echoCommandInfo "AUTO GENERATED CLASS"
  dart run build_runner build --delete-conflicting-outputs
}

executeGetPackages(){
  echoCommandInfo "AUTO GET PACKAGES"
  flutter pub get --no-example
}

executeCleanPackages() {
  echoCommandInfo "AUTO CLEAN PACKAGES"
  flutter clean
  executeGetPackages
}

executeRunEnv(){
  local env=$1
  echoCommandInfo "AUTO FLUTTER RUN - ENV: $env"
  flutter run --flavor $env -t lib/main_$env.dart
}

executeBuildEnv(){
  env=${1#"build-"}
  echoCommandInfo "AUTO FLUTTER BUILD - ENV: $env"
  flutter build aab --release --flavor $env -t lib/main_$env.dart
}

showHelp() {
  echo ""
  echo "Flutter cmd Script"
  echo "Usage:"
  echo "  ./cmd [command] [command] ..."
  echo ""
  echo "Available commands:"
  echo "  gen           → Generate code with build_runner"
  echo "  get           → Get Flutter packages"
  echo "  clean         → Clean build + get packages"
  echo ""
  echo "Environment run commands:"
  echo "  dev           → Run app in development mode"
  echo "  stg           → Run app in staging mode"
  echo "  prod          → Run app in production mode"
  echo ""
  echo "Environment build commands:"
  echo "  build-dev     → Build app for development"
  echo "  build-stg     → Build app for staging"
  echo "  build-prod    → Build app for production"
  echo ""
  echo "Other:"
  echo "  help          → Show this help menu"
  echo ""
  exit 0
}

echoInfo(){
  c_echo "GREEN"  "=====>  $1"
}

echoCommandInfo(){
  c_echo "YELLOW"  "=====>  $1"
}

echoError(){
  c_echo "RED"  "$1"
}

c_echo(){
    bold=$(tput bold)
    RED="\033[0;31m"
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color
    printf "${!1}${bold}${2} ${NC}\n"
}

clear
appDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

commands=( "$@" )
commandsLength=${#commands[@]}
if [ $commandsLength -eq 0 ]; then
  showHelp
fi

runScript
