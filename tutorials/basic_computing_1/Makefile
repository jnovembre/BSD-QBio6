# A Makefile for generating the PDFs from the R Markdown files.
#
# Note to create the PDF, you need a file laptops.csv. If not available,
# you can copy laptops_2019.csv.
#

# RULES
# -----
all: handout

handout: basic_computing_1.pdf

# Create the handout.
basic_computing_1.pdf : basic_computing_1.Rmd
	Rscript -e 'rmarkdown::render("basic_computing_1.Rmd",output_file="basic_computing_1.pdf")'

clean:
	rm -f basic_computing_1.pdf

