/********************************************************************************
*	Name			Date			Description
*
*	Tyler Hon		3/1/2019		Implementation of disk_inventoryth
*	Tyler Hon		3/8/2019		Implementation of INSERT statements (Line 86)
*	Tyler Hon		3/14/2019		Implementation of JOIN statements (Line 256)
*	Tyler Hon		3/20/2019		Implementation of Stored Procedures (Line 326)
*********************************************************************************/

USE master
GO
IF DB_ID('disk_inventoryth') IS NOT NULL
	DROP DATABASE disk_inventoryth
GO

create database disk_inventoryth
go
use disk_inventoryth
go

create table genre
	(
	genre_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table status
	(
	status_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table disk_type
	(
	disk_type_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table artist_type
	(
	artist_type_id int not null primary key identity,
	description nvarchar(100) not null
	)
go
create table borrower
	(
	borrower_id int not null primary key identity,
	fname nvarchar(100) not null,
	lname nvarchar(100) not null,
	phone_numb varchar(50) not null
	)
go
create table artist
	(
	artist_id int not null primary key identity,
	fname nvarchar(100) not null,
	lname nvarchar(100) null,
	artist_type_id int not null references artist_type(artist_type_id)
	)
go
create table disk
	(
	disk_id int not null primary key identity,
	disk_name nvarchar(100) not null,
	release_date datetime not null,
	genre_id int not null references genre(genre_id),
	status_id int not null references status(status_id),
	disk_type_id int not null references disk_type(disk_type_id)
	)
go
create table diskHasBorrower
	(
	disk_id int not null references disk(disk_id),
	borrower_id int not null references borrower(borrower_id),
	borrowed_date datetime not null,
	returned_date datetime null,
	primary key (disk_id, borrower_id, borrowed_date)
	)
go
create table diskHasArtist
	(
	disk_id int not null references disk(disk_id),
	artist_id int not null references artist(artist_id),
	primary key (disk_id, artist_id)
	)
go

----- Project 3 Documentation, INSERT statements -----

Insert into [dbo].[genre]	
			([description])
		values
			('Rap')
			,('Rock')
			,('Jazz')
			,('Country')
go

Insert into [dbo].[status]
			([description])
		values
			('Damaged')
			,('Available')
			,('On hold')
go

Insert into [dbo].[disk_type]
			([description])
		values
			('CD')
			,('DVD')
			,('Vinyl')
			,('Cassette')
go

Insert into [dbo].[artist_type]
			([description])
		values
			('Solo')
			,('Band')
go

Insert into [dbo].[borrower]
			([fname], [lname], [phone_numb])
		values
			('Dan', 'Smith', '1112223333')
			,('Billy', 'McDonald', '1234567891')
			,('Mary', 'Lee', '1223324567')
			,('Jake', 'Statefarm', '1111111111')
			,('Bob', 'Ross', '2222222222')
			,('Stan', 'Lee', '3333333333')
			,('Donald', 'Duck', '4444444444')
			,('Winnie', 'Pooh', '5555555555')
			,('Tigger', 'Tiger', '5555555555')
			,('Iron', 'Man', '6666666666')
			,('Bill', 'Gates', '7777777777')
			,('Jeff', 'Bezos', '8888888888')
			,('Elon', 'Musk', '9999999999')
			,('Donald', 'Trump', '1010101010')
			,('Elvis', 'Presley', '1235674358')
			,('Norman', 'Rumpert', '5674312569')
			,('Andrew', 'Elliot', '8763216528')
			,('Randy', 'Gilbert', '2135286485')
			,('Jack', 'Jill', '7894561232')
			,('Pennywise', 'Clown', '7451236512')
go

delete borrower
where borrower_id = 20
go

Insert into [dbo].[artist]
			([fname], [lname], [artist_type_id])
		values
			('Taylor', 'Swift', 1)
			,('Michael', 'Jackson', 1)
			,('Bob', 'Dylan', 1)
			,('Lady', 'Gaga', 1)
			,('Elton', 'John', 1)
			,('Luke', 'Bryan', 1)
			,('Thomas', 'Rhett', 1)
			,('Kenny', 'Chesney', 1)
			,('Kendrick', null, 1)
			,('Johnny', 'Cash', 2)
			,('Bruno', 'Mars', 1)
			,('Kanye', 'West', 1)
			,('Katy', 'Perry', 1)
			,('Alicia', 'Keys', 1)
			,('Lil', 'Wayne', 1)
			,('Stevie', 'Wonder', 1)
			,('Ray', 'Charles', 1)
			,('Willie', 'Nelson', 1)
			,('Ed', 'Sheeran', 1)
			,('Justin', 'Timberlake', 1)
go

Insert into [dbo].[disk]
			([disk_name], [release_date], [genre_id], [status_id], [disk_type_id])
		values
			('Shallow', '09/27/2018', 1, 2, 1)
			,('7 Rings', '01/18/2019', 1, 2, 1)
			,('Without Me', '10/4/2018', 2, 1, 1)
			,('Sunflower', '1/4/2019', 3, 1, 1)
			,('Middle Child', '1/15/2019', 1, 1, 2)
			,('Happier', '12/4/2018', 1, 2, 3)
			,('Wow', '12/22/2018', 1, 3, 1)
			,('Sicko Mode', '11/6/2018', 1, 1, 1)
			,('High Hopes', '10/20/2018', 3, 2, 1)
			,('Eastside', '09/14/2018', 2, 1, 1)
			,('Please Me', '09/02/2018', 2, 1, 1)
			,('Going Bad', '10/24/2018', 1, 1, 2)
			,('Girls Like You', '1/24/2019', 1, 2, 1)
			,('A Lot', '12/13/2018', 4, 3, 1)
			,('Drip Too Hard', '1/25/2019', 1, 1, 1)
			,('Money', '11/4/2018', 1, 1, 1)
			,('Better', '11/24/2018', 3, 2, 1)
			,('Dancing With A Stranger', '10/10/2018', 3, 3, 1)
			,('Beautiful Crazy', '09/16/2018', 2, 2, 2)
			,('ZEZE', '10/18/2018', 1, 1, 3)
			,('IDEK', '11/13/2018', 1, 2, 1)
go

update disk
set release_date = '11/6/2018'
where disk_name = 'Money'
go

Insert into [dbo].[diskHasBorrower]
			([disk_id], [borrower_id], [borrowed_date], [returned_date])
		values
			(1, 3, '10/28/2018', '11/3/2018')
			,(3, 4, '02/18/2019', '02/25/2019')
			,(4, 1, '11/4/2018', '11/20/2018')
			,(11, 11, '2/4/2019', '2/22/2019')
			,(19, 2, '2/15/2019', '3/15/2019')
			,(12, 15, '1/4/2019', null)
			,(13, 17, '1/22/2019', '2/12/2019')
			,(5, 14, '12/6/2018', '1/6/2019')
			,(1, 3, '11/20/2018', '12/20/2018')
			,(16, 5, '10/14/2018', null)
			,(17, 8, '10/02/2018', '11/02/2018')
			,(7, 6, '11/24/2018', '12/28/2018')
			,(8, 7, '2/24/2019', '3/30/2019')
			,(5, 10, '1/13/2019', null)
			,(9, 12, '2/25/2019', '3/2/2019')
			,(10, 1, '12/4/2018', '12/30/2018')
			,(14, 19, '12/24/2018', '1/2/2019')
			,(3, 16, '11/10/2018', '12/13/2018')
			,(1, 18, '10/16/2018', '11/16/2018')
			,(6, 13, '11/18/2018', '12/20/2018')
go

Insert into [dbo].[diskHasArtist]
			([disk_id], [artist_id])
		values
			( 1, 4)
			,( 2, 5)
			,( 7, 3)
			,( 4, 2)
			,( 2, 7)
			,( 10, 19)
			,( 20, 9)
			,( 18, 2)
			,( 7, 8)
			,( 11, 5)
			,( 6, 15)
			,( 8, 9)
			,( 14, 16)
			,( 17, 14)
			,( 3, 4)
			,( 12, 10)
			,( 13, 8)
			,( 15, 13)
			,( 16, 9)
			,( 19, 1)
go

----- Project 4 Documentation-----
--3--
use disk_inventoryth
go

select disk_name as 'Disk Name', release_date as 'Release Name', fname as 'Artist First Name',
	lname as 'Artist Last Name'
from disk
join diskHasArtist on disk.disk_id = diskHasArtist.disk_id
join artist on diskHasArtist.artist_id = artist.artist_id
--add order by & format the date
order by [Artist Last Name], [Artist First Name], [Disk Name]
go

--4--
drop view if exists View_Individual_Artist
go

create view View_Individual_Artist as
	select artist_id, fname, lname
	from artist
	where artist_type_id = 1
go

select fname as FirstName, lname as LastName
from View_Individual_Artist

--5--
select disk_name as 'Disk Name', release_date as 'Release Name', fname as 'Group Name'
from disk
join diskHasArtist on disk.disk_id = diskHasArtist.disk_id
join artist on diskHasArtist.artist_id = artist.artist_id
where artist.artist_id != ALL --NOT IN
	(select artist_id from View_Individual_Artist)
--add order by & format the date
order by [Group Name], [Disk Name]

go

--6--
select fname as First, lname as Last, disk_name as 'Disk Name', borrowed_date as 'Borrowed Date', returned_date as 'Returned Date'
from borrower
join diskHasBorrower on borrower.borrower_id = diskHasBorrower.borrower_id
join disk on disk.disk_id = diskHasBorrower.disk_id
--add order by & format the date
order by Last, First, [Disk Name], [Borrowed Date], [Returned Date]

--select ('yyyy-mm-dd')

go

--7--
select disk.disk_id, disk_name, count(*) as 'Times Borrowed'
from disk
join diskHasBorrower on disk.disk_id = diskHasBorrower.disk_id
group by disk.disk_id, disk_name
--add order by & aliases

--8--
select disk_name, borrowed_date, returned_date, lname
from disk
join diskHasBorrower on disk.disk_id = diskHasBorrower.disk_id
join borrower on diskHasBorrower.borrower_id = borrower.borrower_id
where returned_date is null
--add order by & aliases
order by disk_name

------------------------Project 5 Documentation----------------------------
use disk_inventoryth
go
--Create insert procedure for borrower--
drop procedure if exists ins_borrower
go
create procedure ins_borrower
	@fname nvarchar(100),
	@lname nvarchar(100), 
	@phone_numb nvarchar(50)
as
	BEGIN TRY
	INSERT INTO [dbo].[borrower]
				([fname]
				,[lname]
				,[phone_numb])
			VALUES
				(@fname
				,@lname
				,@phone_numb)
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
	GO
exec ins_borrower 'Tigger', 'Tiger', '1234518769'
go

--Create update procedure for borrower--
drop procedure if exists upd_borrower
go
create procedure upd_borrower
	@borrower_id int,
	@fname nvarchar(100),
	@lname nvarchar(100), 
	@phone_numb nvarchar(50)
as
	BEGIN TRY
		UPDATE [dbo].[borrower]
		   SET [fname] = 'Eeyore'
			  ,[lname] = 'Donkey'
			  ,[phone_numb] = '2234578125'
		 WHERE borrower_id = @borrower_id
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
GO
exec upd_borrower 22, 'Eeyore', 'Donkey', '2234578125'
go
select * from borrower

--Create delete procedure for borrower--
drop procedure if exists del_borrower
go
create procedure del_borrower
	@borrower_id int
as
	BEGIN TRY
		 DELETE [dbo].[borrower]
		 WHERE borrower_id = @borrower_id
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
GO
exec del_borrower 21
go

--Create insert procedure for artist--
drop procedure if exists ins_artist
go
create procedure ins_artist
	@fname nvarchar(100),
	@lname nvarchar(100), 
	@artist_type_id int
as
	BEGIN TRY
	INSERT INTO [dbo].[artist]
				([fname]
				,[lname]
				,[artist_type_id])
			VALUES
				(@fname
				,@lname
				,@artist_type_id)
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
	GO
exec ins_artist 'Mac', 'Miller', 1
go

--Create update procedure for artist--
drop procedure if exists upd_artist
go
create procedure upd_artist
	@artist_id int,
	@fname nvarchar(100),
	@lname nvarchar(100), 
	@artist_type_id int
as
	BEGIN TRY
		UPDATE [dbo].[artist]
		   SET [fname] = 'Gucci'
			  ,[lname] = 'Mane'
			  ,[artist_type_id] = 1
		 WHERE artist_id = @artist_id
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
GO

exec upd_artist 21, 'Gucci', 'Mane', 1
go

--Create delete procedure for artist--
drop procedure if exists del_artist
go
create procedure del_artist
	@artist_id int
as
	BEGIN TRY
		DELETE FROM [dbo].[artist]
		WHERE artist_id = @artist_id
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
GO
exec del_artist 20
go

--Create insert procedure for disk--
drop procedure if exists ins_disk
go
create procedure ins_disk
	@disk_name varchar(100),
	@release_date datetime,
	@genre_id int,
	@status_id int,
	@disk_type_id int
as
	BEGIN TRY
	INSERT INTO [dbo].[disk]
			   ([disk_name]
			   ,[release_date]
			   ,[genre_id]
			   ,[status_id]
			   ,[disk_type_id])
		 VALUES
			   (@disk_name
			   ,@release_date
			   ,@genre_id
			   ,@status_id
			   ,@disk_type_id)
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	END CATCH
GO
exec ins_disk 'Passing', '03/20/2019', 1, 2, 1

--Create update procedure for disk--
drop procedure if exists upd_disk
go
create procedure upd_disk
	@disk_id int,
	@disk_name varchar(100),
	@release_date datetime,
	@genre_id int,
	@status_id int,
	@disk_type_id int
as
	BEGIN TRY
	UPDATE [dbo].[disk]
	   SET [disk_name] = 'Birthday'
		  ,[release_date] = '03/14/1999'
		  ,[genre_id] = 1
		  ,[status_id] = 2
		  ,[disk_type_id] = 3
	 WHERE disk_id = @disk_id
	 END TRY
	 BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE())
	 END CATCH
GO
exec upd_disk 12, 'Birthday', '03/14/1999', 1, 2, 3
go

--Create delete procedure for disk--
drop procedure if exists del_disk
go
create procedure del_disk
	@disk_id int
as
	BEGIN TRY
		DELETE FROM [dbo].[disk]
		WHERE disk_id = @disk_id
	END TRY
	BEGIN CATCH
		PRINT 'An error occurred.'
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE())
	END CATCH
GO
exec del_disk 42
go
select * from disk
-------------------------------------------------------

use master
go
if SUSER_ID('diskUserth') is not null
	drop login diskUserth
go
create login diskUserth with password = 'Pa$$w0rd',
	default_database = disk_inventoryth
go
use disk_inventoryth
go
if USER_ID('diskUserth') is not null
	drop user diskUserth
go
create user diskUserth
go