## Cover sheet # Revised
cd ../other_docs
pdflatex cover.tex
cd ../compile_workbook
echo Initializing manual pdf...

cp ../other_docs/cover.pdf tmp.pdf
pdftk ../other_docs/cover.pdf ../other_docs/blank.pdf cat output tmp.pdf

## Map # Revised
#pdftk tmp.pdf ../other_docs/map.pdf cat output tmp2.pdf; mv tmp2.pdf tmp.pdf

#echo Adding contact info...
## Contact Info # Revised
#pandoc ../other_docs/contact_info.md -o ../other_docs/contact2.pdf
#gs -o ../other_docs/contact.pdf -dNoOutputFonts -sDEVICE=pdfwrite ../other_docs/contact2.pdf
#pdftk tmp.pdf ../other_docs/contact2.pdf cat output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Block Room Schedule (General) 
#pdftk tmp.pdf ../other_docs/compactschedule2019.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

echo Adding schedule...
## General schedule  # Revised
pdftk tmp.pdf ../../schedule/GeneralSchedule.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

#echo Adding talks... 
## MBL Talks  # Revised
#pandoc ../other_docs/talk_list.md -o ../other_docs/talk_list.pdf
#pdftk tmp.pdf ../other_docs/talk_list.pdf cat output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page # Revised
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

echo Adding tutorials...
## Tutorials cover  # Revised
pdftk tmp.pdf ../other_docs/cover_tutorials.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page # Revised
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Microscopy and ImageJ  # Revised
#pdftk tmp.pdf ../../tutorials/microscopy_and_imageJ/data/ImageProcessingExercises.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

# R-cheat-sheet.pdf
## Basic I 
pdftk tmp.pdf ../other_docs/R-cheat-sheet.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

pdftk tmp.pdf ../../tutorials/basic_computing_1/basic_computing_1.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Basic II 
pdftk tmp.pdf ../../tutorials/basic_computing_2/basic_computing_2.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Advanced I and II
pdftk tmp.pdf ../../tutorials/advanced_computing/tutorial/advanced_computing.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf
pdftk tmp.pdf ../../tutorials/advanced_computing/Jujutsu/the_name_game/name_game.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf
pdftk tmp.pdf ../../tutorials/advanced_computing/Jujutsu/PhD_trends/PhD_trends.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf
pdftk tmp.pdf ../../tutorials/advanced_computing/Jujutsu/Papers_UofC/Papers_UofC.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf


## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Defensive programming 
#pdftk tmp.pdf ../../tutorials/defensive_programming/code/defensive_programming.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Data visualization 
pdftk tmp.pdf ../../tutorials/data_visualization/data_visualization.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Reproducibility
pdftk tmp.pdf ../../tutorials/reproducibility/code/workflowr_tutorial.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Stats for data rich
pdftk tmp.pdf ../../tutorials/stats_for_large_data/code/stats_for_large_data.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

echo Adding workshops...

## Workshops cover
pdftk tmp.pdf ../other_docs/cover_workshops.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## meren 
#pdftk tmp.pdf ../../workshops/meren/code/MBL_QBio_Meren.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf


## Chen
pdftk tmp.pdf ../../workshops/mchen/code/Workshop_RNAseq_analysis.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Khan
pdftk tmp.pdf ../../workshops/akhan/code/Immuno.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## insert blank page
#pdftk tmp.pdf ../other_docs/blank.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf

## Novembre
pdftk tmp.pdf ../../workshops/jnovembre/code/MBL_WorkshopJN.pdf output tmp2.pdf; mv tmp2.pdf tmp.pdf


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
