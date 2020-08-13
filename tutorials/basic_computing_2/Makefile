# A Makefile for generating the PDFs from the R Markdown files.

# RULES
# -----
all: handout

handout: basic_computing_2.pdf

# Create the handout.
basic_computing_2.pdf : basic_computing_2.Rmd
	Rscript -e 'rmarkdown::render("basic_computing_2.Rmd",output_file="basic_computing_2.pdf")'

clean:
	rm -f basic_computing_2.pdf

