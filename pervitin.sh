#!/bin/bash

terminate_servers() {
  echo "Terminating PocketBase server..."
  kill -INT $pocketbase_pid

  echo "Terminating Svelte server..."
  kill -INT $svelte_pid
}

trap terminate_servers SIGINT

if [ -z "$1" ]
then
  echo "Please provide a command (new or serve) and a project name."
  exit 1
fi

COMMAND=$1
PROJECT_NAME=$2

if [ "$COMMAND" == "new" ]
then
  if [ -z "$PROJECT_NAME" ]
  then
    echo "Please provide a project name."
    exit 1
  fi

  # Create a new Svelte project using the Svelte template
  npm --yes create svelte@latest $PROJECT_NAME

  # Change into the project directory
  cd $PROJECT_NAME

  # Install PocketBase and its dependencies
  curl -L "https://github.com/pocketbase/pocketbase/releases/download/v0.13.4/pocketbase_0.13.4_darwin_arm64.zip" -o pocketbase.zip
  unzip pocketbase.zip
  rm pocketbase.zip

  # Install project dependencies
  npm install

  echo "Svelte project with PocketBase has been created and set up."

elif [ "$COMMAND" == "serve" ]
then
  if [ -z "$PROJECT_NAME" ]
  then
    echo "Please provide a project name."
    exit 1
  fi

  # Change into the project directory
  cd $PROJECT_NAME

  echo "Starting PocketBase and Svelte development server..."

  # Run servers in the background
  ./pocketbase serve & pocketbase_pid=$!
  npm run dev & svelte_pid=$!

  # Wait for the servers to terminate
  wait

else
  echo "Invalid command. Please use 'new' or 'serve'."
  exit 1
fi
