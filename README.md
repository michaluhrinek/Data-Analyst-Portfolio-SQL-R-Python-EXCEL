# SQL-Projects
My SQL Portfolio Projects
1.Project is Analyzing Covid Cases from real world data in a real-time. 
The first SQL code selects all columns from the "covid_deaths" table, located in the schema "mike_sql", where the continent is not null, and orders the result set first by the third column and then by the fourth column.

The second SQL code selects the "location", "date", "total_cases", "new_cases", "total_deaths", and "population" columns from the "covid_deaths" table, located in the schema "mike_sql", and orders the result set first by the third column and then by the fourth column.

The third SQL code calculates the total number of cases and deaths, as well as the death percentage, by dividing the total number of deaths by the total number of cases multiplied by 100, for all records in the "covid_deaths" table, located in the schema "mike_sql".

The fourth SQL code creates a backup of the "covid_deaths" table and then alters the data type of the "total_cases" and "total_deaths" columns to integer. It then updates the "total_cases" and "total_deaths" columns by casting the existing data to integer. Finally, it selects the top 10 records from the updated "covid_deaths" table to verify the changes.

The fifth SQL code calculates the death percentage for each country/state in the "covid_deaths" table, located in the schema "mike_sql", where the location contains the word "states". It orders the result set first by the location column and then by the date column.

The sixth SQL code calculates the death percentage for each country in the "covid_deaths" table, located in the schema "mike_sql", and orders the result set first by the location column and then by the date column.

The seventh SQL code selects the country, date, and death percentage columns from the "covid_deaths" table, located in the schema "mike_sql", and only returns the record with the highest death percentage for each country.

The eighth SQL code calculates the percentage of cases from the population for each country in the "covid_deaths" table, located in the schema "mike_sql", and orders the result set first by the location column and then by the date column.

The ninth SQL code selects the country, date, and total cases columns from the "covid_deaths" table, located in the schema "mike_sql", and only returns the record with the highest total cases for each country. It orders the result set by country name in ascending order.

The tenth SQL code creates a new table called "population_table" with distinct country names and population values from the "covid_deaths" table, located in the schema "mike_sql", where the population column is not null.

The eleventh SQL code calculates the infection rate for each country in the "covid_deaths" table, located in the schema "mike_sql", by dividing the total number of cases by the population for that country. It then orders the result set by the infection rate in descending order.

The twelfth SQL code calculates the highest infection rate for each country in the "covid_deaths" table, located in the schema "mike_sql", and orders the result set by the highest infection rate in descending order.
