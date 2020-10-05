#Chapter 16
library(tidyverse)
install.packages("lubridate")
library(lubridate)
install.packages("nycflights13")
library(nycflights13)
#16.2.4 Exercises

#1- What happens if you parse a string that contains invalid dates?
ymd(c("2010-10-10", "bananas"))
# result: "2010-10-10" NA  so it doesn't merg

#2-What does the tzone argument to today() do? Why is it important?
# tzone is specify which time zone would you like to use and by default will use computer's time zone

#3- Use the appropriate lubridate function to parse each of the following dates:
d1 <- "January 1th, 2010"
mdy(d1)

d2 <- "2015-Mar-07"
ymd(d2)

d3 <- "06-Jun-2017"
dmy(d3)

d4 <- c("August 19 (2015)", "July 1 (2015)")
mdy(d4)

d5 <- "12/30/14" # Dec 30, 2014
mdy(d5)

#----------------------------------------------------------------------------------

#16.3.4 Exercises
make_datetime_100<- function(year,month,day,time){
  make_datetime(year,month,day,time %% 100,time %% 100 )
}

flight_dt <- flights%>%
  filter(!is.na(arr_delay),!is.na(dep_delay))%>%
  mutate(
    dep_time = make_datetime_100(year,month,day,dep_time),
    arr_time = make_datetime_100(year,month,day,arr_time),
    sched_dep_time = make_datetime_100(year,month,day,sched_dep_time),
    sched_arr_time = make_datetime_100(year,month,day,sched_arr_time)
  )%>%
  select(origin, dest, ends_with("delay"), ends_with("time"))

#1- How does the distribution of flight times within a day change over the course of the year?

flight_dt%>%
  mutate(dep_date = make_date(year(dep_time),month(dep_time),day(dep_time)),
         dep_hour = hour(dep_time))%>%
  filter(dep_date=="2013-09-08")%>%
  ggplot(mapping = aes(x = dep_hour)) +
  geom_density(alpha = .1)

#2- Compare dep_time, sched_dep_time and dep_delay. Are they consistent? Explain your findings.
#dep_delay is inconsistent
flight_dt%>%
  select(dep_time,sched_dep_time,dep_delay)%>%
  mutate(deff_delay = as.numeric(dep_time - sched_dep_time) / 60)%>%
  filter(dep_delay != deff_delay) %>%
  mutate(dep_time = update(dep_time, mday = mday(dep_time) + 1)) %>%
  mutate(deff_delay = as.numeric(dep_time - sched_dep_time)) %>%
  filter(dep_delay != deff_delay)
#after update all value are consistent


#3- Compare air_time with the duration between the departure and arrival. Explain your findings.
flight_dt%>%
  mutate(deff_arr_time = as.numeric(arr_time - dep_time))%>%
  select(contains('air_time'))

#4-How does the average delay time change over the course of a day? 
flight_dt %>%
  mutate(hour = hour(sched_dep_time)) %>%
  group_by(hour) %>%
  summarize(avg_dep_d = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(mapping = aes(x = hour, y = avg_dep_d)) +
  geom_point() +
  geom_smooth(se = FALSE)

#5-On what day of the week should you leave if you want to minimise the chance of a delay?
flight_dt %>%
  mutate(day_week = wday(sched_dep_time, label = TRUE)) %>%
  group_by(day_week) %>%
  summarize(avg_dep_d = mean(dep_delay, na.rm = TRUE),
            avg_arr_d = mean(arr_delay, na.rm = TRUE)) %>%
  gather(key = 'delay', value = 'minutes', 2:3) %>%
  ggplot() +
  geom_col(mapping = aes(x = day_week, y = minutes, fill = delay),
           position = 'dodge')

#6- What makes the distribution of diamonds$carat and flights$sched_dep_time similar?
View(diamonds)
#carat
diamonds%>%
  ggplot(mapping = aes(x=carat))+
  geom_bar()

flight_dt%>%
  ggplot(mapping = aes(x=sched_dep_time))+
  geom_bar()

#7-
flight_dt %>%
  mutate(delayed = dep_delay > 0,minutes = minute(sched_dep_time) %/% 10 * 10,
         minutes = factor(minutes, levels = c(0,10,20,30,40,50),
                          labels = c('0 - 9 m','10 - 19 m',
                                     '20 - 29 m','30 - 39 m',
                                     '40 - 49 m','50 - 50 m'))) %>%
  group_by(minutes) %>%
  summarize(prop_early = 1 - mean(delayed, na.rm = TRUE)) %>%
  ggplot() +
  geom_point(mapping = aes(x = minutes, y = prop_early))

#----------------------------------------------------------------------------------

#16.4.5 Exercises

#1-Why is there months() but no dmonths()? month has no fix duration 

#2-Explain days(overnight * 1) to someone who has just started learning R. How does it work?
#overnight is a boolean variable, if the dep_time is grater than arr_time will be FALS , otherwise TRUE

#3- Create a vector of dates giving the first day of every month in 2015.
#Create a vector of dates giving the first day of every month in the current year.
year2015 <- years(2015) + months(c(1:12)) + days(1)
year2015

#4- Write a function that given your birthday (as a date), returns how old you are in years.
your_age <- function(your_day) {
  age <- today() - your_day
  return(floor(age/dyears(1)))
}
your_age(ymd(19960619))

#5-Why can’t (today() %--% (today() + years(1))) / months(1) work?

(today() %--% (today() + years(1))) / months(1)
#no counting for 12 months