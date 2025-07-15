library(tidyverse)
library(ggthemes)
glimpse(penguins)
ggplot(
  data = penguins, 
  mapping = aes(x = flipper_len, y = body_mass)
  ) +
  geom_point(mapping = aes(color=species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body Mass and Flipper Length",
    subtitle = "Dimensions for Adelie, Chinstrap and Gentoo",
    x = "Flipper length(mm)", y = "Body Mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()



___________________________________
#1.3 ggplot2 calls

penguins |> ggplot(
  aes(x = flipper_len, y = body_mass)
) +
  geom_point()


ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

ggplot(penguins, aes(x = body_mass)) +
  geom_histogram(binwidth = 200)


ggplot(penguins, aes(x = body_mass)) +
  geom_histogram(binwidth = 20)
ggplot(penguins, aes(x = body_mass)) +
  geom_histogram(binwidth = 2000)


ggplot(penguins, aes(x = body_mass)) +
  geom_density()

#1.5 Visualizing Relationships
ggplot(penguins, aes(x = species, y = body_mass)) +
  geom_boxplot()


ggplot(penguins, aes(x = body_mass, color = species)) +
  geom_density(linewidth = 2)

ggplot(penguins, aes(x = body_mass, color = species, fill = species)) +
  geom_density(alpha = 0.2)

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")


ggplot(penguins, aes(x = flipper_len, y = body_mass)) +
  geom_point(aes(color = species, shape = island))

ggplot(penguins, aes(x = flipper_len, y = body_mass)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)


getwd()
ggplot(penguins, aes(x = flipper_len, y = body_mass)) +
  geom_point()
ggsave(filename = "penguin-plot.png")


Exercises

#1. How many rows are in penguins? How many columns?
  
nrow(penguins)    
ncol(penguins)


#2What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out
?penguins
#they measure the bill depth of penguins in mm

ggplot(penguins, 
       mapping = aes(x = bill_len, y = bill_dep)) +
    geom_point()


#4What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
ggplot(penguins, 
       mapping = aes(x = species, y = bill_dep)) +
    geom_point()
#boxplot might be a better plot
ggplot(penguins, 
       mapping = aes(x = species, y = bill_dep)) +
    geom_boxplot()

#Why does the following give an error and how would you fix it?
    
ggplot(data = penguins) + 
geom_point()
#we are missing aesthetics. We need to specify the data we want to show, like in the instances before.

#What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.

help(geom_point)
#it removes non available data from showing in points. The default value is false. 
ggplot(penguins, 
       mapping = aes(x = bill_len, y = bill_dep)) +
    geom_point(na.rm = TRUE)

#7Add the following caption to the plot you made in the previous exercise: “Data come from the palmerpenguins package.” Hint: Take a look at the documentation for labs().
help(labs)
p = ggplot(penguins, 
       mapping = aes(x = bill_len, y = bill_dep)) +
    geom_point(na.rm = TRUE)
p + labs(caption = "Data come from the palmerpenguins package.")

#Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? And should it be mapped at the global level or at the geom level?
ggplot(penguins, 
       aes(x= flipper_len, y = body_mass)) + 
    geom_point(aes(color = bill_dep)) +
    geom_smooth()

#9
ggplot(
    data = penguins,
    mapping = aes(x = flipper_len, y = body_mass, color = island)
) +
    geom_point() +
    geom_smooth(se = FALSE)

#10
#Will these two graphs look different? Why/why not?
    
ggplot(
        data = penguins,
        mapping = aes(x = flipper_len, y = body_mass)
    ) +
    geom_point() +
    geom_smooth()

ggplot() +
    geom_point(
        data = penguins,
        mapping = aes(x = flipper_len, y = body_mass)
    ) +
    geom_smooth(
        data = penguins,
        mapping = aes(x = flipper_len, y = body_mass)
    )

#No, because you assigned the same aesthetics to both the points and the line, the only 
#difference is that you separated in both geoms in the second case


#Exercises 1.4.3

#Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
ggplot(penguins, aes(y = species)) +
    geom_bar()
#the only difference is that the columns grow laterally now (they are on the y axis)

#How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?

ggplot(penguins, aes(x = species)) +
    geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
    geom_bar(fill = "red")
#fill makes the color more noticeable but can be a bit too blunt

#What does the bins argument in geom_histogram() do?
help(geom_histogram)
#it directly specifies the number of bins you'd like the histogram to contain

#Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. Experiment with different binwidths. What binwidth reveals the most interesting patterns?
glimpse(diamonds)
help(diamonds)
ggplot(diamonds, aes(x = carat)) +
    geom_histogram(binwidth = 200)
ggplot(diamonds, aes(x = carat)) +
    geom_histogram(binwidth = 2)
ggplot(diamonds, aes(x = carat)) +
    geom_histogram(binwidth = 0.2)
#Binwidth 0.2 reveals that most diamonds are below 1 carat (200mg) in weight


#1.5.5 Exercises
#The mpg data frame that is bundled with the ggplot2 package contains 234 observations 
#collected by the US Environmental Protection Agency on 38 car models. Which variables in mpg are categorical? 
#Which variables are numerical? (Hint: Type ?mpg to read the documentation for the dataset.) 
#How can you see this information when you run mpg?

glimpse(mpg)
help(mpg)
#categorical: manufacturer, model, trans, drv, fl, class
#numerical: displ, cyl, cty, hwy, year
#you can see this information between <> right after the name of the variable

#Make a scatterplot of hwy vs. displ using the mpg data frame. Next, map a third, numerical variable to color, then size, then both color and size, 
#then shape. How do these aesthetics behave differently for categorical vs. numerical variables?
ggplot(mpg, aes(x = hwy, y = displ)) +
    geom_point()
ggplot(mpg, aes(x = hwy, y = displ, color = year)) +
    geom_point()
ggplot(mpg, aes(x = hwy, y = displ, size = cyl)) +
    geom_point()
ggplot(mpg, aes(x = hwy, y = displ, color = year, size = cyl)) +
    geom_point()
ggplot(mpg, aes(x = hwy, y = displ, color = year, size = cyl, shape = fl)) +
    geom_point()

#color is a gradient for continous variables and unique different colors for discrete. For the shape aesthetic, 
#a continuous variablle cannot be mapped. 

#In the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?
ggplot(mpg, aes(x = hwy, y = displ, linewidth = cyl)) +
    geom_point()
    
#it doesn't make any difference, because there are no lines in a scatterplot

#What happens if you map the same variable to multiple aesthetics?
ggplot(mpg, aes(x = hwy, y = displ, color = year, size = year)) +
    geom_point()
#in this case both the size and the color reflect the different displ


#Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. 
#What does adding coloring by species reveal about the relationship between these two variables? What about faceting by species?

ggplot(penguins, aes(x = bill_dep, y = bill_len, color = species)) +
    geom_point() +
    facet_wrap(~species)
#it reveals that both variables are related. For instance, a penguin which has both variables with large value is likely to be a chinstrap. 
#faceting separates the points by that variable.


#Why does the following yield two separate legends? How would you fix it to combine the two legends?
    
ggplot(
        data = penguins,
        mapping = aes(
            x = bill_len, y = bill_dep, 
            color = species, shape = species
        )
    ) +
    geom_point()
#just take out labs

#Create the two following stacked bar plots. Which question can you answer with the first one? Which question can you answer with the second one?
    
    ggplot(penguins, aes(x = island, fill = species)) +
    geom_bar(position = "fill")
    
    #with this one we can answer what percentage of penguins in each island is of each species
ggplot(penguins, aes(x = species, fill = island)) +
    geom_bar(position = "fill")
#with this one we can see from each species, what percentage lives in which island


#Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?

ggplot(mpg, aes(x = class)) +
    geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
    geom_point()
ggsave("mpg-plot.png")
#it saves the last one that was done



