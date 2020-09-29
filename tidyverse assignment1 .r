install.packages("tidyverse")
library(tidyverse)

#exercise 3.2.4
#1-Run ggplot(data = mpg). What do you see?
ggplot( data = mpg) # see nothing just gray screen

#2-How many rows are in mpg? How many columns? 234 rows and 11 columns

#3-What does the drv variable describe? it's describe the type of drive train

#4-Make a scatterplot of hwy vs cyl
ggplot(data= mpg)+
  geom_point(mapping= aes(x= hwy, y= cyl ))

#5-What happens if you make a scatterplot of class vs drv? Why is the plot not useful?

ggplot(data= mpg)+
  geom_point(mapping= aes(x= class, y= drv ))
#it is not useful because it's not telling us anything and we can't get a benefits information from it

#--------------------------------------------------------------------------------------------

#3.3.1 Exercises
#1- correct code:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color ="blue")

#2-Which variables in mpg are categorical? Which variables are continuous?
# categorical variables are : manufacturer,year, model, trans, fl,class
#continuous variables are: displ, cty, hwy,cyl,drv

#Map a continuous variable to color, size, and shape.
#3- How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape=drv, color=cyl, size=hwy ))
#it's hard to understand the plot

#4-What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape=class, color=class))
#it's work but not useful

#5-What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, .stroke=class))
#Nothing change

#What happens if you map an aesthetic to something other than a variable name, 
#like aes(colour = displ < 5)?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))
#coloring the displ that greater than 5 with red

#-----------------------------------------------------------------------------------

#3.5.1 Exercises
#1- What happens if you facet on a continuous variable?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))+
  facet_grid(~cyl)
#it's work but it's uncomfortable 

#2- What do the empty cells in plot with facet_grid(drv ~ cyl) mean?
#there's no data of this combination

#3-What plots does the following code make? What does?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)#row
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ drv)#columns
#change the catogry from columns to rows

#4- What are the advantages to using faceting instead of the color aesthetic? 
#What are the disadvantages? 
#How might the balance change if you had a larger dataset?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
#with coloring we can see the most clustered class which will be benefits in big datasets 
#the facet shown deffrint classes which will be benefits with small dataset

#5- What does nrow do? for number of row, ncol for number of columns 
# facet_wrap is give a better use of screen using nrow and ncol thwn facet_grid()
#6-When using facet_grid() you should usually put the variable 
#with more unique levels in the columns. Why?
#because when we but variable with more level thw y-axis will be large and it will be hard to get a clear informatio from it

#----------------------------------------------------------------------------------------------------

#3.6.1 Exercises

#1- What geom would you use to draw a line chart?
ggplot(data= mpg)+
  geom_line(mapping= aes(x= displ, y = hwy ))
#.  A boxplot? 
ggplot(data= mpg)+
  stat_summary(mapping= aes(x= displ, y = hwy ))
#.  A histogram?
ggplot(data= mpg)+
  geom_bar(mapping= aes(x= class, fill = class))
#.  An area chart?
ggplot(data= mpg, mapping= aes(x= displ, y = hwy ))+
  geom_area(mapping= aes( ),fill="blue")

#2-
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

#3- What does show.legend = FALSE do? it's hide the legend 
# What happens if you remove it? it's set as True by default 

#4- What does the se argument to geom_smooth() do? display confidence interval 

#5- what's different between two code? 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg) + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))


#----------------------------------------------------------------------------

#3.7.1 Exercises

#1- What is the default geom associated with stat_summary()? is geom_pointrange()
#How could you rewrite the previous plot to use that geom function instead of the stat function?
ggplot(data = mpg ) +
  geom_pointrange(mapping = aes(x = displ, y = hwy, ymin=min(displ), ymax= max(displ)))
#2- What does geom_col() do? How is it different to geom_bar()?
# the geom_col() is use the highest value in data but geom_bar() is count data as default 

#3- Read through the documentation and make a list of all the pairs. What do they have in common?

#4-What variables does stat_smooth() compute? What parameters control its behaviour?
# seeing patterns in the presence of overplotting, se

#5-We need to set group = 1. Why? In other words what is the problem with these two graphs?
#because its counts the number of appearance in each class of the variable

#------------------------------------------------------------------------------------

#3.8.1 Exercises
#1- What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
#there are many observations are have same value  
# adding geom_jitter which add amount of random variation
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

#2- hat parameters to geom_jitter() control the amount of jittering?
#hight and width

#3- Compare and contrast geom_jitter() with geom_count().
# geom_count() counts the overlapping points and 
# geom_jitter() add amount of random variation

#What’s the default position adjustment for geom_boxplot()? 
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(y = displ, x = drv, color = factor(year)))
