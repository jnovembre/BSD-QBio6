# A Makefile for generating the PDFs from the R Markdown files.
#
# * Type "make slides" in this directory to generate a PDF of the
#   slides from the R Markdown source.
#
# * Type "make test" to generate a PDF of the slides that also runs
#   a lot of the R code.
#
# * Type "make clean" to discard the generated PDFs, and all accompanying
#   output.
#

# RULES
# -----
all: slides handout

slides: slides.pdf

test: slides_test.pdf

handout: handout.pdf

# Generate the slides while also testing the R code.
slides_test.pdf : slides.Rmd
	Rscript -e 'knitr::opts_chunk$$set(eval = TRUE); \
rmarkdown::render("slides.Rmd",output_file = "slides_test.pdf")'

# Create the slides.
slides.pdf : slides.Rmd
	Rscript -e 'knitr::opts_chunk$$set(eval = FALSE); \
rmarkdown::render("slides.Rmd")'

# Create the handout.
handout.pdf : handout.Rmd
	Rscript -e 'rmarkdown::render("handout.Rmd",output_file="handout.pdf")'

clean:
	rm -f slides.pdf slides_test.pdf handout.pdf


