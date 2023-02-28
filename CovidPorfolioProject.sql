select location 
from PortfolioProject..CovidDeaths
group by location

--looking at total cases vs population

select location, date, total_cases, population,(total_cases/population)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
order by 1,2

--countries with highest death count

select location ,max(cast (total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc

--countries with highest Infection rate

select location ,max(cast (total_cases as int)) as TotalCases
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalCases desc

--deathcount by continent
select continent ,max(cast (total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

select sum(new_cases) as totalcases, sum(cast(new_deaths as int)) as totalDeaths, 
sum(cast(new_deaths as int))/sum(new_cases) as deathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by 1,2

--people vaccinated
select cd.continent,cd.date, cd.location,cd.population,cv.new_vaccinations
from PortfolioProject..CovidDeaths cd
join
PortfolioProject..CovidVaccinations cv on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null and new_vaccinations is not null
order by 2,3

--create view for visualization

create view PeopleVaccinated as
select cd.continent,cd.date, cd.location,cd.population,cv.new_vaccinations
from PortfolioProject..CovidDeaths cd
join
PortfolioProject..CovidVaccinations cv on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null and new_vaccinations is not null
--order by 2,3
select * from PeopleVaccinated