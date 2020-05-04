#! /bin/sh
# =========================================================================
# File: path.sh
# Author: Corey Keller
# Description: This script handles setting the $PATH and ensuring that
# there are no duplicates
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2020-03-11
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================

does_dir_exist() {
	if  [ -z "${1:-}" ]; then
		printf %s\\n "'does_dir_exist' must have a directory provided"
		return 1
	fi

	if [ -d "$1" ]; then
		return 0
	else
		return 1
	fi
}

# Sets the variable named in $1 to the absolute path of $2
path_return_absolute_dir() {
	if [ -z "${2:-}" ]; then
		printf %s\\n "'path_return_absolute_dir' must have 2 parameters in order:
	1. A string containing the name of the variable to assign the result to
	2. The directory to convert to an absolute path
Please format your call appropriately."
		return 1
	fi

	# Use absolute path for the directory if a relative path was
	# specified.
	if command -v realpath > /dev/null; then
		pRetAbsDir="$(realpath "$2")"
	elif command -v readlink > /dev/null; then
		pRetAbsDir="$(readlink -f "$2")"
	else
		case "$2" in
		/*)
			# The path of the provided directory is already
			# absolute.
			pRetAbsDir="$2"
			;;
		*)
			# Prepend the path of the current directory.
			pRetAbsDir="$PWD/$2"
			;;
		esac
	fi
	eval "$1=\$pRetAbsDir"
	unset pRetAbsDir
}

path_append() {
	for directory in "$@"; do
		if  [ -z "${directory:-}" ]; then
			continue
		fi

		if does_dir_exist "$directory"; then
			path_return_absolute_dir "path_check_dir" "$directory"
			# Check that dir isn't already in the user’s PATH.
			case ":$PATH:" in
			*:"$path_check_dir":*)
				return 0
				;;
			*)
				PATH="$PATH:$path_check_dir"
				;;
			esac
		fi
		unset path_check_dir
	done
}

path_prepend() {
	for directory in "$@"; do
		if does_dir_exist "$directory"; then
			path_return_absolute_dir "path_check_dir" "$directory"
			PATH="$path_check_dir:$PATH"
		fi
		unset path_check_dir
	done
}

path_remove_dups() {
	PATH=$(awk -F: \
	'{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<- EOF
	$PATH
	EOF
	)
}

path_setup() {
	oldpath="$PATH"
	PATH="."

	# User general bin directories
	path_append "${HOME}/bin" "${HOME}/src/bin" "${HOME}/.local/bin"

	# User agnostic bin dir for various user compiled programs
	path_append "${SHAREDBINDIR}"

	# User specific Rust programs
	path_append "${HOME}/.cargo/bin"

	# pyenv - python version management
	PYENV_ROOT="${PYENV_ROOT:-${HOME}/.pyenv}"
	path_append "${PYENV_ROOT}/shims" "${PYENV_ROOT}/bin" \
	"${PYENV_ROOT}/plugins/pyenv-virtualenv/shims"

	# rbenv - ruby version management
	RBENV_ROOT="${RBENV_ROOT:-${HOME}/.rbenv}"
	path_append "${RBENV_ROOT}/shims" "${RBENV_ROOT}/bin" \
	"${RBENV_ROOT}/plugins/ruby-build/bin"

	# User specific go programs
	path_append "${HOME}/go/bin"

	# linuxbrew - Homebrew for Linux
	path_append "/home/linuxbrew/.linuxbrew/bin" \
	"/home/linuxbrew/.linuxbrew/sbin"

	# n - node.js version management
	path_append "${HOME}/n/bin"

	# user compiled 'fzf' location
	path_append "${GHDIR}/junegunn/fzf/bin"

	# various system bin paths in preferred order
	path_append "/usr/local/go/bin" "/usr/local/sbin" "/usr/local/bin" \
	"/usr/sbin" "/usr/bin" "/sbin" "/bin"

	# "${oldpath%%:*}" is $oldpath up to, but not including the first ':'
	# "${oldpath#*:}" is everything after the first ':' (or the whole
	# string if there isn't one)
	until [ "${oldpath%%:*}" = "${oldpath#*:}" ]; do
		path_append "${oldpath%%:*}"
		oldpath="${oldpath#*:}"
	done

	path_append "${oldpath%%:*}"
}

# path_setup
