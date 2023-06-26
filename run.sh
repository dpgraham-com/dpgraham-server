#!/bin/bash

# Display help message
print_usage() {
   echo "Command line utility to help develop the project"
   echo
   echo    "Syntax: $(basename "$0") <option>"
   echo    "options:"
   echo -e "-n, --new-migration  <NAME>  \t Create new empty migration file(s)"
   echo -e "-h, --help                   \t Print this help message"
   echo
}

# Create a new migration file
create_migration_file(){
  # needs the golang-migrate/migrate CLI tool
  if ! [ -x "$(command -v migrate)" ]; then
    echo "Error: migrate is not installed." >&2
  fi
  echo "Creating new migration: $1"
  migrate create -ext sql -dir db/migrations -format unix "$1"
}

# Parse CLI argument
while [[ $# -gt 0 ]]; do
  case $1 in
    -n|--new-migration)
        shift # Move to the next argument
        if [[ -n $1 ]]; then
          create_migration_file "$1"
          exit 0
        else
          echo "Missing argument value after -n or --new-migration flag."
          exit 1
        fi
#        create_migration_file
#        exit 0
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