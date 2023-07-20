--JOIN
SELECT * FROM `my-project-mike-384607.Employee_data.employees` LIMIT 1000

--INNER JOIN
SELECT
    employees.name AS employee_name,
    employees.role AS employee_role,
    employees.department_id AS department_id
FROM 
   Employee_data.employees
INNER JOIN
  Employee_data.departments ON
  employees.department_id = departments.department_id

--LEFT JOIN
SELECT
    employees.name AS employee_name,
    employees.role AS employee_role,
    departments.name AS department_name
FROM 
   Employee_data.employees
LEFT JOIN 
  Employee_data.departments ON
  employees.department_id = departments.department_id

--RIGHT JOIN
SELECT
    employees.name AS employee_name,
    employees.role AS employee_role,
    departments.name AS department_name
FROM 
   Employee_data.employees
RIGHT JOIN 
  Employee_data.departments ON
  employees.department_id = departments.department_id


--FULL OUTER JOIN
SELECT
    employees.name AS employee_name,
    employees.role AS employee_role,
    departments.name AS department_name
FROM 
   Employee_data.employees
FULL OUTER JOIN 
  Employee_data.departments ON
  employees.department_id = departments.department_id

--

--so what are we getting in output
SELECT 
    `bigquery-public-data.world_bank_intl_education.international_education`.country_name, 
    `bigquery-public-data.world_bank_intl_education.country_summary`.country_code, 
    `bigquery-public-data.world_bank_intl_education.international_education`.value
FROM --from where 
    `bigquery-public-data.world_bank_intl_education.international_education`
INNER JOIN --inner join part ( explaining parameters)
    `bigquery-public-data.world_bank_intl_education.country_summary` 
ON `bigquery-public-data.world_bank_intl_education.country_summary`.country_code = `bigquery-public-data.world_bank_intl_education.international_education`.country_code

--using alias instead of loooong names of columns
SELECT 
    edu.country_name,
    summary.country_code,
    edu.value
FROM 
    `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN 
    `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code

--
SELECT 
    AVG(edu.value) average_value, summary.region
FROM 
    `bigquery-public-data.world_bank_intl_education.international_education` AS edu
INNER JOIN 
    `bigquery-public-data.world_bank_intl_education.country_summary` AS summary
ON edu.country_code = summary.country_code
WHERE summary.region IS NOT null
GROUP BY summary.region
ORDER BY average_value DESC

--
SELECT --what we want to get out of the data?
 seasons.market AS university,
 seasons.name AS team_name,
 seasons.wins,
 seasons.losses,
 seasons.ties,
 mascots.mascot AS team_mascot
FROM   --what we gonna connect 
 `bigquery-public-data.ncaa_basketball.mbb_historical_teams_seasons` AS seasons
INNER JOIN   --with what we gonna connect
 `bigquery-public-data.ncaa_basketball.mascots` AS mascots
ON  --based on what data? 
 seasons.team_id = mascots.id
WHERE  --how do we want to organize our data
 seasons.season = 1984
 AND seasons.division = 1
ORDER BY
 seasons.market