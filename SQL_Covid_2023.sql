Select *
From mike_sql..covid_deaths
where continent is not null
order by 3,4


-- Select data that we are going to use
Select location, date, total_cases, new_cases, total_deaths, population
From mike_sql..covid_deaths
order by 3,4


--Total cases, death
SELECT SUM(CAST(COALESCE(total_cases, 0) AS bigint)) AS total_cases, SUM(CAST(COALESCE(total_deaths, 0) AS bigint)) AS total_deaths, (SUM(CAST(COALESCE(total_deaths, 0) AS bigint))/SUM(CAST(COALESCE(total_cases, 0) AS bigint)))*100 AS DeathPercentage
FROM mike_sql..covid_deaths;

-- First, create a backup of the original table
SELECT * INTO covid_deaths_backup FROM covid_deaths;

-- Alter the table to convert the columns to int format
ALTER TABLE covid_deaths
ALTER COLUMN total_cases INT;

ALTER TABLE covid_deaths
ALTER COLUMN total_deaths INT;

-- Update the table to cast the existing data to int format
UPDATE covid_deaths
SET total_cases = CAST(total_cases AS INT),
    total_deaths = CAST(total_deaths AS INT);

-- Verify the changes
SELECT TOP 10 total_cases, total_deaths
FROM covid_deaths;


--calculate % per country/ states
SELECT location, date, total_cases, total_deaths, 
       CAST((total_deaths*100.0/NULLIF(total_cases, 0)) AS FLOAT) AS DeathPercentage
FROM covid_deaths
where location like '%states%'
order by 1,2

--calculate % per country
-- shows likelyhood of dying if you get in contact with covid-19
SELECT location, date, total_cases, total_deaths, 
       CAST((total_deaths*100.0/NULLIF(total_cases, 0)) AS FLOAT) AS DeathPercentage
FROM covid_deaths
order by 1,2

--highest % of deaths in each country
--To get the highest percentage in each country, you can use the PARTITION BY clause in a ROW_NUMBER() 
--function to rank the records within each country by descending DeathPercentage, and then select only the records with a rank of 1.
SELECT country, date, DeathPercentage
FROM (
  SELECT location AS country, date, 
         CAST((total_deaths*100.0/NULLIF(total_cases, 0)) AS FLOAT) AS DeathPercentage,
         ROW_NUMBER() OVER (PARTITION BY location ORDER BY CAST((total_deaths*100.0/NULLIF(total_cases, 0)) AS FLOAT) DESC) AS rn
  FROM covid_deaths
) t
WHERE rn = 1;

--Total cases vs. population 
--shows what % of population has got covid
SELECT location, date, total_cases, population, 
       CAST((total_cases*100.0/NULLIF(population, 0)) AS FLOAT) AS Percentage_of_cases_from_population
FROM covid_deaths
order by 1,2


--Looking at countries with highest infection rate / total cases

--This is the main SELECT statement that selects the columns we want to display in the final result. In this case, we are selecting country, date, and total_cases.
--This is a subquery that uses the ROW_NUMBER() function to assign a row number to each record for each country based on the total_cases column in
--descending order. The PARTITION BY clause divides the data into partitions for each location or country, and the ORDER BY clause sorts the data within each partition by 
--total_cases in descending order.
--This WHERE clause filters the result set to only include the rows where the row number (rn) is equal to 1. This ensures that we only select the record with
--the highest total_cases for each country.
--Finally, this ORDER BY clause sorts the result set by the country column in ascending order. This sorts the results alphabetically by country name, 
--so you can easily see the highest total_cases for each country.
--The subquery also renames the location column as country to match the main SELECT statement.

SELECT country, date, total_cases
FROM (
  SELECT location AS country, date, total_cases,
         ROW_NUMBER() OVER (PARTITION BY location ORDER BY total_cases DESC) AS rn
  FROM covid_deaths
) t
WHERE rn = 1
ORDER BY country ASC;

-- ***************************************************************
SELECT DISTINCT location AS country, population
INTO population_table
FROM mike_sql..covid_deaths
WHERE population IS NOT NULL;


--Countries with highest infection rate per population in country 
SELECT 
  c.location AS country, 
  c.date, 
  c.total_cases,
  CAST(c.total_cases AS FLOAT) / p.population AS infection_rate
FROM 
  covid_deaths c
  JOIN population_table p ON c.location = p.country
WHERE 
  c.total_cases > 0
