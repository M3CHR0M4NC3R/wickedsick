#!/bin/bash
[ $1 == 'up' ] && pkexec /usr/bin/brillo -A 5 -u 500000
[ $1 == 'down' ] && pkexec /usr/bin/brillo -U 5 -u 500000
