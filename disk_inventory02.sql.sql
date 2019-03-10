/********************************************************************************
*	Name			Date			Description
*
*	Tyler Hon		3/1/2019		Implementation of disk_inventoryth
*	Tyler Hon		3/8/2019		Implementation of INSERT statements (Line 86)
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
			,(14, 20, '12/24/2018', '1/2/2019')
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
			,( 12, 5)
			,( 13, 8)
			,( 15, 13)
			,( 16, 9)
			,( 19, 1)
go


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