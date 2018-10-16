#!/usr/bin/env bash

# passgen.sh
# Copyright (C) 2017-2018 by Harald Lapp <harald@octris.org>
#
# Simple shell script for generating "pronounceable" passwords.
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

con="bcdfghjklmnpqrstvwxzBCDFGHJKLMNPQRSTVWXZ"
vwl="aeiouy"
num="0123456789"
syl=4
cnt=5

while [[ "${1:0:1}" = "-" ]]; do
    case $1 in
        -s)
            if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
                syl=$2
            fi
            ;;
        -c)
            if [[ "$2" =~ ^[1-9][0-9]*$ ]]; then
                cnt=$2
            fi
            ;;
        -h|-\?|--help)
            echo "usage: $(basename $0) [arguments]

-s NUMBER   Syllables of passwords. Defaults to $syl.
-c NUMBER   Number of passwords to generate. Defaults to $cnt.
-h, --help  Display this usage information.
"

            exit 1
            ;;
    esac

    shift
done

while [ $cnt -gt 0 ]; do
    pass=""
    s=$syl

    while [ $s -gt 0 ]; do
        pass="$pass${con:$(($RANDOM%${#con})):1}"
        pass="$pass${vwl:$(($RANDOM%${#vwl})):1}"
        pass="$pass${con:$(($RANDOM%$((${#con} / 2)))):1}"

        s=$((s - 1))
    done

    pass="$pass${num:$(($RANDOM%${#num})):1}"

    echo $pass

    cnt=$((cnt - 1))
done
