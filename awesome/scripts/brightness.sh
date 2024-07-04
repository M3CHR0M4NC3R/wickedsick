#!/bin/bash
[ $1 == 'up' ] && pkexec /usr/bin/brillo -A 5
[ $1 == 'down' ] && pkexec /usr/bin/brillo -U 5
