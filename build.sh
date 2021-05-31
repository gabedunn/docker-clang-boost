#!/usr/bin/env sh

main () {
	# config variables
	_REPO="clang-boost"
	_DISTROS=("ubuntu" "opensuse")

	# loop through the selected distros and build their images
	for _DISTRO in "${_DISTROS[@]}"; do
		# generate the command used to build the image
		_BUILD_CMD="docker build $_DISTRO -t $_REPO:$_DISTRO"

		# output the status
		echo "Building: $_DISTRO ($_BUILD_CMD)"

		# run the build command
		$_BUILD_CMD
	done
}

main
