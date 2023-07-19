create table Kids (
Id  Int Identity (1,1)
,[First Name] varchar(100)
,[Last Name]  varchar(100)
,[Birth Date]  datetime
)

create table Toys (
Id  Int Identity (1,1)
,[Kid Id]  Int
,[Name] varchar(100)
,[Colour]  varchar(100)
)

delete from Kids
delete from Toys

INSERT INTO Kids ([First Name],[Last Name],[Birth Date])
Values
('Sam','Small',DATEADD(Month,- floor(rand() * 120),GetDate()))
,('Annie',null,'20180527')
,('Dave','Drei','20140325')
,('Ivan','Ivanov','20150517')
,('Brenda','Simon','20160315')
,('Samantha','Fox','20190715')
,('Diana','Ros','20160918')
,('Michael','Buble','20190410')
,('Bilbo','Baggins','20200125')
,('Rox','Mirers','20130411')
,('Frodo','Baggins','20150313')
,('Riana','Wober','20161115')
,('Marta',null,'20121230')

INSERT INTO Toys ([Kid Id],[Name],[Colour])
Values
('1','car','blue')
,('1','ball','red')
,('1','doll','blue')
,('2','truck','green')
,('2','car','red')
,('2','ball','green')
,('2','doll','blue')
,('3','car','green')
,('4','doll','red')
,('4','ball','blue')
,('5','ball','green')
,('6','truck','blue')
,('6','truck','red')
,('7','car','green')
,('2','car','green')
,('1','ball','blue')
,('1','car','red')
,('8','ball',null)



/*
Select full name (in one cell), Birth Date of all kids 3 years old and above
expected column list: Full Name( ex. "Sam Small"), Birth Date (ex. "2021-08-18" )

Select all kids who have more than 2 blue toys
expected column list: Full Name( ex. "Sam Small"), Number of Blue Toys

Select all kids under 5 years of age who have more than 1 toy
expected column list: Full Name( ex. "Sam Small"), Birth Date  (ex. "2021-08-18" ), Number of Toys

Select all kids with no toys at all
expected column list: Full Name( ex. "Sam Small")

Select all kids having birthday in April
expected column list: Full Name( ex. "Sam Small"), Birth Date  (ex. "2021-08-18" )

Select all the kids with the highest number of toys (if more than one show all of them)
expected column list: Kid id, Full Name( ex. "Sam Small"), Number of toys

Select all kids ordered by toy count if two kids has same number of toys their names should be in one cell separated by comma
we need just an idea how this could be achieved (don't spent much time on this will be discussed)
*/

/*1 */
SELECT CONCAT(k.[First Name],' ', k.[Last Name]) 'Full Name', CAST(k.[Birth Date] AS DATE) 'Birth Date' FROM Kids k WHERE  k.[Birth Date] <= DATEADD(year,-3,GETDATE())

/*2 */
SELECT CONCAT(k.[First Name],' ', k.[Last Name]) 'Full Name', COUNT(t.Colour) 'Number of Blue Toys' FROM Kids k INNER JOIN Toys t ON k.[Id] = t.[Kid Id] and t.Colour = 'blue'
GROUP BY k.[First Name], k.[Last Name]

/*3 */
SELECT CONCAT(k.[First Name],' ', k.[Last Name]) 'Full Name', CAST(k.[Birth Date] AS DATE) 'Birth Date', COUNT(t.Id) 'Number of Toys' FROM Kids k INNER JOIN Toys t ON k.[Id] = t.[Kid Id]
AND k.[Birth Date] <= DATEADD(year,-4,GETDATE())
GROUP BY k.[First Name], k.[Last Name], k.[Birth Date]
HAVING COUNT(t.Id) > 1

/*4 */
SELECT CONCAT(k.[First Name],' ', k.[Last Name]) 'Full Name' FROM Kids k INNER JOIN Toys t ON k.[Id] = t.[Kid Id]
GROUP BY k.[First Name], k.[Last Name]
HAVING COUNT(t.Id) = 0

/*5 */
SELECT CONCAT(k.[First Name],' ', k.[Last Name]) 'Full Name', CAST(k.[Birth Date] AS DATE) 'Birth Date' FROM Kids k WHERE MONTH(k.[Birth Date]) = 4

/*6 */
SELECT CONCAT(k.[First Name],' ', k.[Last Name]) 'Full Name', COUNT(t.Id) 'Number of Toys' FROM Kids k INNER JOIN Toys t ON k.[Id] = t.[Kid Id]
GROUP BY k.[First Name], k.[Last Name]
HAVING COUNT(t.Id) >= ALL(SELECT count(t.Id) FROM Kids k INNER JOIN Toys t ON k.[Id] = t.[Kid Id] GROUP BY k.[Id])





