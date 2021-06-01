#!/usr/bin/env bash

main () {
	# config variables
	_REPO="clang-boost"
	_DISTROS=("ubuntu" "opensuse")
	_NAMESPACE="gabedunn/"

	case $1 in
		publish|push)
			for _DISTRO in "${_DISTROS[@]}"; do
				_IMAGE="$_NAMESPACE$_REPO:$_DISTRO"

				# tag the image
				echo "Tagging as $_IMAGE..."
				docker tag $_REPO:"$_DISTRO$_IMAGE"

				# push the image
				echo "Pushing $_IMAGE..."
				docker push "$_IMAGE"
			done
			;;
		build|*)
			for _DISTRO in "${_DISTROS[@]}"; do
				# generate the command used to build the image
				_BUILD_CMD="docker build $_DISTRO -t $_REPO:$_DISTRO"

				# run the build command
				echo "Building: $_DISTRO ($_BUILD_CMD)"
				$_BUILD_CMD
			done
			;;
	esac
}

main "$1"
