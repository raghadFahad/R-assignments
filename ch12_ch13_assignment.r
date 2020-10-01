#Chapter 12

#12.2.1 Exercises
#1- Using prose, describe how the variables and observations are organized in each of the sample tables.
table1 # each variable has a column, each observation have a row and each cell has single value
table2 # #each variable has a column, the same observation have more than one row, each cell has single valu
table3 #each column has variable, each observation has a row but th rate cell's has more than single value
table4a #more than column has the same variable (year), each observation has row, each cell has single value
table4b #more than column has the same variable (year), each observation has row, each cell has single value
table5#each column has variable, each observation has a row but th rate cell's has more than single value

#2-Compute the rate for table2, and table4a + table4b. You will need to perform four operations
#table2
table2
table2_tidy<- table2%>%
  pivot_wider(names_from = type, values_from = count)
table2_tidy%>%
  mutate(rate= cases/population *10000 )

#table4a, table4b
tidy4a<-table4a%>%
  pivot_longer(c(`1999`, `2000`), names_to= "year", values_to= "case")

tidy4b<- table4b %>%
  pivot_longer(c(`1999`,`2000`), names_to = "year", values_to= "population")

#make it as one table to remove the repeated data
tidy_table4 <- left_join(tidy4a, tidy4b)

tidy_table4%>%
  mutate(rate= case/population *10000 )


#3-Recreate the plot showing change in cases over time using table2 instead of table1. What do you need to do first?
ggplot(data = filter(table2,type == "cases"), mapping = aes(x = year, y= count))+
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

#-------------------------------------------------------------------------------------------
#12.3.3 Exercises
#1-Why are pivot_longer() and pivot_wider() not perfectly symmetrical?

stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")
# because column type information is lost

#2-Why does this code fail?
table4a
table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")
#cause 1999 and 2000 haven't ``

#3-What would happen if you widen this table? Why? 

#How could you add a new column to uniquely identify each value?
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)
people$pid <- c(1, 1, 2, 1, 1)
people<- people%>%
  pivot_wider(names_from = names, values_from = values)
people

#4- Tidy the simple tibble below. Do you need to make it wider or longer? What are the variables?
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
preg%>%
  gather(key = 'gender', value = 'value', 2:3, na.rm = TRUE)

#---------------------------------------------------------------------------------------------

#12.4.3 Exercises

#1- What do the extra and fill arguments do in separate()? 
#extra control the separation if there are many pieces and fill control when there are not enough pieces 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")
tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"),fill = "right")


#2- Both unite() and separate() have a remove argument.
#What does it do? it's remove input column from data frame output's if it TRUE (default)
#Why would you set it to FALSE? if it FALSE the output column will be retained in the output.

#3-Compare and contrast separate() and extract().
#Why are there three variations of separation (by position, by separator, and with groups)
#but only one unite?
#extract () is use a regluar expression to capture groups and turn groups into multiple columns.

#------------------------------------------------------------------------------------------------

#12.5.1 Exercises

# 1- Compare and contrast the fill arguments to pivot_wider() and complete().
# values_fill in pivot_wider() is (scalar) value that specifies
#what each value should be filled in with when missing.

#in complete() is a named list that for each variable supplies a single value to use
#instead of NA for missing combinations.


#2- What does the direction argument to fill() do?
#Any NAs will be replaced by the previous non-missing value

#------------------------------------------------------------------------------------------

#12.6.1 Exercises

#1- using values_drop_na = TRUE can be reasonable cause NA can impact the result polt

#2- What happens if you neglect the mutate() step? 
#(mutate(names_from = stringr::str_replace(key, "newrel", "new_rel")))
#the code will seprate in 3 columns

#3-I claimed that iso2 and iso3 were redundant with country. Confirm this claim.

who %>% select(1:3) %>% sapply(function(x){length(unique(x))})
# the result is 219     219     219 
who %>% select(1:3) %>%
  unite(combined, 1:3) %>%
  select(combined) %>%
  distinct() %>%
  nrow()
#the result is 219 which confirm that each contry has only ios2 and ios3, ios4 are repeated colums

#4- For each country, year, and sex compute the total number of cases of TB.
#Make an informative visualisation of the data.

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year, sex) %>%
  summarize(total_case = sum(value)) %>%
  filter(country == 'China') %>%
  ggplot() +
  geom_line(mapping = aes(x = year, y = total_case, color = sex,
                          group = country))

#-------------------------------------------------------------------------------------------

#Chapter13

#13.2.1 Exercises

#1- Imagine you wanted to draw (approximately) the route each plane flies from its origin to
#its destination.What variables would you need? What tables would you need to combine?
colnames(airports)
#the origin an destination is in airports table so we will need airports and flights table

#2- I forgot to draw the relationship between weather and airports. 
#What is the relationship and how should it appear in the diagram?
colnames(weather)
View(weather)
colnames(airports)
View(airports)
#match using weather.origin == airports.fee

# 3- weather only contains information for the origin (NYC) airports.
#If it contained weather records for all airports in the USA,
#what additional relation would it define with flights?

#Taht will allow to know information about the weather in the destnation 

#4-How might you represent that data as a data frame? 
#What would be the primary keys of that table? How would it connect to the existing tables?

