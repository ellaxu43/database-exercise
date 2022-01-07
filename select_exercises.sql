USE albums_db;
SELECT * FROM albums;
SELECT COUNT(id) FROM albums;
#3.a There are 31 rows in the albums. 

SELECT COUNT(DISTINCT artist) FROM albums;
# 3.b There are 23 unique artist names. 

# 3.c The primary key is the id. 

SELECT * FROM albums
ORDER BY  release_date ASC;

#3.d The oldest is 1967.The most recent release date is 2011. 

SELECT * FROM albums 
WHERE artist = 'Pink Floyd';

#4.a The Dark Side of the Moon and the Wall 

SELECT * FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band ';

SELECT * FROM albums
WHERE name = 'Nevermind';
#4.c the genre is Grunge, Alternative rock

SELECT * FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

# 4.d there are a lot of albums were leased from 1990-1999. 1999 is included. 11 in total. 

SELECT count(*) FROM albums
WHERE sales < 20;


# 4.e there are a lot of albums sales under 20, a total of 13. 

SELECT * FROM albums 
WHERE genre like'%Rock';

#4.f All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? Beacuse we used = then only exact answer will show, if we put like '%' then other Rock genre will show. 
