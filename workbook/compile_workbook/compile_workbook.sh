## Cover sheet # Revised
cd ../other_docs
pdflatex cover.tex
cd ../compile_workbook
pdftk ../other_docs/cover.pdf ../other_docs/blank.pdf cat output tmp.pdf

## Map # Revised
pdftk tmp.pdf ../other_docs/map.pdf cat output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Contact Info # Revised
pandoc ../other_docs/contact_info.md -o ../other_docs/contact2.pdf
gs -o ../other_docs/contact.pdf -dNoOutputFonts -sDEVICE=pdfwrite ../other_docs/contact2.pdf
pdftk tmp.pdf ../other_docs/contact2.pdf cat output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Block Room Schedule (General) 
#pdftk tmp.pdf ../../schedule/GeneralRoomSchedule.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## General schedule  # Revised
pdftk tmp.pdf ../../schedule/GeneralSchedule.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## MBL Talks  # Revised
pandoc ../other_docs/talk_list.md -o ../other_docs/talk_list.pdf
pdftk tmp.pdf ../other_docs/talk_list.pdf cat output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page # Revised
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Tutorials cover  # Revised
pdftk tmp.pdf ../other_docs/cover_tutorials.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page # Revised
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Microscopy and ImageJ  # Revised
pdftk tmp.pdf ../../tutorials/microscopy_and_imageJ/data/ImageProcessingExercises.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Basic I 
pdftk tmp.pdf ../../tutorials/basic_computing_1/basic_computing_1.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Basic II 
pdftk tmp.pdf ../../tutorials/basic_computing_2/basic_computing_2.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Advanced I 
pdftk tmp.pdf ../../tutorials/advanced_computing_1/code/advanced_computing_1.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Advanced II
pdftk tmp.pdf ../../tutorials/advanced_computing_2/code/advanced_computing_2.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf 

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Defensive programming 
pdftk tmp.pdf ../../tutorials/defensive_programming/code/defensive_programming.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Data visualization 
pdftk tmp.pdf ../../tutorials/data_visualization/handout.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Reproducibility
pdftk tmp.pdf ../../tutorials/reproducibility/code/reproducibility.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Stats for data rich
pdftk tmp.pdf ../../tutorials/stats_for_large_data/code/stats_for_large_data.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Workshops cover
pdftk tmp.pdf ../other_docs/cover_workshops.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## meren 
pdftk tmp.pdf ../../workshops/meren/code/MBL_QBio_Meren.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Palmer
pdftk tmp.pdf ../../workshops/sepalmer/code/mt_lip_computation.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Steinruecken 
pdftk tmp.pdf ../../workshops/steinruecken/code/MBL_WorkshopJN.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Redistill to reduce size
gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -sOutputFile=../workbook.pdf tmp.pdf
## remove tmp
rm tmp.pdf

## Math refresher in separate file

## Introductory math tutorials cover 
#cp ../other_docs/cover_math_intros.pdf tmp.pdf

# Stochastic # Revised
#pdftk tmp.pdf ../other_docs/intro_stochastic_processes_with_solutions.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Dynamical # Revised
#pdftk tmp.pdf ../other_docs/intro_dynamical_systems_with_solutions.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Redistill to reduce size
#gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -sOutputFile=../math_refresher.pdf tmp.pdf
## remove tmp
#rm tmp.pdf
