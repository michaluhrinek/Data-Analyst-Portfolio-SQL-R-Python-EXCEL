install.packages("tidyverse")
library(tidyverse)
library(readxl)

#Loading data
accidents_df <- read_xls("sk_nehody_data_2022.xls")
View(accidents_df)


# Replace all empty columns with 0
accidents_df[is.na(accidents_df)] <- 0
View(accidents_df)


# Check for missing values in accidents_df
missing_values <- sum(is.na(accidents_df))
print(missing_values)

#Any NA values? 
# Check for missing values in accidents_total column
missing_values <- sum(is.na(accidents_df$accidents_total))
print(missing_values)

# Check unique values in accidents_total column
unique_values <- unique(accidents_df$accidents_total)
print(unique_values)

# Replace all empty columns with 0
accidents_df[is.na(accidents_df)] <- 0
View(accidents_df)


#------------------------------------------------------------------------------------------
##Data Visualization 
```{r Data visualization install of packages}
#Data Visualization
install.packages("ggplot")
library(ggplot2)  #load package

#Number of accidents over time
ggplot(data = accidents_df) +
  geom_point(mapping = aes(y = accidents_total, x = year, colour = "red")) +
  geom_line(mapping = aes(y = accidents_total, x = year, colour = "red")) +
  ggtitle("Number of Accidents Over Time") 
#------------------------------------------------------------------------------------------

#Number of car accidents past 10years
filtered_df <- subset(accidents_df, year >= 2012)

# Create a line plot with connected points
ggplot(data = filtered_df) +
  geom_point(mapping = aes(x = year, y = car_accidents), colour = "red") +
  geom_line(mapping = aes(x = year, y = car_accidents), colour = "red") +
  ggtitle("Number of car accidents over Time (Last 10 Years)") +
  xlab("Year") +
  ylab("car_accidents") +
  theme_minimal()

#------------------------------------------------------------------------------------------
#car_alcohol_total

filtered_df <- subset(accidents_df, year >= 2012)

# Create a line plot with connected points
ggplot(data = filtered_df) +
  geom_point(mapping = aes(x = year, y = car_alcohol_total), colour = "red") +
  geom_line(mapping = aes(x = year, y = car_alcohol_total), colour = "red") +
  ggtitle("Number of drunk drivers in (Last 10 Years)") +
  xlab("Year") +
  ylab("number of people having alcohol driving car") +
  theme_minimal()


#Same with line plot but I got 2missing points
# Filter the data from year 2012
filtered_df <- subset(accidents_df, year >= 2012)

# Convert 'year' and 'car_alcohol_total' to numeric
filtered_df$year <- as.numeric(filtered_df$year)
filtered_df$car_alcohol_total <- as.numeric(filtered_df$car_alcohol_total)

# Create the line plot
ggplot(data = filtered_df) +
  geom_point(mapping = aes(x = year, y = car_alcohol_total), colour = "red") +
  geom_line(mapping = aes(x = year, y = car_alcohol_total), colour = "red") +
  ggtitle("Number of drunk drivers in (Starting from 2012)") +
  xlab("Year") +
  ylab("Number of people driving under the influence of alcohol") +
  theme_minimal()



#-------------------------------------------------------------------------------------
#Create bar chart Car accidents over 10years 
# Convert 'accidents_total' column to numeric
filtered_df <- subset(accidents_df, year >= 2012)
accidents_df$car_accidents <- as.numeric(as.character(accidents_df$car_accidents))

# Create a bar chart with varying bar sizes
ggplot(filtered_df, aes(x = year, y = car_accidents, fill=car_accidents)) +
  geom_bar(stat = "identity", width = 0.7) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(title='Car accidents for last 10 years', x = "Year", y = "Accidents Total") +
  theme_minimal()



#----------------------------------------------------------------------------------------
#Number of deaths on roads in past 10years
filtered_df <- subset(accidents_df, year >= 2012)

# Create a line plot with connected points
ggplot(data = filtered_df) +
  geom_point(mapping = aes(x = year, y = died_road_accidents), colour = "red") +
  geom_line(mapping = aes(x = year, y = died_road_accidents), colour = "red") +
  ggtitle("Died on road in 10 years") +
  xlab("Year") +
  ylab("Number of deaths") +
  theme_minimal()
#-----------------------------------------------------------------------------------------

#Alcohol during accidents 
filtered_df <- subset(accidents_df, year >= 2012)

ggplot(data = filtered_df) +
  geom_point(mapping = aes(x = year, y = alcohol_accidents_total), colour = "red") +
  geom_line(mapping = aes(x = year, y = alcohol_accidents_total), colour = "red") +
  ggtitle("Alchol during accidents on roads in 10 years") +
  xlab("Year") +
  ylab("Number of drivers with alcohol and walker with alcohol") +
  theme_minimal()
#-----------------------------------------------------------------------------------------
#Another dataset loading
library(readxl)
ac_df <- read_xls("accidents_reason.xls")
            
#---------------------------------------------------------------------------------------- 
#Create a bar chart with different causes of accidents
ggplot(data = ac_df) +
  geom_bar(mapping = aes(x = why_accidents, y = number_of_accidents), stat = "identity", fill = "lightblue") +
  geom_text(mapping = aes(x = why_accidents, y = number_of_accidents, label = number_of_accidents),
            position = position_stack(vjust = 0.5), color = "black", size = 3) +
  ggtitle("Number of Accidents by Reason") +
  xlab("Reason for Accidents") +
  ylab("Number of Accidents") +
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
#-----------------------------------------------------------------------------------------
#Create a pie chart with percentage of causes of accidents on roads
library(ggplot2)
ggplot(data = ac_df) +
  geom_bar(mapping = aes(x = "", y = accidents_p, fill = why_accidents),
           stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  ggtitle("Distribution of Accident Causes") +
  theme_minimal() +
  theme(legend.position = "bottom")
#By default, geom_bar() uses the stat = "count" argument, which counts the number of
#occurrences in each category. However, by setting stat = "identity", we can use the actual
#values from accidents_p as the heights of the bars.

#--------------------------------------------------------------------------------------
# Create a pie chart with labels
ggplot(data = ac_df) +
  geom_bar(mapping = aes(x = "", y = accidents_p, fill = why_accidents),
           stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  ggtitle("Distribution of Accident Causes") +
  theme_minimal() +
  theme(legend.position = "bottom")
#-------------------------------------------------------------------------------------
#TEST
#Createing a pie chart for reason for accidents
library(ggplot2)
name <- ac_df$why_accidents 
percent <- ac_df$accidents_p 


p <- ggplot() + theme_bw() +
geom_bar(aes(x="",y=percent,fill=name.factor),
         stat="identity", color="white")+
coord_polar("y",start = 0) +
ggtitle("Reasons for accidents by percentage")+
  theme(plot.title=element_text(hjust=0.5, size=20),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(),
    p+guides(fill=guide_legend(reverse=TRUE))+
    scale_fill_brewer(palette = "Greens",name="name")+
    theme(legend.text = element_text(size=15)),
          legend.title = element_text(hjust=0.5, size = 18),
          legend.key.size = unit(1,"cm"))
p
#test2
#Why accidents code_pie chart
library(ggplot2)
name <- ac_df$why_accidents
percent <- ac_df$accidents_p

p <- ggplot() + theme_bw() +
  geom_bar(aes(x = "", y = percent, fill = name),
           stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  ggtitle("Reasons for accidents by percentage") +
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(),
        legend.text = element_text(size = 15),
        legend.title = element_text(hjust = 0.5, size = 18),
        legend.key.size = unit(1, "cm"))+
  scale_fill_brewer(palette = "Set3", name = "Reason")+
  guides(fill = guide_legend(reverse = TRUE)) +
  scale_fill_brewer(palette = "Greens", name = "name")

p


#Percentage of each causes of accidents
library(ggplot2)

name <- ac_df$reason_for_accidents
percent <- ac_df$accidents_p

# Calculate the positions for the labels
ypos <- cumsum(percent) - 0.5 * percent

p <- ggplot() + theme_bw() +
  geom_bar(aes(x = "", y = percent, fill = name),
           stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  ggtitle("Reasons for accidents by percentage") +
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(),
        legend.text = element_text(size = 15),
        legend.title = element_text(hjust = 0.5, size = 18),
        legend.key.size = unit(1, "cm")) +
  geom_text(aes(x = "", y = ypos, label = paste0(percent, "%")),
            size = 6) +
  guides(fill = guide_legend(reverse = TRUE)) +
  scale_fill_brewer(palette = "Greens", name = "Reason")

p



#-----------------------------------------------------------------------------------------
#Death during car accidents, driver, codriver, total amount of car accidents
library(ggplot2)

# Filter the dataset for the year 2022
filtered_df <- subset(accidents_df, year == 2022)

# Prepare the data for the pie chart
labels <- c("Died Co-driver", "Died Driver", "Death during Car Accidents")
values <- c(filtered_df$died_codriver, filtered_df$died_driver, filtered_df$death_during_car_accidents)

# Create a data frame for the pie chart
pie_data <- data.frame(labels, values)

# Create the pie chart
p <- ggplot(pie_data, aes(x = "", y = values, fill = labels)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y") +
  ggtitle("Distribution of Deaths during Car Accidents with drivers with alcohol (2022)") +
  theme_minimal() +
  theme(legend.position = "bottom") +
  scale_fill_manual(values = c("Died Co-driver" = "red", "Died Driver" = "orange", "Death during Car Accidents" = "green")) +
  geom_text(aes(label = values), position = position_stack(vjust = 0.5), color = "black", size = 4)

# Display the pie chart
print(p)











#----------------------------------------------------------------------------------------
#Average month alcohol data
library(ggplot2)

# Prepare the data for the pie chart
labels <- c("Cyclist", "Car", "Motorcycle", "Pedestrian")
values <- c(accidents_df$average_month_alcohol_cyclist, accidents_df$average_month_alc_car, accidents_df$average_month_alc_motocycle, accidents_df$average_month_alc_walker)

# Create a data frame for the pie chart
pie_data <- data.frame(labels, values)

# Create the pie chart
p <- ggplot(pie_data, aes(x = "", y = values, fill = labels)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y") +
  ggtitle("Average Monthly Alcohol Consumption by Transportation Mode") +
  theme_minimal()+
  theme(legend.position = "bottom") +
  scale_fill_manual(values = c("Cyclist" = "red", "Car" = "blue", "Motorcycle" = "green", "Pedestrian" = "purple")) +
  geom_text(aes(label = values), position = position_stack(vjust = 0.5), color = "black", size = 4)

# Display the pie chart
print(p)


#--------------------------------------------------------------------------------------
#animal_crash 1467   average for years at all is 1503     average_day_crush 4 which needs to be created

# accidents_pedestrians_crossing, deaths_pedestrians_crossing for 2022 year 
# Filter the data for the desired year
year <- 2022
filtered_df <- accidents_df[accidents_df$year == year, ]

# Create a data frame for plotting
df <- data.frame(
  Category = c("Total number ", "Deaths"),
  Count = as.numeric(filtered_df[, c("accidents_pedestrians_crossing", "deaths_pedestrians_crossing")])
)

# Create a bar chart
p <- ggplot(df, aes(x = Category, y = Count, label = Count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Categories", y = "Counts",
       title = paste("Accidents and Deaths involving Pedestrians Crossing and crossing roads for", year))

# Add labels inside the bars
p + geom_text(vjust = -0.5)

#--------------------------------------------------------------------------------------
#Create columns: avg_day_crash_animal
# Create a new column avg_day_crash_animal by dividing avg_month_animal_crash by 30
accidents_df$avg_day_crash_animal <- accidents_df$avg_month_animal_crash / 30

# Verify the new column
head(accidents_df)
View(accidents_df)


#Animal Crash
year <- 2022
filtered_df <- accidents_df[accidents_df$year == year, ]

# Create a data frame for plotting
df <- data.frame(
  Category = c("Crash with animals in total", "Average month","Average day"),
  Count = as.numeric(filtered_df[, c("animal_crash", "avg_month_animal_crash", "avg_day_crash_animal")])
)

# Create a bar chart
p <- ggplot(df, aes(x = Category, y = Count, label = Count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Categories", y = "Counts",
       title = paste("Accidents with animals for", year))

# Add labels inside the bars
p + geom_text(vjust = -0.5)



#------------------------------------------------------------------------------------------
#Creating pie chart for Average Monthly Alcohol Consumption by Transportation Mode for year 2022
# Filter the data for the desired year
year <- 2022
filtered_df <- accidents_df[accidents_df$year == year, ]

# Extract the values from the specific columns
values <- c(filtered_df$died_codriver, filtered_df$died_driver, filtered_df$death_during_car_accidents)

# Create labels for the pie chart slices
labels <- c("Died Co-driver", "Died Driver", "Death during Car Accidents")

# Create labels for the pie chart slices including the values
labels <- paste(labels,": ", values)

# Create a pie chart
pie(values, labels = labels)

# Set rainbow colors for the pie chart slices
#colors <- rainbow(length(values)) example
#update colors for different ones
# Define colors for the pie chart slices
colors <- c("steelblue", "darkorange", "deeppink")

# Create a pie chart with rainbow colors
pie(values, labels = labels, col = colors)

# Add a title to the pie chart
title("Car Accidents & Alcohol")
#------------------------------------------------------------------------------------------












