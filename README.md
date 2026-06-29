# Netflix Content Strategy: Power BI Dashboard & Unsupervised Machine Learning

> **Power BI + R project** analysing Netflix content using association rule mining (Apriori) and interactive Power BI dashboards to uncover content patterns and provide strategic recommendations for a business audience.

---

## Business Problem

What content patterns drive Netflix's catalogue decisions? This project analyses Netflix content data integrated with IMDB ratings to answer:

- What genres, ratings, and cast sizes co-occur most frequently in Netflix content?
- Are there hidden association patterns between content attributes that Netflix can leverage?
- How does content structure differ between TV Shows and Movies?
- What strategic recommendations can guide Netflix's content acquisition decisions?

---

## Datasets

| Dataset | Source | Description |
|---|---|---|
| Netflix Content | BUSINFO 703 course dataset | Titles, genres, cast, directors, ratings, countries |
| IMDB Ratings | External — IMDB | Viewer ratings and popularity scores |

**Engineered features:**
- `Cast Size` — number of cast members per title
- `Director Number` — number of directors per title
- `Genre Number` — number of genres per title
- `genre_*` — boolean flags for each genre category
- `rating_clean` — standardised content rating

---

## Tools Used

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)

**Power BI:** Data ingestion, Power Query transformations, interactive dashboards, data storytelling

**R Libraries:**
- `arules` + `arulesViz` — Apriori association rule mining
- `ggplot2` + `GGally` — visualisation
- `cluster` — silhouette scoring
- `tidyverse`, `dplyr`, `tidyr`, `readr` — data wrangling
- `corrplot` — correlation analysis

---

## Methodology

### Power BI — Data Preparation
- Loaded Netflix CSV and IMDB data into Power BI Desktop
- Applied transformations in Power Query (renamed steps for business clarity)
- Engineered genre boolean columns, cast size, director count
- Cleaned and standardised content ratings (`rating_clean`)
- Exported cleaned data (`1_2_Netflix_ML.csv`) for R ML pipeline

### R — Unsupervised Machine Learning (Apriori Algorithm)

**Why Apriori?**
Association rule mining finds hidden co-occurrence patterns between content attributes — ideal for understanding what combinations of genre, rating, cast size, and director count appear together most often.

**Parameters used:**
- Minimum support: **5%** (optimised through experimentation)
- Minimum confidence: **60%** (keeps rules clean and interpretable)

**Separate models built for:**
- TV Shows — top 25 rules by lift
- Movies — top 15 rules by lift

**Visualisations produced:**
- Network graph of association rules (coloured by lift strength)
- Item frequency plots — top 15 most frequent content attributes

---

## Key Outputs

### Association Rules
Rules were ranked by **lift** — the higher the lift, the stronger the non-random association between content attributes.

**TV Shows:** Top 25 rules revealed strong co-occurrence patterns between specific genres, ratings, and cast configurations

**Movies:** Top 15 rules highlighted genre combinations and rating patterns most common in Netflix's movie catalogue

### Power BI Dashboard
Multi-page interactive report covering:
- Content overview by type, country, and genre
- Rating distribution analysis
- Genre co-occurrence patterns
- IMDB integration insights
- Strategic content recommendations

---

## Repository Structure

```
.
├── Unsupervised_Machine_Learning_Group_10.R   # R code — Apriori ML analysis
├── Group_10_FINAL.pbix                        # Power BI dashboard file
└── README.md
```

---

## How To Run

**Power BI Dashboard:**
1. Open `Group_10_FINAL.pbix` in **Power BI Desktop** (free download from Microsoft)
2. Navigate through report pages using the bottom tabs
3. Use slicers and filters for interactive exploration

**R Analysis:**
1. Open `Unsupervised_Machine_Learning_Group_10.R` in **RStudio**
2. Place `1_2_Netflix_ML.csv` (exported from Power BI) in the same directory
3. Run all — packages install automatically on first run
4. Association rule network graphs and frequency plots will render

---

## Academic Context

- **Course:** BUSINFO 703 — Data Visualisation for Business, University of Auckland
- **Semester:** Q3 2025
- **Role:** Unsupervised machine learning (Apriori implementation), R visualisations, Power BI dashboard development

---

*Project by Sai Krishna Sudarsan | Master of Business Analytics, University of Auckland*
