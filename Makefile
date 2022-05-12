# Rule
# target : prerequisite1 prerequisite2 prerequisite3
#	(tab)recipe

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

# Get the dictionary of words
chap36_makefile/words.txt:
	Rscript -e 'download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "chap36_makefile/words.txt", quiet = TRUE)'

# create a table of word length frequency
# `$<`: the first prerequisite
chap36_makefile/histogram.tsv: \
chap36_makefile/histogram.R\
chap36_makefile/words.txt
	Rscript $<

# plot a histogram of word lengths
# `$@`: the output
chap36_makefile/histogram.png: \
chap36_makefile/histogram.tsv
	Rscript -e 'library(ggplot2); qplot(length, freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

# Create the R Markdown file report.rmd that:
# reads the table of word lengths histogram.tsv
# reports the most common word length
# displays the pre-made histogram histogram.png
chap36_makefile/report.html: \
chap36_makefile/report.Rmd\
chap36_makefile/histogram.tsv\
chap36_makefile/histogram.png
	Rscript -e 'rmarkdown::render("$<")'


all: chap36_makefile/report.html

clean:
	rm -f \
	chap36_makefile/report.html \
	chap36_makefile/report.md \
	chap36_makefile/histogram.png \
	chap36_makefile/histogram.tsv
