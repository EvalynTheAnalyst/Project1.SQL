--SELECT *
--FROM project.dbo.CovidVaccinations
--ORDER BY 3,4

--SELECT *
--FROM project.dbo.CovidDeaths
--ORDER BY 3,4

--#Total cases vs Total Deaths

--Likehood of dying if you contract covid
--Select location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPerCases
--From project..CovidDeaths
--where location like '%Afri%'
--order by 1,2

--totalcases vs Population
--Select  location,total_cases,population, (total_cases/population)*100 as CasesPertotalPopulation
--from project..CovidDeaths
--where location like '%Afri%'

-----#Countries with highest infection rate compared to population

--Select location,population,max(total_cases)as HighestInfectionCount,
--Max(total_cases/population)*100 as PercentPopulationInfected
--from project..CovidDeaths
--group by location, population 
--order by PercentPopulationInfected desc

--Showing countries with the highest deathrate per population

--Select location,population,max(cast(total_deaths as int))as DeathRatePerPopulation
--from project..CovidDeaths
--where continent is  null
--group by location, population 
--order by DeathRatePerPopulation desc

--Select location,population,max(cast(total_deaths as int))as DeathRatePerPopulation
--from project..CovidDeaths
--where continent is not  null
--group by location, population 
--order by DeathRatePerPopulation desc

--Showing continent with highest death count
Select location, max(total_deaths)as TotalDeathCount
from project..CovidDeaths
where continent is  null
group by location
order by TotalDeathCount desc


--#GLOBAL NUMBER
Select SUM(cast(new_cases as int))as TotalCases,
SUM(cast(new_deaths as int))as TotalDeaths,
(sum(cast(new_deaths as int)))/(sum(new_cases))*100 as DeathPercentage
--total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentages
From project..CovidDeaths
where continent is not null
--Group by date
order by 1,2


Select *
From project..CovidDeaths as cde
join project..CovidVaccinations as cva
on cde.location = cva.location
and cde.date = cva.date

--Totalpopulation vs vacination

Select cde.continent,cde.location,cde.date,cde.population,
cva.new_vaccinations,sum(convert(bigint,cva.new_vaccinations))
over (Partition by cde.location order by 
cde.location,cde.date) 
From project..CovidDeaths as cde
join project..CovidVaccinations as cva
on cde.location =cva.location
and cde.date = cde.date
where cde.continent is not null
order by 2,3

with PopvsVac(Continent, Location, Date, Population,New_vacinations,
RollingPeopleVaccination) as
(Select cde.continent,cde.location,cde.date,cde.population,
cva.new_vaccinations,sum(convert(bigint,cva.new_vaccinations))
over (Partition by cde.location order by cde.location,cde.date) as RollingPeopleVaccination
From project..CovidDeaths as cde
join project..CovidVaccinations as cva
on cde.location =cva.location
and cde.date = cde.date
where cde.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccination/Population)*100 as vaccinatedPercentage
From PopvsVac

Create View PercentagePopulationVaccination as
Select cde.continent,cde.location,cde.date,cde.population,
cva.new_vaccinations,sum(convert(bigint,cva.new_vaccinations))
over (Partition by cde.location order by cde.location,cde.date) as RollingPeopleVaccination
From project..CovidDeaths as cde
join project..CovidVaccinations as cva
on cde.location =cva.location
and cde.date = cde.date
where cde.continent is not null
--order by 2,3









