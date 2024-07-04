-- table pieces
create table pieces(
	code int primary key not null,
	name text not null
)
-- table providers
create table providers(
	code text primary key not null,
	name text not null
)

-- table provides
create table provides(
	piece int 
	constraint fk_pieces_code references pieces(code),
	provider text
	constraint fk_providers_code references providers(code),
	price int not null,
	primary key(piece,provider)
)


INSERT INTO providers(code, name) VALUES('HAL','Clarke Enterprises');
 INSERT INTO providers(code, name) VALUES('RBT','Susan Calvin Corp.');
 INSERT INTO providers(code, name) VALUES('TNBC','Skellington Supplies');

INSERT INTO pieces(code, name) VALUES(1,'Sprocket');
 INSERT INTO pieces(code, name) VALUES(2,'Screw');
 INSERT INTO pieces(code, name) VALUES(3,'Nut');
 INSERT INTO pieces(code, name) VALUES(4,'Bolt');


 INSERT INTO provides(piece, provider, price) VALUES(1,'HAL',10);
 INSERT INTO provides(piece, provider, price) VALUES(1,'RBT',15);
 INSERT INTO provides(piece, provider, price) VALUES(2,'HAL',20);
 INSERT INTO provides(piece, provider, price) VALUES(2,'RBT',15);
 INSERT INTO provides(piece, provider, price) VALUES(2,'TNBC',14);
 INSERT INTO provides(piece, provider, price) VALUES(3,'RBT',50);
 INSERT INTO provides(piece, provider, price) VALUES(3,'TNBC',45);
 INSERT INTO provides(piece, provider, price) VALUES(4,'HAL',5);
 INSERT INTO provides(piece, provider, price) VALUES(4,'RBT',7);


select * from provides

-- select the name of all the piece
select name
from pieces
--Select all the providers' data.
select * from providers

-- avg_price on the basis of code 
select round(avg(c.price),2)as avg_price,p.code
from pieces p 
join provides c on c.piece = p.code
group by p.code
order by p.code desc


select avg(price) as avg_price ,piece
from provides
group by piece

--Obtain the names of all providers who supply piece 1
select p.name 
from providers p 
join provides c on c.provider = p.code
where c.piece=1
-- group by p.code
-- order by p.code desc
-- using subquery how to solve this

select name 
from providers 
where code in (
	select provider
	from provides
	where provides.piece=1)
-- "Clarke Enterprises"
-- "Susan Calvin Corp."

--select the name of pieces provided by provider with code "HAL"
-- THIS IS THE NAME OF PROVIDERS
select name
from providers
where code in(
	select provider
	from provides
	where provider ='HAL'
);

--ANOTHER METHOD
select *From pieces;
	
select p.name,t.provider
from pieces p 
INNER join provides t on t.piece =p.code
AND t.provider ='HAL'
-- subquery
select name
from pieces
where code in  (
	select piece
	from provides 
	where provider='HAL'
)
--For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
--(note that there could be two providers who supply the same piece at the most expensive price).
SELECT p.name,t.provider,t.price
from pieces p
inner join provides t on t.piece= p.code
	inner join providers c on c.code= t.provider
	where price =(
	select max(price) 
	from provides
	where p.code = t.piece
	)
order by t.price desc

--7. Add an entry to the database to indicate that "Skellington Supplies" 
--(code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO provides VALUES(1,'TNBC',7)

	
select * from provides

select provider,price,piece
from provides
where provider ='TNBC'
--ADD THE 10 VALUE FROMTHE 'TNBC' PROVIDER IN THE PROVIDES TABLE
UPDATE provides
set price =24
where piece =2 and provider ='TNBC'

--Increase all prices by one cent.
SELECT provider,price+1 
from provides

update provides
set price =price+1

select name
	from providers
-- Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).

		select p.code,t.provider,c.name,p.name
		from pieces p 
		inner join provides t on t.piece = p.code
		inner join providers c on c.code =t.provider



		delete from provides
		WHERE provider='RBT' AND piece=4


--10. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should still remain in the database).

