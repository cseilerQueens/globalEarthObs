#!/bin/bash

USERNAME="cseiler456"
PASSWORD="t68q33<k4.h+k562x'..dZq"

# URL of the directory containing .hdf files
URL="https://e4ftl01.cr.usgs.gov/MOLT/MOD11C3.061/"

# Download .hdf files using wget with authentication
wget --user=$USERNAME --password=$PASSWORD -r -np -A "*.hdf" $URL
