# Linux

notes from readingt efficient at the linux command line.

wc
number of lines, words and chars in a file.

head
prints the first 10 lines of each lines to stdout.

cut
print selected parts of lines from each file to stdout.

> selected part can be columns, seperated by comma e.g. csv

grep
reads from files or stdin and returns given pattern matching lines to stdout.

sort
srote sorted concatenation of all files to stdout.

uniq
filter adjacent matchin lines from stdin

md5sum (legacy), chsum
print checksums (a hash of stdin)


at the end of the book:
- write something, which will traverse a through subdirs and read all files and find project wide duplicated lines (e.g. source "$RIBYNS_ENV/scripts/utils.sh" should accor often)
- write something which detects duplicated files
