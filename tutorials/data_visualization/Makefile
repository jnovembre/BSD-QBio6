# A Makefile for generating the PDFs from the R Markdown files.

# RULES
# -----
all: handout

handout: data_visualization.pdf

# Create the handout.
#
# Change to fig.keep = "none" to remove the plots from the generated PDF.
data_visualization.pdf : data_visualization.Rmd
	Rscript -e 'knitr::opts_chunk$$set(fig.keep = "none"); rmarkdown::render("data_visualization.Rmd",output_file="data_visualization.pdf")'

clean:
	rm -f data_visualization.pdf


