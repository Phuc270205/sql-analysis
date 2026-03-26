# Global COVID-19 SQL Analysis and Tableau Dashboard

## Overview
This project explores global COVID-19 data using **SQL Server** and presents key insights through an interactive **Tableau dashboard**.

The analysis focuses on:
- global case and death totals
- death counts by continent
- infection trends across selected countries
- vaccination progress across selected countries
- country-level comparisons using a world map

This project demonstrates an end-to-end analytics workflow: querying raw data in SQL, preparing visualization-ready outputs, and building an interactive dashboard in Tableau Public.

---

## Project Objectives
The main goals of this project were to answer questions such as:

- What are the total global COVID-19 case and death counts?
- What is the global death percentage?
- Which countries had the highest infection rates relative to population?
- Which continents recorded the highest total deaths?
- How did infection trends change over time in selected countries?
- How did vaccination progress differ across countries?
- How can SQL be used to prepare cleaner data for Tableau visualizations?

---

## Tools Used
- **SQL Server** — data exploration, joins, aggregations, window functions, and data preparation
- **Tableau Public** — dashboard design and interactive visualization
- **Excel** — source file handling and Tableau preparation

---

## Datasets
This project uses two main tables I created from the raw data: `Covid raw data.csv`

- `Covid19Death`
- `Covid19Vaccination`

These datasets contain fields such as:
- country
- continent
- date
- population
- total cases
- new cases
- total deaths
- new deaths
- new vaccinations

---

## SQL Skills Demonstrated
This project highlights the following SQL skills:

- `SELECT`, `WHERE`, `ORDER BY`
- filtering by country and continent
- aggregate functions such as `SUM()` and `MAX()`
- percentage calculations with `CAST()` and `NULLIF()`
- joins between death and vaccination datasets
- window functions using `SUM() OVER (...)`
- `LAG()` to compare current and previous vaccination percentages
- Common Table Expressions (CTEs)
- temporary tables
- view creation
- handling missing values with `ISNULL()`

---

## Analysis Performed

### 1. Total Cases vs Total Deaths
Calculated death percentage for a selected country using:

- total cases
- total deaths
- death percentage = total deaths / total cases × 100

This helps estimate the severity of COVID-19 over time in a specific country.

### 2. Total Cases vs Population
Calculated the percentage of the population infected over time using:

- total cases
- population
- percent population infected = total cases / population × 100

### 3. Countries with Highest Infection Rate
Identified countries with the highest recorded infection rate relative to their population using:

- `MAX(total_cases)`
- infection percentage compared to population

### 4. Countries with Highest Death Count
Calculated the highest total death count by country using grouped aggregation.

### 5. Global Death Percentage by Date
Aggregated global new cases and new deaths by date and calculated:

- daily global total cases
- daily global total deaths
- daily global death percentage

### 6. Population vs Vaccinations
Joined deaths and vaccination datasets on:

- `country`
- `date`

Then used a window function to calculate cumulative vaccinations over time:

- `SUM(new_vaccinations) OVER (PARTITION BY country ORDER BY date)`

### 7. Vaccination Percentage Calculation
Used a CTE to calculate cumulative vaccination progress relative to population.

### 8. Temporary Table and View Creation
Used:
- a **temporary table** for intermediate vaccination analysis
- a **view** to store vaccination data for later visualization and reuse

### 9. Tableau-Ready Vaccination Data
To make the Tableau chart cleaner, I used:

- `ISNULL()` to replace missing vaccination values with zero
- `LAG()` to compare each vaccination percentage with the previous percentage for the same country

Then I kept only rows where the vaccination percentage changed.  
This reduced repeated unchanged rows and made the Tableau vaccination line chart more efficient and readable.

---

## Dashboard Features
The Tableau dashboard includes the following components:

### Global Numbers
Top KPI cards showing:
- **Total Cases**
- **Total Deaths**
- **Death Percentage**

### Total Deaths Per Continent
A bar chart comparing total death counts across continents.

### Percent Population Infected Per Country
A world map showing country-level infection impact relative to population.

### Percent Population Infected
A multi-country trend chart comparing infection progression over time for selected countries.

### Percent Population Vaccinated
A multi-country line chart comparing cumulative vaccination progress over time for selected countries.

Selected countries shown in the dashboard include:
- China
- India
- Mexico
- United Kingdom
- United States
- Vietnam

---

## Tableau Dashboard
The SQL outputs from this project were used to build an interactive Tableau dashboard.

**Interactive Dashboard:**  
[View the Tableau Dashboard](https://public.tableau.com/views/CovidDashboard_17731492056500/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

