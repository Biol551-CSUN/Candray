#Kevin Candray
#2021-02-24
#Week 5B Lecture
######################################
#installed lubridate package
library(tidyverse)
library(here)
library(lubridate)
######################################
#time stamp with function 
now() #what time is it now
#ask in other time zones
now(tzone = "EST") #what time is on the east coast
######################################
#only date and not time
today()
today(tzone = "GMT")
# ask if morning or if leap year
am(now())
#is it morning
leap_year(now())
#is it a leap year
######################################
#date specifications
ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")
######################################
#Date time specifications
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")
######################################
#vector of dates
#character string
datetimes <- c("02/24/2021 22:22:20",
               "02/25/2021 11:21:10",
               "02/26/2021 8:01:52")
#convert to date times
datetimes <- mdy_hms(datetimes)
month(datetimes, label = TRUE, abbr = FALSE) #spell it out
day(datetimes) #extract day)
wday(datetimes, label = TRUE) #extract day of week

hour(datetimes)
minute(datetimes)
second(datetimes)
######################################
#adding dates and times
datetimes + hours(4) #this adds 4 hours
datetimes + days(2)
######################################
#rounding dates
round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute
######################################
#think pair share
CondData <- read_csv(here("Week_5","Data","CondData.csv"))
View(CondData)
CondData %>% 
  mutate(DateTime = ymd_hms(date))
View(CondData)
