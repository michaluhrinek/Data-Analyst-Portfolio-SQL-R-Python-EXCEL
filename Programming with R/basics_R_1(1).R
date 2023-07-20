#Basics of R
install.packages("tidyverse") 
library(tidyverse)
library(lubridate)
install.packages("palmerpenguins")
library("palmerpenguins")
summary("penquins")

library(palmerpenguins)
data(package = 'palmerpenguins')

head(penguins)

#view, print 
View(penguins)  

#working with variables
first_variable <- "This is my first variable"
second_variable <- 12.5

#working with vecotrs
vec_1 <- c(13, 48.5, 71, 101.5, 2)
vec_1


#I use not c function but paste because it allows me to work with 2 or more strings as its argument

#and returns a single string that is the concatenation of the arguments. 
paste("Sara", "Lisa", "Anna")
typeof(paste("a", "b"))

typeof(c(1L , 3L)) #for integer
#length of characters, how many characters are there? 
x <- c(33.5, 57.75, 120.05)
length(x)

#is is TRUE or FALSE?
x <- c(2L, 5L, 11L)
is.integer(x)

#Naming vectors 

#All types of vectors can be named. Names are useful for writing readable code and 
#describing objects in R. You can name the elements of a vector with the names() 
#function. As an example, let’s assign the variable x to a new vector with three elements. 
x <- c(1, 3, 5)
names(x) <- c("a", "b", "c")
x

#working with list
list("a", 1L, 1.5, TRUE)
#what type of items are in the list? 
str(list("a", 1L, 1.5, TRUE))

#Lists, like vectors, can be named. You can name the elements of a list when you first create it with the list() function:
list('Chicago' = 1, 'New York' = 2, 'Los Angeles' = 3)

#working with time and date
install.packages("tidyverse") 
library(tidyverse)
library(lubridate)

#what is date today? "2021-01-20"
today()
# date and time? "2023-06-04 11:36:23 UTC"
now()

#Showing of date in different order, in year or month or day first
# practice
ymd("2021-01-20")

mdy("January 20th, 2021")

dmy("20-Jan-2021")

Creating date-time components

#The ymd() function and its variations create dates. To create a date-time from a date, 
#add an underscore and one or more of the letters h, m, and s (hours, minutes, seconds)
#to the name of the function:

ymd_hms("2021-01-20 20:11:59")

mdy_hm("01/20/2021 08:01")
#switch between a date-time and a date. 

#You can use the function as_date() to convert a date-time to a date. For example, 
#put the current date-time—now()—in the parentheses of the function. 
as_date(now())


#Working with dataframes
#creating dataframe
data.frame()
#filling up dataframe 
data.frame(x = c(1, 2, 3) , y = c(1.5, 5.5, 7.5))

#Working with files 

#create new folder 
dir.create ("destination_folder")

#Use the file.create() function to create a blank file.
#Creating new files(different files)
file.create("new_csv_file.csv")
file.create("new_word_file.docx")
file.create("new_csv_file.csv")

#delete file using unlink
unlink ("new_csv_file.csv")

#Creating a Matrix of number 3-8 with 2rows
matrix(c(3:8), nrow = 2)

#specify number of collumns using ncol
matrix(c(3:8), ncol = 2)










