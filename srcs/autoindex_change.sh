#!/bin/bash

cd /etc/nginx/sites-available
cat droslyn > tmp
cat /etc/nginx/file > /etc/nginx/sites-available/droslyn
cat /etc/nginx/sites-available/tmp > /etc/nginx/file
rm tmp
service nginx restart