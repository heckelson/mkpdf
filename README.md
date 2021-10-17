# mkpdf
*A short shell script to quickly make a pdf using pandoc in sshfs folders*

# Why?

Using pandoc in an sshfs context is **very** slow to the point where 
it is almost completely unusable.

This shell script copies your input file to `/tmp` or wherever your heart desires,
as long as you set the variable `$working_dir` in the script.

## Comparing "vanilla" pandoc with my wrapper script

I just used a random file from some of my lecture notes as a sample file. It is 303 lines long, as you can see.

```bash
$ wc -l 00-vorbesprechung.md 
303 00-vorbesprechung.md

$ time pandoc 00-vorbesprechung.md -o 00-vorbesprechung.pdf
...
________________________________________________________
Executed in   46,70 secs    fish           external
   usr time    3,45 secs  367,00 micros    3,45 secs
   sys time    0,67 secs  215,00 micros    0,67 secs

# versus...

$ time mkpdf 00-vorbesprechung.md 
...
________________________________________________________
Executed in    2,73 secs    fish           external
   usr time    2,36 secs  380,00 micros    2,35 secs
   sys time    0,16 secs  222,00 micros    0,16 secs
```

Note that the time without my script is **46 seconds!** where as with the script it is close to 3 seconds. 
This is more than a 15x improvement!
