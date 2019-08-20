## Welcome

This page contains important information about the [Fifth BSD-qBio Boot Camp @ MBL](https://biosciences.uchicago.edu/content/mbl-bootcamp), which will be held at the [Marine Biological Laboratory](http://www.mbl.edu/) in Woods Hole, MA, on Sept 8-15, 2019.

More that 100 incoming graduate students from the different programs in the [Division of Biological Sciences](https://biosciences.uchicago.edu) at the [University of Chicago](http://www.uchicago.edu) will participate.

On this page, you find the instructions on how to **prepare your laptop** so that it's ready for the boot camp.

You should also **take a look at the data and the code** we will explore in the workshops and tutorials.

You can see the **schedule** of the boot camp, and find the contact information for the directors.

## Contacts

For any issue/question/comment, please contact the course directors:

*   [Stephanie Palmer](mailto:sepalmer@uchicago.edu?Subject=Help%20BSD%20QBio) ([webpage](http://http//palmerlab.uchicago.edu))
*   [Stefano Allesina](mailto:sallesina@uchicago.edu?Subject=Help%20BSD%20QBio) ([webpage](http://allesinalab.uchicago.edu/))
*   [Victoria Prince](mailto:vprince@uchicago.edu?Subject=Help%20BSD%20QBio) ([webpage](https://princelab-sites.uchicago.edu/))

## Instructors

* [Peter Carbonetto](mailto:pcarbo@uchicago.edu) ([webpage](https://pcarbo.github.io/))
* [A. Murat Eren](mailto:meren@uchicago.edu) ([webpage](http://merenlab.org/))
* [Patrick J. La Riviere](mailto:pjlarivi@uchicago.edu) ([webpage](https://radiology.uchicago.edu/page/patrick-la-riviere-lab))
* [Matthias Steinrücken](mailto:steinrue@uchicago.edu) ([webpage](https://voices.uchicago.edu/steinrueckenlab/))

## Schedule

The qBio4 boot camp will be, as the name implies, quite intense. We are going to have **Tutorials** (short primers to a certain topic) and **Workshops** (discipline-specific, hands-on activities).

You will get to know MBL better, with **Talks from MBL researchers**, a tour of the facilities, and even take a **trip on a boat!**.

Here's the [general schedule](https://github.com/StefanoAllesina/BSD-QBio5/raw/master/schedule/GeneralSchedule.pdf).

You can also browse the schedule [by group](https://github.com/StefanoAllesina/BSD-QBio5/tree/master/schedule).

## Computing tutorials

To accommodate the diverse background of our students, we have created two tracks for the computing tutorials.

*   Basic Computing I and II: dedicated to new users who are not familiar with `R` or programming in general. It will guide students step-by-step, introducing the `R` syntax and showing how to write well-organized code for data analysis and scientific research.
*   Advanced Computing I and II: dedicated to experienced `R` users, will focus on manipulating large data sets, plotting, the UNIX terminal, and the use of regular expressions.

To decide which track you want to choose, please consult the lecture materials, and make sure that the content is at the right level for you:

*   Basic Computing I ([web](https://github.com/StefanoAllesina/BSD-QBio5/blob/master/tutorials/basic_computing_1/basic_computing_1.Rmd), [pdf](https://github.com/StefanoAllesina/BSD-QBio5/raw/master/tutorials/basic_computing_1/basic_computing_1.pdf))
*   Basic Computing II ([web](https://github.com/StefanoAllesina/BSD-QBio5/blob/master/tutorials/basic_computing_2/basic_computing_2.Rmd), [pdf](https://github.com/StefanoAllesina/BSD-QBio5/raw/master/tutorials/basic_computing_2/basic_computing_2.pdf))
*   Advanced Computing I ([web](https://github.com/StefanoAllesina/BSD-QBio5/blob/master/tutorials/advanced_computing_1/code/advanced_computing_1.Rmd), [pdf](https://github.com/StefanoAllesina/BSD-QBio5/raw/master/tutorials/advanced_computing_1/code/advanced_computing_1.pdf))
*   Advanced Computing II ([web](https://github.com/StefanoAllesina/BSD-QBio5/blob/master/tutorials/advanced_computing_2/code/advanced_computing_2.Rmd), [pdf](https://github.com/StefanoAllesina/BSD-QBio5/raw/master/tutorials/advanced_computing_2/code/advanced_computing_2.pdf))

## Preparing your laptop

We are going to start working right away. Therefore, it is very important you **prepare your laptop** for the boot camp before you leave for MBL. This will take you about one hour, so schedule accordingly.

You will work on your laptop all day long. **If you don't have a laptop, please contact Stefano or Stephanie immediately**.

### Installation of `R` and `R` packages

*   **Install R**: go to [this page](https://cran.rstudio.com/), download the file corresponding to your platform, and install it. (Here's a [video](https://www.youtube.com/watch?v=5ZbjUEg4a1g) explaining how to install R and RStudio in Windows; [here](https://www.youtube.com/watch?v=5rp9bkc68y0) for Mac OSX)

*   **Install RStudio**: once installed R, go to [this page](https://www.rstudio.com/products/rstudio/download/), download the installer for your operating system (section **Installers for Supported Platforms**), and install the software.

*   Once installed R and RStudio, open RStudio and **install the following packages**:

    *   tidyverse
    *   devtools
    *   knitr
    *   ggthemes
    *   stringr
    *   plyr
    *   reshape2
    *   vegan
    *   lubridate
    *   rmatio
    *   cowplot

    You can find instructions on how to install `R` packages in RStudio [here](https://www.youtube.com/watch?v=3RWb5U3X-T8).

* **Other packages** Two of the packages need to be installed from within `R`. Open Rstudio and in the Console type `library(devtools)`, hit Return (or Enter) and then `install_github("jdstorey/qvalue")`. This will install the library `qvalue` that is needed for one of the tutorials.

* **Install ImageJ**: go to [this page](http://imagej.net/Fiji/Downloads) and follow the instructions for your platform.

* **UNIX Emulator**: If you are using Windows, you need to install a UNIX emulator. We suggest downloading the version control software `Git`, because it ships with a small emulator (`Git Bash`). Simply go to [this page](https://git-scm.com/download/win) and follow the instructions.

* **Git**
    * **Join GitHub** click [here](https://education.github.com/pack/join) and make sure you use your uchicago email to get free tools.
    * **Download GitKraken** click [here](https://support.gitkraken.com/how-to-install)

## Downloading the data

It is very important to download the data **before you leave for MBL**, as the files are quite large. (Warning! The repo is about 268MB!)
All you need to do is to download the repository containing all the boot camp lectures and data.
We will download the repository using GitKraken (you can alternatively use command-line `git` if you are already familiar with it).

1. Open GitKraken (see download link above)
2. Login with your GitHub account (see instructions and link above)
3. "Clone a Repo" (in File menu)
4. "Clone with URL"
5. "Where to Clone:" Browse to the folder in which you want to keep your repository (your home directory is fine)
6. "URL": Paste: `https://github.com/StefanoAllesina/BSD-QBio5.git`
7. "Clone the Repo!" (this step will take a few minutes)

Now if you go to the folder you chose in step 5, you'll see the repository!

## Programming Challenges

During the boot camp, the 12 groups of students will compete through 6 programming challenges. Here are the links to the webpages where the groups should post their solutions (one answer per group, please):

* Submit your answer to [Programming Challenge 1 (Basic Programming I)](https://goo.gl/forms/9Zrxpgsi4wAKZd4q1)
* Submit your answer to [Programming Challenge 2 (Basic Programming II)](https://goo.gl/forms/jMD93Os8r93T37033)
* Submit your answer for the tutorial on [Defensive Programming](https://goo.gl/forms/IPc1MgenI1eNcu2M2)
* Submit your answer for the tutorial on [Reproducibility](https://goo.gl/forms/fRPxZiYq9FcGxvOs2)
* Submit your answer for the tutorial on [Data Visualization](https://goo.gl/forms/RMWpFqNL0GuxDzI33)
* Submit your answer for the tutorial on [Stats for large data](https://goo.gl/forms/von5dQWKMBaGgolw2)

### Notes
This material is based upon work supported by the National Science Foundation under Grant Number 1734818

Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.