#using year, month and day we can create a table that called special_day 

#-------------------------------------------------------------------------------------------

#13.3.1 Exercises

#1- Add a surrogate key to flights.
View(flights)
flights%>%
  mutate( s_key = row_number())%>%
  select(s_key, everything())
View(flights)

#2- Identify the keys in the following datasets
#a:Lahman::Batting: playerID, yearID, teamID, lgId
install.packages("Lahman")
library(Lahman)
View(Lahman::Batting)

#b: babynames::babynames: year, sex, name
install.packages("babynames")
library(babynames)
View(babynames::babynames)

#c: nasaweather::atmos : lat, long, year, month
install.packages("nasaweather")
library(nasaweather)
View(nasaweather::atmos)

#d: fueleconomy::vehicles: id,
install.packages("fueleconomy")
library(fueleconomy)
View(fueleconomy::vehicles)

#3- Draw a diagram illustrating the connections between the Batting, Master, and Salaries
colnames(Lahman::Batting)
colnames(Lahman::Master)
colnames(Lahman::Salaries)
# Batting and Master is matching with playerID
# Batting and Salaries is matching in yearID , teamID a, playerID nd lgID
# Master and Salaries is matching playerID 

# Draw another diagram that shows the relationship between Master, Managers, AwardsManagers
colnames(Lahman::Master)
colnames(Lahman::Managers)
colnames(Lahman::AwardsManagers)
#Master and Managers is matching in playerID 
#Master and AwardsManagers is matching in playerID, 
#Managers and AwardsManagers is matching in playerID, yearID, lgID, 

#How would you characterise the relationship between the Batting, Pitching, and Fielding tables?
#Matched with playerID, yearID, stint, teamID, and lgID.


#-------------------------------------------------------------------------------------------
#13.4.6 Exercises
library(tidyverse)
library(nycflights13)
install.packages("maps")
library(maps)

#1
View(flights)
View(airports)
flights%>%
  group_by(dest)%>%
  summarize(avgreg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airports, c("dest" = 'faa'))%>%
  ggplot(mapping = aes(x = lon, y = lat), size = avgreg_arr_delay, color = avgreg_arr_delay)+
  borders('state') +
  geom_point() +
  coord_quickmap()

#2- Add the location of the origin and destination (i.e. the lat and lon) to flights.
flights%>%
  left_join(airports, c("dest"="faa"))%>%
  left_join(airports, c("origin" = "faa"))%>%
  select(dest, origin, contains('lat'), contains('lon'))

#3- Is there a relationship between the age of a plane and its delays?

flights %>% group_by(tailnum) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE),
            avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  gather(key = 'mode', value = 'delay', 2:3) %>%
  left_join(planes, by = 'tailnum') %>%
  ggplot(mapping = aes(x = year, y = delay)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_grid(.~mode)

#4-What weather conditions make it more likely to see a delay?
flights %>% 
  left_join(weather, by = c('year','month','day','hour','origin')) %>%
  gather(key = 'condition', value = 'value', temp:visib) %>%
  filter(!is.na(dep_delay)) %>%
  ggplot(mapping = aes(x = value, y = dep_delay)) +
  geom_point() +
  facet_wrap(~condition, ncol = 3, scale = 'free_x')

#5- What happened on June 13 2013? Display the spatial pattern of delays, 
#and then use Google to cross-reference with the weather.
flights %>% filter(year == 2013, month == 6, day == 13) %>%
  group_by(dest) %>%
  summarize(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airports, by = c('dest' = 'faa')) %>%
  ggplot(aes(x = lon, y = lat, size = avg_arr_delay, color = avg_arr_delay)) +
  borders('state') +
  geom_point(alpha = .5) +
  scale_color_continuous(low = 'yellow', high = 'red') + 
  coord_quickmap()

#-------------------------------------------------------------------------------------------
#13.5.1 Exercises
#1-What does it mean for a flight to have a missing tailnum?
flights %>%
  anti_join(planes, by = 'tailnum') %>%
  group_by(carrier) %>%
  summarize(n = n()) %>%
  arrange(desc(n))
#2 – Filter flights to only show flights with planes that have flown at least 100 flights
flights_100 %
filter(!is.na(dep_delay)) %>%
  group_by(tailnum) %>%
  summarize(n = n()) %>%
  filter(n > 100)

flights %>%
  semi_join(flights_100, by = 'tailnum')

#3-Combine fueleconomy::vehicles and fueleconomy::common to find only the records for the most common models.
fueleconomy::vehicles %>%
  semi_join(fueleconomy::common, by = c('make', 'model'))

#5-What does anti_join(flights, airports, by = c("dest" = "faa")) tell you? What does anti_join(airports, flights, by = c("faa" = "dest")) tell you?
#anti_join(flights, airports, by = c("dest" = "faa")) shows flight whose destinations are not included in the airports database.
#anti_join(airports, flights, by = c("faa" = "dest")) shows airport names and locations that flights from flights are not flying to.

#6-
flights %>%
  select(carrier, tailnum) %>%
  group_by(tailnum) %>%
  summarize(n = length(unique(carrier))) %>%
  filter(n > 1)




