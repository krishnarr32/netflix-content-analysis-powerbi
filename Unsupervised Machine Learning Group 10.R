# Group 10

# Step 1
## Check if relevant packages exist. Install them if needed.
## Package for Visualisation
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)

## Package for computing Silhouette Score
if (!require("cluster")) install.packages("cluster")
library(cluster)

## Package for Association Rules (unlikely to there already)
install.packages("arules") # need to install package once!
library(arules)
install.packages("arulesViz") # need to install package once!
library(arulesViz)

if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)

## Package for generating multiple scatterplots
if (!require("GGally")) install.packages("GGally")
library(GGally)

## Package for correlations
if (!require("corrplot")) install.packages("corrplot")
library(corrplot)

## Package for transformation
if (!require("dplyr")) install.packages("dplyr")
library(dplyr)

if (!require("stringr")) install.packages("stringr")
library(stringr)

if (!require("tidyr")) install.packages("tidyr")
library(tidyr)

## Package for generating multiple scatterplots
if (!require("GGally")) install.packages("GGally")
library(GGally)

## Import preparation
if (!require("readr")) install.packages("readr")
library(readr)

# Step 2
## Load the CSV file (clearned in PowerBI) for processing.
## Check summary statistics and structure of the dataframe. 
df_netflix_csv <- read_csv("1_2_Netflix_ML.csv")
summary(df_netflix_csv)
str(df_netflix_csv)

## Prepare ML base table: cleaned + genre booleans + drop country fields 
df_ml_base <- df_netflix_csv %>%
  mutate(row_id = row_number()) %>% 
  select(
    -row_id,
    -main_country,
    -country_clean   
  )

## Split into TV Show / Movie ML sub-datasets
df_tv_ml <- df_ml_base %>%
  filter(type == "TV Show")

df_movie_ml <- df_ml_base %>%
  filter(type == "Movie")

## Prepare datasets for Apriori algorithm 
df_tv_apri <- df_tv_ml %>%
  select(
    rating_clean,
    `Cast Size`,
    `Director Number`,
    `Genre Number`,
    starts_with("genre_"),
    -genre_count
  )

df_movie_apri <- df_movie_ml %>%
  select(
    rating_clean,
    `Cast Size`,
    `Director Number`,
    `Genre Number`,
    starts_with("genre_"),
    -genre_count
  )

## Convert to transactions & run Apriori
netflix_txn_tv    <- as(df_tv_apri,    "transactions")
netflix_txn_movie <- as(df_movie_apri, "transactions")

min_support    <- 0.05   ### Based on experiment, 5% is optimal
min_confidence <- 0.60   ### 60% confidence keeps rules clean and interpretable 

## Run rules 
rules_tv <- apriori(
  netflix_txn_tv,
  parameter = list(
    supp   = min_support,
    conf   = min_confidence,
    target = "rules"
  )
)

rules_movie <- apriori(
  netflix_txn_movie,
  parameter = list(
    supp   = min_support,
    conf   = min_confidence,
    target = "rules"
  )
)

## Plot top 25 TV Show rules by lift 
rules_tv_top <- head(sort(rules_tv, by = "lift", decreasing = TRUE), 25)

### (1) network
network_tvshow <- plot(
  rules_tv_top,
  method  = "graph",
  engine  = "ggplot2",
  control = list(type = "items"),
  colors  = c("#990000", "#FF8888")
)

network_tvshow$layers[[1]]$aes_params$edge_alpha  <- 0.3
network_tvshow$layers[[1]]$aes_params$edge_colour <- "grey40"

network_tvshow

### (2) item frequency 
itemFrequencyPlot(
  netflix_txn_tv,
  topN = 15,
  type = "relative",
  main = "Top 15 frequent items in TV Shows"
)

## Plot top 15 Movie rules by lift
rules_movie_top <- head(sort(rules_movie, by = "lift", decreasing = TRUE), 15)

# (1) network
network_movie <- plot(
  rules_movie_top,
  method  = "graph",
  engine  = "ggplot2",
  control = list(type = "items"),
  colors  = c("#990000", "#FF8888")
)

network_movie$layers[[1]]$aes_params$edge_alpha  <- 0.3
network_movie$layers[[1]]$aes_params$edge_colour <- "grey40"

network_movie

# (2) item frequency 
itemFrequencyPlot(
  netflix_txn_movie,
  topN = 15,
  type = "relative",
  main = "Top 15 frequent items in Movies"
)


