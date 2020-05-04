#! /bin/sh
# =========================================================================
# File: init_post.sh
# Author: Corey Keller
# Description: Shell agnostic actions that should be done as late as
# possible during shell startup.
# Repository: https://github.com/Corey-Keller/dotdotfiles
# Last Modified: 2020-03-10
# License: Mozilla Public License 2.0
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# =========================================================================

# Re-order and clean duplicates out of $PATH
path_setup