ORDER BY 
  infection_rate DESC;

-- *************************************************************************************
SELECT 
  c.location AS country, 
  MAX(CAST(c.total_cases AS FLOAT) / p.population)* 100 AS highest_infection_rate
FROM 
  covid_deaths c
  JOIN population_table p ON c.location = p.country
WHERE 
  c.total_cases > 0
GROUP BY 
  c.location
ORDER BY 
  highest_infection_rate DESC;
--***************************Do it other way
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From mike_sql..covid_deaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


-- Showing the countries with highest death count per population
Select Location, MAX(CAST(total_deaths as int)) as Totaldeathcount
From mike_sql..covid_deaths
--Where location like '%states%'
where continent is not null
Group by Location
order by Totaldeathcount desc

-- Showing the countries with highest death count per continent
Select location, MAX(CAST(total_deaths as int)) as Totaldeathcount
From mike_sql..covid_deaths
--Where location like '%states%'
where continent is null
Group by location
order by Totaldeathcount desc

--Continent with the highest deathcount
Select continent, MAX(CAST(total_deaths as int)) as Totaldeathcount
From mike_sql..covid_deaths
--Where location like '%states%'
where continent is not null
Group by continent
order by Totaldeathcount desc


--GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From mike_sql..covid_deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
    SUM(CONVERT(BIGINT, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM mike_sql..covid_deaths dea
JOIN mike_sql..covid_vacination vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL 
ORDER BY 2, 3


-- Using CTE to perform Calculation on Partition By in previous query
--This is SQL code that defines a Common Table Expression (CTE) named "PopvsVac", which selects data from two tables named "CovidDeaths" 
--and "CovidVaccinations" in a database named "PortfolioProject". The CTE selects columns for continent, location, date, population, 
--new_vaccinations, and calculates a rolling total of new_vaccinations per location using the window function SUM with the OVER clause.

--The CTE also has a commented out line that calculates the percentage of the population that has been vaccinated so far. The code then
--selects all columns from the CTE and adds a new column that calculates the percentage of the population that has been vaccinated so far.

--Overall, the code is likely being used to analyze COVID-19 vaccination rates by location and date in the PortfolioProject database.


With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, CAST(SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) AS bigint) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From mike_sql..covid_deaths dea
Join mike_sql..covid_vacination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac

--TABLE 
--This script creates a temporary table named #PercentPopulationVaccinated with columns Continent, Location, Date, Population, 
--New_vaccinations, and RollingPeopleVaccinated.
--Then, it populates the table by performing a SELECT statement that joins two tables, mike_sql..covid_deaths and mike_sql..covid_vacination, 
--on location and date columns, and selects the relevant columns including a calculated column RollingPeopleVaccinated. The SUM(CONVERT(BIGINT, 
--ISNULL(vac.new_vaccinations, 0))) function calculates the rolling sum of new vaccinations for each location by converting new_vaccinations to 
--BIGINT and replacing NULL values with 0.
--Finally, the SELECT statement retrieves all columns from the #PercentPopulationVaccinated table and calculates the percentage of population
--vaccinated by dividing RollingPeopleVaccinated by Population and multiplying by 100. The CAST(RollingPeopleVaccinated AS DECIMAL(18,2)) and 
--CAST(Population AS DECIMAL(18,2)) functions are used to convert the integer values to decimal values with two decimal places for more accurate calculations.
--DROP TABLE IF EXISTS #PercentPopulationVaccinated

CREATE TABLE #PercentPopulationVaccinated (
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population BIGINT,
    New_vaccinations BIGINT,
    RollingPeopleVaccinated BIGINT
)

INSERT INTO #PercentPopulationVaccinated
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CONVERT(BIGINT, ISNULL(vac.new_vaccinations, 0))) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM 
    mike_sql..covid_deaths dea
    JOIN mike_sql..covid_vacination vac
        ON dea.location = vac.location
        AND dea.date = vac.date
WHERE 
    dea.continent IS NOT NULL 

SELECT 
    *,
    CAST(RollingPeopleVaccinated AS DECIMAL(18,2))/CAST(Population AS DECIMAL(18,2)) * 100 AS PercentPopulationVaccinated
FROM 
    #PercentPopulationVaccinated

--CREATE VIES

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From mike_sql..covid_deaths dea
Join mike_sql..covid_vacination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

Select * 
From PercentPopulationVaccinated