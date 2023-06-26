#!/bin/bash

# Globals
base_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Display help message
print_usage() {
   echo "Command line utility to help develop the project"
   echo
   echo    "Syntax: $(basename "$0") <option>"
   echo    "options:"
   echo    "-d, --db                     \tBring up the local development database and expose it on port 5432"
   echo -e "-n, --new-migration  <NAME>  \tCreate new empty migration file(s)"
   echo -e "-h, --help                   \tPrint this help message"
   echo
}


start_db(){
    echo "starting database..."
    # check if docker is installed
    if command -v docker> /dev/null 2>&1; then
        docker_exec=$(command -v docker)
    else
      echo "Docker not found"
      exit 1
    fi
    eval "$docker_exec compose -f $base_dir/docker-compose.yaml up postgres -d"
    exit 0
}

# Create a new migration file
create_migration_file(){
  # needs the golang-migrate/migrate CLI tool
  if ! [ -x "$(command -v migrate)" ]; then
    echo "Error: migrate is not installed." >&2
  fi
  echo "Creating new migration: $1"
  migrate create -ext sql -dir db/migrations -format unix "$1"
  exit 0
}

# Parse CLI argument
while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--new-migration)
        shift # Move to the next argument
        if [[ -n $1 ]]; then
          create_migration_file "$1"
        else
          echo "Missing argument value after -n or --new-migration flag."
          exit 1
        fi
        ;;
    -d|--db)
      start_db
      ;;
    -h|--help)
      print_usage
      exit 0
      ;;
    *)
      echo "Unknown option $1"
	    print_usage
      exit 1
      ;;
  esac
done