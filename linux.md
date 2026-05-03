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

tr
translate squeeze
```bash
echo $PATH | tr : "\n"
```
> replaces colon : with a newline \n

type
like which, but more verbose and works on functions and aliases

date
Prints dates and times in various formats

seq
Prints a sequence of numbers

Brace expansion
A shell feature that prints a sequence of numbers or characters

find
Prints file paths

> `find -type f` print only files
> `find -type d` print only dirs

yes
Prints the same line repeatedly



## shell globbing

Most Linux users are familiar with the star or asterisk character (*), which matches
any sequence of zero or more characters (except for a leading dot)1 in file or directory
paths:
$ grep Linux chapter* 
Behind the scenes, the shell (not grep!) expands the pattern chapter* into a list of
100 matching filenames. Then the shell runs grep.
Many users have also seen the question mark (?) special character, which matches any
single character (except a leading dot). For example, you could search for the word
Linux in chapters 1 through 9 only, by providing a single question mark to make the
shell match single digits:
$ grep Linux chapter?
or in chapters 10 through 99, with two question marks to match two digits:
$ grep Linux chapter??
Fewer users are familiar with square brackets ([]), which request the shell to match a
single character from a set. For example, you could search only the first five chapters:
$ grep Linux chapter[12345]
Equivalently, you could supply a range of characters with a dash:
$ grep Linux chapter[1-5]
You could also search even-numbered chapters, combining the asterisk and the
square brackets to make the shell match filenames ending in an even digit:
$ grep Linux chapter*[02468]
Any characters, not just digits, may appear within the square brackets for matching.
For example, filenames that begin with a capital letter, contain an underscore, and
end with an @ symbol would be matched by the shell in this command:
$ ls [A-Z]*_*@

at the end of the book:
- write something, which will traverse a through subdirs and read all files and find project wide duplicated lines (e.g. source "$RIBYNS_ENV/scripts/utils.sh" should accor often)
- write something which detects duplicated files


> checking for duplicates: ls -d */ && (ls -d */*/ | cut -d/ -f2-) | sort | uniq -c | sort -nr | less

(learn regex)[https://regexone.com/]

