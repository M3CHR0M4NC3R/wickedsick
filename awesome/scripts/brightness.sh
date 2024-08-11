#!/bin/bash
[ $1 == 'up' ] && brillo -A 5 -u 5000
[ $1 == 'down' ] && brillo -U 5 -u 5000
