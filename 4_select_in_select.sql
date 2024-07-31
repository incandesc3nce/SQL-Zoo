/*
1.
List each country name where the population is larger than that of 'Russia'.
*/

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='russia');

/*
2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
*/

SELECT name FROM world
  WHERE continent = 'Europe' 
AND gdp/population >
     (SELECT gdp/population FROM world
      WHERE name='United Kingdom');

/*
3.

List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
*/

SELECT name, continent 
FROM world
WHERE continent IN (
SELECT continent 
FROM world
WHERE name = 'Argentina' 
OR name = 'Australia');

/*
4.
Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
*/

SELECT name, population 
FROM world
WHERE population > 
(SELECT population FROM world
WHERE name = 'United Kingdom')
AND population < 
(SELECT population FROM world
WHERE name = 'Germany');

/*
5.
Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
*/

SELECT 
name, 
concat(ROUND(population/(SELECT population 
FROM world WHERE name = 'Germany') * 100, 0), '%')
AS percentage
FROM world
WHERE continent = 'Europe';

/*
6.
Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
*/

SELECT name FROM world
WHERE gdp > ALL
(SELECT gdp FROM world
WHERE continent = 'Europe'
AND gdp IS NOT NULL);

/*
7.
Find the largest country (by area) in each continent, show the continent, the name and the area:

The above example is known as a correlated or synchronized sub-query.
*/

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent = x.continent
          AND area>0)

/*
8.
List each continent and the name of the country that comes first alphabetically.
*/

SELECT continent, name FROM world x
WHERE name = (
SELECT name FROM world y
WHERE y.continent = x.continent
ORDER BY name ASC LIMIT 1);

/*
9.
Find the continents where all countries have a population <= 25000000. 
Then find the names of the countries associated with these continents. Show name, continent and population.
*/

--- ??? possibly bugged as answer query returns 0 rows

/*
10.
Some countries have populations more than three times that of any country in their continent. 
Give the countries and continents.
*/

SELECT name, continent
FROM world x
WHERE population > ALL
(SELECT population*3 FROM world y
WHERE x.continent = y.continent
AND x.name <> y.name);