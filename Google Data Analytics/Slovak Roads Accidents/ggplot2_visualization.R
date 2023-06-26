install.packages("ggplot2")
install.packages("palmerpenguins")
library(ggplot2)
library(palmerpenguins)
data(penguins)
View(penguins)

ggplot(data = penguins) + geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g))

ggplot(data = penguins)
#visualization of different cuts over price of diamonds using scatterplot
data=diamonds
View(diamonds)  #price, cut
ggplot(data=diamonds) + geom_point(mapping = aes(x= cut, y= carat))
ggplot(data=diamonds)

#different price with different colors
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = cut, y = carat, color = price)) +
  facet_wrap(~ cut)

#Creating a barchart, colors are from outsite
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color= cut))

#fill up the bars with color
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

#Every bar with different color
library(RColorBrewer)
# Define a color palette with enough colors for each cut category
colors <- brewer.pal(n = length(unique(diamonds$cut)), name = "Set1")


#Pie chart
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut)) +
  scale_fill_manual(values = colors)
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = "", fill = cut), width = 1) +
  coord_polar(theta = "y") +
  theme_void()

# Pie chart with % of each part
library(dplyr)
library(scales)
# Calculate the percentage for each cut category
cut_percentage <- diamonds %>%
  count(cut) %>%
  mutate(percentage = percent(n / sum(n)))

ggplot(data = cut_percentage) +
  geom_bar(mapping = aes(x = "", y = n, fill = cut), width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  theme_void() +
  geom_text(aes(x = 1.3, y = cumsum(n) - 0.5 * n, label = percentage))


#using smooth and creating lineplot, combine geom_point and geom_smooth
head(penguins)
ggplot(data = penguins) +
  geom_smooth(mapping=aes(x=flipper_length_mm, y=body_mass_g))+
  geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g, color=species))



#bar chart
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill=cut))

#bar chart variation with different colors in the same bar
#bar chart
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill=clarity))





#Labels inside of the scatterplot
install.packages("ggrepel")
library(ggrepel)

ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(colour = species))+
  ggrepel::geom_label_repel(aes(label = species), data = penguins[order(penguins$body_mass_g, decreasing = TRUE),][1:10,])

#2 labels for all items in the scatterplot
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(colour = species)) +
  ggrepel::geom_label_repel(aes(label = species), data = penguins, hjust = 0.5, vjust = 0.5)

#legends & labels together
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(colour = species)) +
  ggrepel::geom_label_repel(
    aes(label = species),
    data = penguins,
    hjust = 0.5,
    vjust = 0.5,
    size = 6,
    label.size = 0,
    segment.color = NA,
    color = "black",
    fill = "white",
    #box.col = "black",
    # This will set the color of the labels to black and white
    color = c("black", "white")
  ) +
  theme(legend.position = "none")
#right corner label
ggplot(penguins, aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(colour = species)) +
  ggrepel::geom_label_repel(
    aes(label = species),
    data = penguins,
    hjust = 0.5,
    vjust = 0.5,
    size = 6,
    label.size = 0,
    segment.color = NA,
    color = "black",
    fill = "white",
    #box.col = "black",
    # This will set the color of the labels to black and white
    color = c("black", "white")
  ) +
  theme(legend.position = "none") +
  annotate("text", x = Inf, y = Inf, label = "This is a code provided by Michal Uhrinek", hjust = 1, vjust = 1)


#using hline and vline to help see the trends and add reference line
data(diamonds)

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_hline(yintercept = mean(diamonds$price), size = 2, colour = "white") +
  geom_vline(xintercept = mean(diamonds$carat), size = 2, colour = "white")

#using geom_segment to show arrow with a trend in the sertain segment of data
library(ggplot2)
data(diamonds)

# Define the coordinates for the starting and ending locations of the segment
start_x <- 1.5
start_y <- 10000
end_x <- 2.5
end_y <- 20000

# Create the plot
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_hline(yintercept = mean(diamonds$price), size = 2, colour = "white") +
  geom_vline(xintercept = mean(diamonds$carat), size = 2, colour = "white") +
  geom_segment(aes(x = start_x, y = start_y, xend = end_x, yend = end_y),
               arrow = arrow(length = unit(0.3, "cm")), colour = "red")




#draw rectangle around points of interest in certain area 
library(ggplot2)

# Create a scatter plot
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_hline(yintercept = mean(diamonds$price), size = 2, colour = "white") +
  geom_vline(xintercept = mean(diamonds$carat), size = 2, colour = "white") +
  
  # Add a rectangular area
  geom_rect(
    aes(xmin = 0.5, xmax = 1.5, ymin = 5000, ymax = 10000),
    fill = "blue",
    alpha = 0.2
  )
#using Facet grid to split scatterplot into 3different ones based on species of penguins
install.packages("gridExtra")
library(ggplot2)
library(gridExtra)
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_wrap(~ species)

#using Facet grid to split scatterplot into categories with 2 variables not just one
ggplot(data = penguins) +
  geom_point(mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  facet_grid(sex ~ species)


#Annotation, title, subtitle, caption..
#using different geom_gitter----to better look at outlier and data + anootate,
# Size, color of text
head(penguins)
ggplot(data = penguins) +
  geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g, color=species)) +
  annotate("text", x=220,y=3500,label="annotate text", color="purple", fontface="bold",
           size=4.5)



#using titles + adding titles
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill=clarity))+
  labs(title = "Cut vs clarity")

#subtitle adds additional detail in a smaller font beneath the title.
#caption adds text at the bottom right of the plot, often used to describe the source of the data.

#same with subtitle
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill=clarity))+
  labs(title = "Cut vs Count",
       subtitle = "Cut of the diamonds vs Count of the diamods",
       caption = "Created by Michal Uhrinek")

