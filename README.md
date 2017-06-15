# Gzip

Wercker step to recursively compress files with a specific extension using gzip.

## Notes

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and
"OPTIONAL" in this document are to be interpreted as described in
RFC 2119.

## Sample Usage

    build:
      box: ubuntu:latest
      steps:
        - bashaus/gzip:
          cwd: $WERCKER_ROOT/assets/
          compression-level: 9
          file-extensions: css js

&nbsp;

## Step Properties

### compression-level

The level of file compression

* Since: `0.0.1`
* Property is `Optional`
* Default value is: `9`
* Recommended location: `Inline`
* `Validation` rules:
  * Must by a number between 1 (fast) and 9 (best)

&nbsp;

### file-extensions

A list (separated by spaces) of file extensions that you would like to compress.

* Since: `0.0.1`
* Property is `Optional`
* Recommended location: `Inline`
* Default value is: `ico js css xml xsd xsl svg htm html txt`
* `Validation` rules:
  * Must be a space separated list of file extensions

&nbsp;

### follow-symlinks

Whether or not to follow symbolic links when searching for files.

* Since: `0.0.1`
* Property is `Optional`
* Default value is: `true`
* Recommended location: `Inline`
* `Validation` rules:
  * Must be a valid boolean (e.g.: `true`, `false`, `1` or `0`)

### output-extension

The extension to append to the compressed file.

* Since: `0.0.1`
* Property is `Optional`
* Default value is: `.gzip`
* Recommended location: `Inline`
* `Validation` rules:
  * Should not be blank (will rewrite original file)
  * Should start with a full stop `.`
  * Should be either `.gz` or `.gzip`
  * Must be a valid file extension

&nbsp;
