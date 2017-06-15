#!/bin/bash

# Property: file-extensions
# Check to see if there are any file extensions
if [[ -z "$WERCKER_GZIP_FILE_EXTENSIONS" ]];
then
  fail "Property file-extensions is required"
fi

# Property: follow-symlinks
# Must be a valid boolean (true, false, 1 or 0)
case "$WERCKER_GZIP_FOLLOW_SYMLINKS" in
  "true" | "1" ) WERCKER_GZIP_FOLLOW_SYMLINKS=1 ;;
  "false" | "0" ) WERCKER_GZIP_FOLLOW_SYMLINKS=0 ;;
  * ) fail "Property follow-symlinks must be true or false"
esac

# Property: compression-level
# Must be a number between 1 and 9
case "$WERCKER_GZIP_COMPRESSION_LEVEL" in
  [1-9] ) ;;
  * ) fail "Property compression-level must be an integer between 1 and 9"
esac

# Dependency: GZIP
# Install GZIP if not available
if [[ ! -n "$(type -t gzip)" ]];
then
    apt-get update
    apt-get install -y gzip
fi

# Task: GZIP
# Loop through each extension and GZIP the matching files
IFS=' ' read -r -a WERCKER_GZIP_FILE_EXTENSIONS <<< "$WERCKER_GZIP_FILE_EXTENSIONS"

for WERCKER_GZIP_FILE_EXTENSION in ${WERCKER_GZIP_FILE_EXTENSIONS[@]};
do
  info "*.$WERCKER_GZIP_FILE_EXTENSION"

  WERCKER_GZIP_FILES=$(find \
    $( [[ "$WERCKER_GZIP_FOLLOW_SYMLINKS" == "1" ]] && echo " -L " ) \
    . -name "*.$WERCKER_GZIP_FILE_EXTENSION" \
  )

  for WERCKER_GZIP_FILE in $WERCKER_GZIP_FILES;
  do
    debug "    $WERCKER_GZIP_FILE"

    gzip $(echo "-${WERCKER_GZIP_COMPRESSION_LEVEL}") \
      < "${WERCKER_GZIP_FILE}" \
      > "${WERCKER_GZIP_FILE}${WERCKER_GZIP_OUTPUT_EXTENSION}"
  done
done
