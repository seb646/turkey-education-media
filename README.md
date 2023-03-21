# Happiness and Altruism in the United States

This repository contains all of the files necessary for an investigation of happiness and altruism in the United States using the NORC's General Social Survey (GSS) data. The aim of this study was to determine if happiness leads to altruistic behavior. 

> **Note**<br>
> The research paper associated with this study is available [here](https://github.com/seb646/happiness-and-altruism/blob/main/outputs/paper/paper.pdf).

## Getting Started

### Requirements

This project requires both the [R programming language](https://www.r-project.org/) and [Quarto](https://quarto.org/docs/get-started/). If you do not have these tools in your development environment, please install them now. You will also need an integrated development environment (IDE) capable of running R scripts. I recommend [RStudio](https://posit.co/products/open-source/rstudio/) (local) or [Posit Cloud](https://posit.cloud/) (cloud-based).

Once your environment is set up, you must install several packages that handle various tasks, like graphing data, creating tables, and general organization and processing. You will find a complete list of these packages in the file `scripts/00-install_dependencies.r`. You only need to run this file once to install the required dependencies.

### Download the data
> **Note**<br>
> A step-by-step guide for how to download this data is available [here](https://github.com/seb646/happiness-and-altruism/blob/main/guides/00-download_data.md).

The first step in working with this project is to download following three data sets from the [General Social Survey](https://gssdataexplorer.norc.org).

- [General Happiness](https://gssdataexplorer.norc.org/variables/434/vshow)
- [Has Given Directions to a Stranger](https://gssdataexplorer.norc.org/variables/2886/vshow)
- [Has Given Food or Money to a Homeless Person](https://gssdataexplorer.norc.org/variables/2878/vshow)

Once you download the data from GSS, place the `GSS.dat` and `GSS.dct` files in `inputs/data/raw` and run `scripts/01-data_covert.r` to conver the data to a `.csv` file. 

### Clean the data

Before moving to data analysis, we must clean the generated `.csv` files to help us filter, use, and understand the relevant data points. The `scripts/02-data_cleaning.r` file handles all of the data cleaning, including fixing column names (many have characters that cannot be used or are insufficent descriptors), selecting the appropriate columns, and filtering any rows that contain null data. 

Run the file to fetch the raw data sets, clean them, and then create new `.csv` files with the clean data. At the end of this process, you should have six new files in `inputs/data/clean`:
* `directions_negative_data.csv`
* `directions_positive_data.csv`
* `happy_negative_data.csv`
* `happy_positive_data.csv`
* `homeless_negative_data.csv`
* `homeless_positive_data.csv`

### Analyze the data

The core data analysis of this project occurs in the `outputs/paper/paper.qmd` file, another Quarto document. Once you render `paper.qmd`, Quarto will generate a `paper.pdf` file in the same folder. The raw references used in `paper.qmd` are available under the same folder in the `references.bib` file.

## Debugging

### Test the data

If you're experiencing problems with the data, I've compiled a document that tests the data against several parameters, like data types, number ranges, and data ranges. This testing document is available under the `scripts/03-data_testing.r` file. The file contains a number of tests to run on the six `.csv` files. 

Before running these tests, you must first download the data following the steps outlined above. All of these tests should return true. If they do not, feel free to [create an issue](https://github.com/seb646/happiness-and-altruism/issues/new).

### Simulate the data

If you'd like to debug the problem yourself, or if you'd like to use a service like Stack Overflow for help, it's important to have some simulated data to reproduce the problem. The `scripts/04-data_simulation.r` file generates random, fake data based on the information initially downloaded from GSS.

## Acknowledgments

Created by [Sebastian Rodriguez](https://srod.ca), Laura Lee-Chu, and Iz Leitch © 2023, licensed under the [BSD 3-Clause License](https://github.com/seb646/happiness-and-altruism/blob/main/LICENSE). Contains information from [General Social Survey (GSS)](https://gssdataexplorer.norc.org/), a project of the independent research organization [NORC](https://norc.org/) at the [University of Chicago](https://www.uchicago.edu/), with principal funding from the [National Science Foundation](https://www.nsf.gov/). Created using [R](https://www.r-project.org/), an open-source statistical programming language.

This project uses a number of R packages, including: [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [here](https://cran.r-project.org/web/packages/here/index.html), [janitor](https://cran.r-project.org/web/packages/janitor/index.html), [kableExtra](https://cran.r-project.org/web/packages/kableExtra/index.html), [knitr](https://cran.r-project.org/web/packages/knitr/index.html), [lubridate](https://cran.r-project.org/web/packages/lubridate/index.html), [opendatatoronto](https://cran.r-project.org/web/packages/opendatatoronto/index.html), [readr](https://cran.r-project.org/web/packages/readr/index.html), [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/index.html), [scales](https://cran.r-project.org/web/packages/scales/index.html), and [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html).

Much of this project's development was informed by [Rohan Alexander](https://rohanalexander.com/)'s book [*Telling Stories with Data*](https://tellingstorieswithdata.com/).
