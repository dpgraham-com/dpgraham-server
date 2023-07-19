#!/bin/bash

# Globals
base_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Display help message
print_usage() {
   echo "Command line utility to help develop the project"
   echo
   echo    "Usage: $(basename "$0") <subcommand>"
   echo    "Subcommands:"
   echo -e "migrate  [<OPTIONS>]         \tMigrate subcommand"
   echo -e "db                           \tBring up the local development database and expose it on port 5432"
   echo -e "test-db                    \tBring up the test postgres database and expose on port 5432"
   echo -e "new-migration  <NAME>  \tCreate new empty migration file(s)"
   echo -e "-h, --help                   \tPrint this help message"
   echo
}

# Display migrate CLI arguments
print_migrate_usage() {
   echo "migrate subcommand help"
   echo
   echo "Used to construct the database URL and run migrations"
   echo -e "Usage: $(basename "$0") migrate up|down [<OPTIONS>]"
   echo
   echo    "options:"
   echo -e "--database <DB-NAME>"
   echo -e "--password <PASSWORD>"
   echo -e "--user <USER>"
   echo -e "--host <HOST>"
   echo -e "--port <PORT>"
   echo -e "--query <QUERY> query to attach to database URL (e.g., sslmode=disable)"
   echo
   echo -e "Example: $(basename "$0") migrate up --database mydb --user postgres --password postgres --host localhost --port 5432"
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
    if [ $1 = "test" ]; then
      echo "Starting test database..."
      eval "$docker_exec compose --env-file $base_dir/configs/.env.test -f $base_dir/docker-compose.yaml up postgres -d"
      exit 0
    fi
    echo "Starting development database..."
    eval "$docker_exec compose --env-file $base_dir/configs/.env.dev -f $base_dir/docker-compose.yaml up postgres -d"
    exit 0
}

# Create a new migration file
create_migration_file(){
  # needs the golang-migrate/migrate CLI tool
  if ! [ -x "$(command -v migrate)" ]; then
    echo "Error: migrate is not installed." >&2
  fi
  echo "Creating new migration: $1"
  migrate create -ext sql -dir "$base_dir/db/migrations" -format unix "$1"
  exit 0
}

parse_db_flags(){
  while [[ $# -gt 0 ]]; do
    case $1 in
      -h|--help)
        print_migrate_usage
        exit 0
        ;;
      --database)
        database="$2"
        shift
        shift
        ;;
      --user)
        user="$2"
        shift
        shift
        ;;
      --password)
        password="$2"
        shift
        shift
        ;;
      --host)
        host="$2"
        shift
        shift
        ;;
      --port)
        port="$2"
        shift
        shift
        ;;
      --query)
        query="$2"
        shift
        shift
        ;;
    esac
  done
}

check_db_flags(){
  if [ -z "$user" ]; then
      echo "missing CLI argument --user"
      exit 1
  fi
  if [ -z "$database" ]; then
      echo "missing CLI argument --database"
      exit 1
  fi
  if [ -z "$host" ]; then
      echo "missing CLI argument --host"
      exit 1
  fi
  if [ -z "$password" ]; then
      echo "missing CLI argument --password"
      exit 1
  fi
  if [ -z "$port" ]; then
    # default port
    port="5432"
  fi
}

migrate_up(){
  parse_db_flags "$@"
  # Check if all required options are set
  check_db_flags
  echo "Running migrations UP..."
  migrate  -database "postgresql://$user:$password@$host:$port/$database?$query" -path "$base_dir/db/migrations" up
  exit 0
}

migrate_down(){
  parse_db_flags "$@"
  # Check if all required options are set
  check_db_flags
  echo "Running migrations DOWN..."
  yes | migrate  -database "postgresql://$user:$password@$host:$port/$database?$query" -path "$base_dir/db/migrations" down
  exit 0
}

# Parse CLI argument
while [[ $# -gt 0 ]]; do
  case $1 in
    new-migration)
        shift # Move to the next argument
        if [[ -n $1 ]]; then
          create_migration_file "$1"
        else
          echo "Missing migration file name value after new-migration subcommand."
          echo "Example: ./run.sh new-migration create_users_table"
          exit 1
        fi
        ;;
    test-db)
      start_db "test"
      ;;
    db)
      start_db "dev"
      ;;
    migrate)
      shift
      migrate_subcommand="$1"
      case "$migrate_subcommand" in
        up)
          shift
          migrate_up "$@"
          ;;
        down)
          shift
          migrate_down "$@"
          ;;
        *)
          echo "Unknown migrate subcommand $migrate_subcommand"
          print_migrate_usage
          exit 1
          ;;
      esac
      migrate_up "$@"
      exit 0
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