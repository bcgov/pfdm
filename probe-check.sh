#!/bin/sh

### Check if html directory does not exist ###
### composer did not install ###
if [ ! -d "/var/www/html" ]; then
    exit 1
fi
exit 0
