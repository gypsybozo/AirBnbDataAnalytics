## Load Required Libraries
library(dplyr)
library(moments)
library(DescTools)
library(plotly)
library(ggplot2)
library(maps) 
library(mapview) 
library(sf)

## Load and Inspect Data
data <- read.csv("listings.csv")
print(ncol(data))
print(nrow(data))
print(colnames(data))
print(summary(data))

## Data Cleaning
# Drop columns with all null values
data <- data[, !names(data) %in% c("bathrooms", "calendar_updated", "license")]

# Remove rows with high NA counts
data <- data[!(rowSums(is.na(data)) >= 9), ]

# Replace "N/A" or text values in percentage columns with numeric equivalents
data$host_acceptance_rate <- as.numeric(sub("%", "", data$host_acceptance_rate))
data$host_response_rate <- as.numeric(sub("%", "", data$host_response_rate))

# Convert price to numeric
data$price <- as.numeric(gsub("\\$", "", data$price))
data$price[is.na(data$price)] <- mean(data$price, na.rm = TRUE)

# Replace NA values in specific columns
data$bedrooms <- replace(data$bedrooms, is.na(data$bedrooms), 0)
data$review_scores_value <- replace(data$review_scores_value, is.na(data$review_scores_value), mean(data$review_scores_value, na.rm = TRUE))
data$review_scores_location <- replace(data$review_scores_location, is.na(data$review_scores_location), mean(data$review_scores_location, na.rm = TRUE))
data$host_listings_count <- replace(data$host_listings_count, is.na(data$host_listings_count), Mode(data$host_listings_count, na.rm = TRUE)[1])
data$host_total_listings_count <- replace(data$host_total_listings_count, is.na(data$host_total_listings_count), Mode(data$host_total_listings_count, na.rm = TRUE)[1])

## Statistical Analysis
# Summary Statistics
print(sapply(data, function(x) n_distinct(x)))
mean(data$latitude)
sd(data$latitude)
mean(data$longitude)
sd(data$longitude)

# Ratings
mean(data$review_scores_rating, na.rm = TRUE)
median(data$review_scores_accuracy, na.rm = TRUE)

# Grouped Analysis
print(data %>% group_by(beds) %>% summarise(AvgRating = mean(review_scores_rating, na.rm = TRUE)), n = 21)
data %>% group_by(host_is_superhost) %>% summarise(avg_rating = mean(review_scores_rating, na.rm = TRUE))

## Visualization
# Scatter Plot
plot(x = data$price, y = data$accommodates, xlab = "Price", ylab = "Accommodates", main = "Price vs Accommodates")

# Boxplots
boxplot(data$availability_30, col = "blue", main = "Availability in 30 Days")
boxplot(data$availability_60, col = "blue", main = "Availability in 60 Days")
boxplot(availability_365 ~ accommodates, data = data, main = "Availability by Accommodates")

# Bar Plot
barplot(table(data$room_type), main = "Room Types", xlab = "Room Type", ylab = "Frequency", col = "skyblue")

# Grouped Bar Plot
data$host_response_time <- factor(data$host_response_time, levels = c("within an hour", "within a day", "a few days or more"))
filtered_data <- data[data$host_is_superhost %in% c("t", "f") & !data$host_response_time %in% c(" ", "N/A"), ]
ggplot(filtered_data, aes(x = host_response_time, fill = host_is_superhost)) +
  geom_bar(position = "dodge", stat = "count") +
  labs(title = "Response Time Comparison for Superhosts vs Others", x = "Response Time", y = "Count") +
  scale_fill_manual(values = c("t" = "skyblue", "f" = "coral"))

# Pie Chart
pie(c(table(data$neighbourhood_group_cleansed)), main = "Neighbourhood Group Cleansed")

# Histogram
hist(data$availability_365, main = "Availability of Rooms in 365 Days", xlab = "Availability", col = "yellow")
legend("topright", legend = c("Kriti Bharadwaj", "PES1UG22CS295"))

# Correlation
cor(data$number_of_reviews, data$review_scores_rating)

# Scatter Plot for Cleanliness vs Communication
plot(x = data$review_scores_cleanliness, y = data$review_scores_communication, xlab = "Cleanliness", ylab = "Communication with Owner", main = "Cleanliness vs Communication")
