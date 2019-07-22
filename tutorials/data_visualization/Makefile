# A Makefile for generating the PDFs from the R Markdown files.

# RULES
# -----
all: handout notes

handout: data_visualization.pdf

notes: data_visualization_notes.pdf

# Create the handout.
data_visualization.pdf : data_visualization.Rmd
	Rscript -e 'rmarkdown::render("data_visualization.Rmd", \
output_file="data_visualization.pdf")'

# Create the PDF with the instructor's notes.
data_visualization_notes.pdf : data_visualization_notes.Rmd
	Rscript -e 'rmarkdown::render("data_visualization_notes.Rmd", \
output_file = "data_visualization_notes.pdf")'

clean:
	rm -f data_visualization_notes.pdf
	rm -f data_visualization.pdf

