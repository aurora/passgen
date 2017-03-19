#!/usr/bin/env bash

#
# Simple shell script for generating "pronounceable" passwords
#
# copyright (c) 2017 by Harald Lapp <harald.lapp@gmail.com>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.
#

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
            if [[ "$2" =~ ^[1-9][1-9]*$ ]]; then
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
