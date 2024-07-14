## 1. Who is the senior most employee based on job title? 
select * from music_store.employee
order by levels desc
limit 1;

## Which countries have the most Invoices? 
select count(*) as coun,billing_country from music_store.invoice
group by billing_country 
order by coun desc;

## What are top 3 values of total invoice? 
select * from music_store.invoice
order by total desc 
limit 3;

## Which city has the best customers? We would like to throw a promotional Music  Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals 
select billing_city,sum(total) as su from music_store.invoice
group by billing_city
order by su desc 
limit 1 ;

## Who is the best customer? The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
##new
select customer.customer_id, customer.first_name,customer.last_name,sum(invoice.total) as sui from customer 
join invoice on customer.customer_id=invoice.customer_id 
group by customer.customer_id,customer.first_name, customer.last_name
order by sui desc
limit 1;

## Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A 
SELECT DISTINCT customer.email,customer.first_name, customer.last_name , genre.name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

## new method
SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

##Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands 
## new (error_found)
select artist.artist_id, artist.name,count(track.track_id) as cow from artist
join album on artist.artist_id=album.artist_id
join track on album.album_id=track.track_id
join genre on genre.genre_id=track.genre_id
WHERE genre.name LIKE 'Rock'
group by artist.artist_id,artist.name
order by cow desc
limit 10 ;



##Return all the track names that have a song length longer than the average song length.Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first 
SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) 
	FROM track )
ORDER BY milliseconds DESC;



