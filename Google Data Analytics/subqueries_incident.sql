SELECT * FROM `project-id-386504.tutorial.incident_reports` WHERE DATE(_PARTITIONTIME) = "2023-05-14" LIMIT 1000

--first reports ever in this database using subquery
SELECT *
FROM tutorial.incident_reports
WHERE Date = (SELECT MIN(date)
                 FROM tutorial.incident_reports
              )
--multiple results
-- where the date is within the first five days of January 2014, as January 1-5, 2014 are the smallest dates in the table.
SELECT *
  FROM tutorial.incident_reports
 WHERE Date IN (SELECT date
                 FROM tutorial.incident_reports
                ORDER BY date
                LIMIT 5
              )

-- all crimes in Friday order by category
SELECT *
  FROM tutorial.incident_reports
 WHERE DayOfWeek = 'Friday'
 ORDER BY Category ASC

 --average incidents of each day of each month
 SELECT 
  LEFT(FORMAT_DATE('%Y-%m-%d', sub.date), 7) AS cleaned_month,
  sub.DayOfWeek,
  AVG(sub.incidents) AS average_incidents
FROM (
  SELECT 
    DayOfWeek,
    date,
    COUNT(IncidntNum) AS incidents
  FROM tutorial.incident_reports
  GROUP BY 1,2
) sub
GROUP BY 1,2
ORDER BY 1,2

--JOINING SUBQURIES, same time, same day what crimes were happening?
SELECT *
  FROM tutorial.incident_reports Incident_Code
  JOIN ( SELECT date
           FROM tutorial.incident_reports
          ORDER BY date
          LIMIT 5
       ) sub
    ON Incident_Code.date = sub.date  --incident_code.date = date from the subquery

--
--inner query can output multiple results. The following query ranks all of the results according to how many
-- incidents were reported in a given day. It does this by aggregating the total number of incidents
-- each day in the inner query, then using those values to sort the outer query
SELECT incidents .*,
       sub.incidents AS incidents_that_day
  FROM tutorial.incident_reports Incident_Code
  JOIN ( SELECT date,
          COUNT(IncidntNum) AS incidents
           FROM tutorial.incident_reports
          GROUP BY 1
       ) sub
    ON Incident_Code.date = sub.date
 ORDER BY sub.incidents DESC, time

 --fix
--fix  current rows date and which incident
 SELECT i.*,
       sub.incidents AS incidents_that_day
FROM tutorial.incident_reports i
JOIN (
  SELECT date,
         COUNT(*) AS incidents
  FROM tutorial.incident_reports
  GROUP BY 1
) sub ON i.date = sub.date
ORDER BY sub.incidents DESC, time
/* In summary, the query outputs all columns of the tutorial.incident_reports table, along with a new 
column that shows the count of incidents that occurred on the same day as the current row's date,
 sorted by the count of incidents that day and then by the time of the incident.*/

--another project:

/*to aggregate all of the companies receiving investment 
and companies acquired each month. You could do that without subqueries */ 


SELECT COALESCE(acquisitions.acquired_month, investments.funded_month) AS month,
       COUNT(DISTINCT acquisitions.company_permalink) AS companies_acquired,
       COUNT(DISTINCT investments.company_permalink) AS investments
  FROM tutorial.crunchbase_acquisitions acquisitions
  FULL JOIN tutorial.crunchbase_investments investments
    ON acquisitions.acquired_month = investments.funded_month
 GROUP BY 1
 --
 SELECT COUNT(*) FROM tutorial.crunchbase_acquisitions
 -- acquisitions and funded months investments 
SELECT COUNT(*)
FROM tutorial.crunchbase_acquisitions acquisitions
FULL JOIN tutorial.crunchbase_investments investments
        ON acquisitions.acquired_month = investments.funded_month
--
/*you could solve this much more efficiently by aggregating the two tables 
separately, then joining them together
so that the counts are performed across far smaller datasets: */

--Resource to this data https://app.mode.com/editor/michal_uhrnek/reports/cc6dc652275e/queries/f5db556bfd83
-- get month and acquisitions.companies_acquired, investments.companies_rec_investment base on month and in DESC order
SELECT COALESCE(acquisitions.month, investments.month) AS month,
       acquisitions.companies_acquired,
       investments.companies_rec_investment
  FROM (
        SELECT acquired_month AS month,
               COUNT(DISTINCT company_permalink) AS companies_acquired
          FROM tutorial.crunchbase_acquisitions
         GROUP BY 1
       ) acquisitions

  FULL JOIN (
        SELECT funded_month AS month,
               COUNT(DISTINCT company_permalink) AS companies_rec_investment
          FROM tutorial.crunchbase_investments
         GROUP BY 1
       )investments

    ON acquisitions.month = investments.month
 ORDER BY 1 DESC
 --
 -- UNION...getting all data together 
 SELECT *
  FROM tutorial.crunchbase_investments_part1

 UNION ALL

 SELECT *
   FROM tutorial.crunchbase_investments_part2
 
 
 --total rows from both tables 
SELECT COUNT(*) AS total_rows
  FROM (
        SELECT *
          FROM tutorial.crunchbase_investments_part1

         UNION ALL

        SELECT *
          FROM tutorial.crunchbase_investments_part2
       ) sub








