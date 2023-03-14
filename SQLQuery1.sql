use Project;

select * from dbo.coviddeaths$;

select * from dbo.covidvaccinations$;

-- total cases vs total population
-- shows likelihood if you get contact with covid

select location, date,total_cases, total_deaths,(cast(total_deaths as int)/total_cases)*100 as death_percent 
from coviddeaths$
where location like 'india'
order by 1,2;


-- looking at total cases vs population
-- shows what percentage got covid

select location, date, total_cases, population, (cast(total_cases as int)/population)*100 as covid_percentage
from coviddeaths$
-- where location like 'india'
order by covid_percentage desc;


-- which country has highest infection rate compare to population


select location,population, max(total_cases) as highest_infection_count, (max(total_cases/population))*100 as percent_population_infected
from coviddeaths$
--where location like 'india'
group by location, population
order by percent_population_infected desc;

-- this showing countries with the highest death count for population

select location,population, max(total_deaths) as highest_death_count
from coviddeaths$
--where location like 'india'
group by location, population
order by highest_death_count desc;

-- lets break thing by continent

select distinct(continent), max(total_deaths) as highest_death_count
from coviddeaths$
where continent is not null
group by continent
order by highest_death_count desc;


-- lets break things by location

select distinct(location), max(total_deaths) as highest_death_count
from coviddeaths$
where continent is not null
group by location
order by highest_death_count desc;


-- sowing continent with highest death count


select distinct(continent), max(total_deaths) as highest_death_count
from coviddeaths$
where continent is not null
group by continent
order by highest_death_count desc;



-- global numbers

select sum(new_cases) total_cases, sum(cast(new_deaths as int)) total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as death_percentage
from coviddeaths$
where continent is not null
--group by date
order by 1,2;



-- looking at total population vs vaccination

select dea.continent, convert(datetime,dea.date), dea.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over(partition by dea.location order by dea.location)
as rolling_people_vaccinated
from coviddeaths$ dea
join covidvaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.location
where dea.continent is not null
order by 2,3;








