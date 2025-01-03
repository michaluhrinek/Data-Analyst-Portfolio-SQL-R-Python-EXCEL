SQL For Data Science 

SQL_for_DataScience/Module3_Practice_Quiz
@brianchiang-tw
brianchiang-tw Complete all quiz and assignment
Latest commit 49fa952 Jun 23, 2019
History
1 contributor
214 lines (168 sloc) 5.85 KB
All of the questions in this quiz pull from the open source Chinook Database. 
Please refer to the ER Diagram below and familiarize yourself with the table and column names 
to write accurate queries and get the appropriate answers.

ER Diagram:
https://d3c33hcgiwev3.cloudfront.net/imageAssetProxy.v1/UAPENoOVEei4RQ5L9j9nDA_5042a1f0839511e8beb2b5b4ae9fa29a_ER-Diagram.png?expiry=1558483200000&hmac=k7gyCaOBjcUmi1TtJjmX7CI8rVNuRhJPiTDnOuLf7wQ


#_1.

Q:
How many albums does the artist Led Zeppelin have?

A:
14

SQL Query:

SELECT Name, COUNT(Title)
FROM artists
LEFT JOIN albums
ON artists.ArtistId = albums.ArtistId
WHERE artists.Name='Led Zeppelin'


SQL Output:

+--------------+--------------+
| Name         | COUNT(Title) |
+--------------+--------------+
| Led Zeppelin |           14 |
+--------------+--------------+



#_2

Q:
Create a list of album titles and the unit prices for the artist "Audioslave".

A:
40

SQL Query:

SELECT artists.Name, Title AS [Album Titles], UnitPrice
FROM artists
LEFT JOIN albums
ON artists.ArtistId = albums.ArtistId
LEFT JOIN tracks
ON albums.AlbumId = tracks.AlbumId
WHERE artists.Name='Audioslave'

SQL Output:

+------------+--------------+-----------+
| Name       | Album Titles | UnitPrice |
+------------+--------------+-----------+
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Audioslave   |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
| Audioslave | Out Of Exile |      0.99 |
+------------+--------------+-----------+
(Output limit exceeded, 25 of 40 total rows shown)



#_3:

Q:
Find the first and last name of any customer who does not have an invoice. 
Are there any customers returned from the query?

A:
No

SQL Query:

SELECT customers.CustomerId AS cID, FirstName, LastName, COUNT(invoices.invoiceId) AS invoiceCount
FROM customers
LEFT JOIN invoices
ON customers.CustomerId = invoices.CustomerId
GROUP BY cID
ORDER BY invoiceCount ASC

SQL Output:

+-----+-----------+-------------+--------------+
| cID | FirstName | LastName    | invoiceCount |
+-----+-----------+-------------+--------------+
|  59 | Puja      | Srivastava  |            6 |
|   1 | Luís      | Gonçalves   |            7 |
|   2 | Leonie    | Köhler      |            7 |
|   3 | François  | Tremblay    |            7 |
|   4 | Bjørn     | Hansen      |            7 |
|   5 | František | Wichterlová |            7 |
|   6 | Helena    | Holý        |            7 |
|   7 | Astrid    | Gruber      |            7 |
|   8 | Daan      | Peeters     |            7 |
|   9 | Kara      | Nielsen     |            7 |
|  10 | Eduardo   | Martins     |            7 |
|  11 | Alexandre | Rocha       |            7 |
|  12 | Roberto   | Almeida     |            7 |
|  13 | Fernanda  | Ramos       |            7 |
|  14 | Mark      | Philips     |            7 |
|  15 | Jennifer  | Peterson    |            7 |
|  16 | Frank     | Harris      |            7 |
|  17 | Jack      | Smith       |            7 |
|  18 | Michelle  | Brooks      |            7 |
|  19 | Tim       | Goyer       |            7 |
|  20 | Dan       | Miller      |            7 |
|  21 | Kathy     | Chase       |            7 |
|  22 | Heather   | Leacock     |            7 |
|  23 | John      | Gordon      |            7 |
|  24 | Frank     | Ralston     |            7 |
+-----+-----------+-------------+--------------+
(Output limit exceeded, 25 of 59 total rows shown)



#_4:

Q:
Find the total price for each album.
What is the total price for the album “Big Ones”?

A:
14.85

SQL Query:

SELECT albums.AlbumId, albums.Title, SUM(tracks.UnitPrice) AS TotalPrice
FROM albums
LEFT JOIN tracks
ON albums.AlbumId = tracks.AlbumId
WHERE albums.Title ='Big Ones'

SQL Output:

+---------+----------+------------+
| AlbumId | Title    | TotalPrice |
+---------+----------+------------+
|       5 | Big Ones |      14.85 |
+---------+----------+------------+



#_5:

Q:
How many records are created 
when you apply a Cartesian join to the invoice and invoice items table?

A:
922880 

SQL Query:

SELECT invoices.InvoiceId, invoice_items.TrackId
FROM invoices CROSS JOIN invoice_items

SQL Output:

+-----------+---------+
| InvoiceId | TrackId |
+-----------+---------+
|         1 |       2 |
|         1 |       4 |
|         1 |       6 |
|         1 |       8 |
|         1 |      10 |
|         1 |      12 |
|         1 |      16 |
|         1 |      20 |
|         1 |      24 |
|         1 |      28 |
|         1 |      32 |
|         1 |      36 |
|         1 |      42 |
|         1 |      48 |
|         1 |      54 |
|         1 |      60 |
|         1 |      66 |
|         1 |      72 |
|         1 |      78 |
|         1 |      84 |
|         1 |      90 |
|         1 |      99 |
|         1 |     108 |
|         1 |     117 |
|         1 |     126 |
+-----------+---------+
(Output limit exceeded, 25 of 922880 total rows shown)
Footer
© 2022 GitHub, Inc.
Footer navigation

    Terms
    Privacy
    Security
    Status
    Docs
    Contact GitHub
    Pricing
    API
    Training
    Blog
    About

