#!/usr/bin/env bash


main () {
  # local variables
  local _REPO="clang-boost"
  local	_DISTROS=("alpine" "ubuntu" "opensuse")
  local	_NAMESPACE="gabedunn"

  build () {
    for _DISTRO in "${_DISTROS[@]}"; do
      echo "Building: $_DISTRO..."
      docker build "$_DISTRO" -t "$_REPO:$_DISTRO"
    done
  }

  tag () {
    for _DISTRO in "${_DISTROS[@]}"; do
      # tag the image
      echo "Tagging $_NAMESPACE/$_REPO:$_DISTRO..."
      docker tag $_REPO:"$_DISTRO" "$_NAMESPACE/$_REPO:$_DISTRO"

      # tag alpine as the latest
      if [ "$_DISTRO" == "alpine" ]; then
        echo "Tagging $_DISTRO as latest..."
        docker tag $_REPO:"$_DISTRO" "$_NAMESPACE/$_REPO:latest"
      fi
    done
  }

  publish () {
    tag

    for _DISTRO in "${_DISTROS[@]}"; do
      echo "Pushing $_NAMESPACE/$_REPO:$_DISTRO"
      docker push "$_NAMESPACE/$_REPO:$_DISTRO"

      # push alpine as the latest
      if [ "$_DISTRO" == "alpine" ]; then
        echo "Pushing $_DISTRO as latest..."
        docker push "$_NAMESPACE/$_REPO:latest"
      fi
    done
  }

	case $1 in
		publish|push)
			publish
			;;
	  tag)
	    tag
	    ;;
		build|*)
			build
			;;
	esac
}

main "$1"
