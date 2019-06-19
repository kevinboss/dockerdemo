imageName="dockerdemo_web"
containerName="${imageName}_debug"

# Kills all containers based on the image
killContainers() {
  echo "Killing all containers based on the ${imageName} image"
  docker rm --force $(docker ps -q -a --filter "ancestor=${imageName}")
}

# Removes the Docker image
removeImage() {
  imageId=$(docker images -q ${imageName})
  if [[ -z ${imageId} ]]; then
    echo "${imageName} is not found."
  else
    echo "Removing image ${imageName}"
    docker rmi ${imageId}
  fi
}

# Builds the Docker image.
composeUp() {
  if [[ -z $ENVIRONMENT ]]; then
    ENVIRONMENT="debug"
  fi

  composeArgs="-f docker-compose.yml -f docker-compose.dev.yml"
  if [[ $ENVIRONMENT != "release" ]]; then
    composeArgs="-f docker-compose.yml -f $ENVIRONMENT.docker-compose.yml"
  fi

  echo "Compose buid $composeCommand."
  docker-compose $composeArgs build
  echo "Compose up $composeCommand."
  docker-compose $composeArgs up -d
}

# Shows the usage for the script.
showUsage() {
  echo "Usage: dockerTask.sh [COMMAND]"
  echo "    Runs command"
  echo ""
  echo "Commands:"
  echo "    cleanup: Removes the image '$imageName' and kills all containers based on this image."
  echo "    buildForDebug: Builds the debug image and runs docker container."
  echo ""
  echo "Example:"
  echo "    ./dockerTask.sh buildForDebug"
  echo ""
  echo "    This will:"
  echo "        Build a Docker image named $imageName using debug environment and start a new Docker container."
}

if [ $# -eq 0 ]; then
  showUsage
else
  case "$1" in
  "cleanup")
    killContainers
    removeImage
    ;;
  "buildForDebug")
    killContainers
    composeUp
    ;;
  *)
    showUsage
    ;;
  esac
fi
