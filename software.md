# Software Requirements and Installation

All software required for this course is free and open-source and runs identically on Windows, Mac OS X, and Linux.

## Installing R

Download and install R from <https://cran.r-project.org>.
On Windows the installer is at <https://cran.r-project.org/bin/windows/base/>.
On macOS the installer is at <https://cran.r-project.org/bin/macosx/>.

## Choosing an IDE

RStudio is recommended for this course and will be used throughout.
Download it from <https://posit.co/download/rstudio-desktop>.
Positron is a newer alternative from the same company and will also work: download it from <https://positron.posit.co>.

## R Packages

Once R is installed, open R or your IDE and run the following to install the required packages:

```r
install.packages("shiny")
install.packages("tidyverse")
```

## Verifying the Installation

Run the following to confirm Shiny is installed correctly:

```r
library(shiny)
runExample("01_hello")
```

This should open a simple interactive application in your browser.
If it does, the installation is complete and you are ready for the course.
