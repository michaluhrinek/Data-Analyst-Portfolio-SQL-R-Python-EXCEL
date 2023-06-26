#Cleaning and organizing data
install.packages("tidyverse") 
library(tidyverse)
data(diamonds)
view(diamonds) #view entire dataset
head(diamonds) #view just first 6rows 
str(diamonds) #structure of dataframe...type of data, what data are there, what columns
colnames(diamonds) #column names just
mutate(diamonds, carat_2=carat*100) #to be able to edit dataframe, add new column

#Working with Tibbles
#convert file, dataframe into tibble
as_tibble(diamonds)
library(tibble) #library for it

#Use options(tibble.width = Inf) to always print all columns, regardless 
#of the width of the screen.
tibble.width = Inf


# Extract by name
diamonds$cut
#Extract by value
diamonds[["cut"]]
# Extract by position
diamonds[[1]]
storms # what variables are in tibble?
View(storms)

#converting tibble back to dataframe
as.data.frame(diamonds)

#loading data, working with data
read_csv(readr_example("mtcars.csv"))
#loading an excel file
library(readxl)
readxl_example()# see what dataset are loaded as an examples in the RStudio
read_excel(readxl_example("type-me.xlsx")) #load data

#loading another dataset
data(mtcars)
mtcars

##Packages for data cleaning
install.packages("here") #install package
library(here)  #load library
install.packages("skimr") 
library(skimr)
install.packages("janitor")
library(janitor)
install.packages("dplyr")
library(dplyr)
install.packages("palmerpenguins")
library(palmerpenguins)
skim_without_charts(penguins)  #general info about dataframe
head(penguins) #print first 6rows of dataset

penguins %>% 
  rename(island_new = island) #rename column, first ists a new column name, 2nd ist name of the column which we use now

#uppercase for all columns
rename_with(penguins, toupper)

clean_names(penguins)  #only characters, numbers and underscores in the names

