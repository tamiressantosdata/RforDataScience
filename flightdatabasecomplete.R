library(nycflights13)
library(tidyverse)
flights
?flights
View(flights)
filter(flights, month == 1, day == 1)
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
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
select(flights, time_hour, air_time, everything())
select(flights, contains("TIME"))
vars <- c(
  "year", "month", "day", "dep_delay", "arr_delay"
)

#mutate() always adds new columns at the end of your dataset so
#we'll start by creating a narrower dataset so we can see the new variables.

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance/ air_time * 60)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)
#If you only want to keep the new variables, use transmute():
  transmute(flights,
            gain = arr_delay - dep_delay,
            hours = air_time / 60,
            gain_per_hour = gain / hours
  )
 
# %/% (integer division) and %% (remainder)
  
   transmute(flights,
            dep_time,
            hour = dep_time %/% 100,
            minute = dep_time %% 100
  )

(x <- 1:10)
lag(x)
lead(x)
cumsum(x)
cummean(x)
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))
by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))
by_dest <- group_by(flights, dest)
delay <- summarize(by_dest,count = n(),dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")
delay
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

#remove the missing value na.rm
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm = TRUE))
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )
ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)
delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    # average delay:
    avg_delay1 = mean(arr_delay),
    # average positive delay:
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )
not_cancelled %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd))
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first = min(dep_time),
    last = max(dep_time)
  )
not_cancelled %>%
  count(dest)
not_cancelled %>%
  count(tailnum, wt = distance)

