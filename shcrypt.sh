#!/usr/bin/env bash

# shcrypt.sh
# Copyright (C) 2018 by Harald Lapp <harald@octris.org>
#
# Tool for creating encrypted shell-scripts.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


if [ "$2" = "" ]; then
    echo "usage: shcrypt.sh <input-name> <output-name>"
    exit 1
fi

echo "cat << EOF |" > "$2"
openssl enc -e -aes-256-cbc -a -in "$1" >> "$2"
echo "EOF
openssl enc -d -aes-256-cbc -a | sh -s - \$@" >> "$2"

chmod a+x "$2"
