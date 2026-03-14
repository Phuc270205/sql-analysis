/*

Queries used for Tableau Project

*/

-- 1. 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(new_deaths)*1.0/SUM(NULLIF(new_cases, 0))*100 as DeathPercentage
From SQL_Project..Covid19Death
where continent is not null 
order by 1,2


-- 2. 

Select country, SUM(cast(new_deaths as int)) as TotalDeathCount
From SQL_Project..Covid19Death
Where continent is null 
and country in ('Europe', 'North America', 'Asia', 'South America', 'Africa', 'Oceania')
Group by country
order by TotalDeathCount desc


-- 3.

Select country, Population, MAX(total_cases) as HighestInfectionCount,  MAX((CAST(total_cases AS FLOAT)/population))*100 as PercentPopulationInfected
From SQL_Project..Covid19Death
Group by country, Population
order by PercentPopulationInfected desc


-- 4.


Select country, Population,date, MAX(total_cases) as HighestInfectionCount,  MAX((CAST(total_cases AS FLOAT)/population))*100 as PercentPopulationInfected
From SQL_Project..Covid19Death
Group by country, Population, date
order by PercentPopulationInfected desc

