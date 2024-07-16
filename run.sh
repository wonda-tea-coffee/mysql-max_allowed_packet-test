#!/bin/bash
mysql -h 127.1 -u root -e 'set @@global.net_buffer_length = 1024;'
ruby gen.rb $1 | mysql -h 127.1 -u root
