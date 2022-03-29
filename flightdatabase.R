library(nycflights13)
library(tidyverse)
flights
?flights
View(flights)
filter(flights, month == 1, day == 1))
(jan1 <- filter(flights, month == 1, day == 1))
(dec25 <- filter(flights, month == 12, day == 25))
filter(flights, month == 11 | month == 12)
nov_dec <- filter(flights, month %in% c(11, 12))
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))
#Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
#Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
filter(flights, month == 1)
#Logical Operators
filter(flights, month == 11 | month == 12)
#or
nov_dec <- filter(flights, month %in% c(11, 12))
#to find flights that weren't delayed (on arrival or departure) by more than two
#hours, you could use either of the following two filters
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)
filter(df, is.na(x) | x > 1)
#It takes a data frame and a set of column names (or more complicated expressions) to order by
arrange(flights, year, month, day)
#Use desc() to reorder by a column in descending order
arrange(flights, desc(arr_delay))
#NA is missing value 
df <- tibble(x = c(5, 2, NA))
arrange(df, desc(x))
# Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
