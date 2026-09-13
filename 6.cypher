1. Library Database
//a) List all readers who have recommended either book “Tinker Tailor Soldier Spy” or “Our Man in Havana” or “The Spy Who Came in from the Cold”

MATCH (r:Person:Reader)-[:RECOMMENDED]->(b:Book)
WHERE b.title IN ['Tinker Tailor Soldier Spy', 'Our Man in Havana', 'The Spy Who Came in from the Cold']
RETURN DISTINCT r.name AS Reader;

//b) List the readers who haven’t recommended any book

MATCH (r:Person:Reader)
WHERE NOT (r)-[:RECOMMENDED]->(:Book)
RETURN r.name AS Reader;


//c) List the authors who have written a book that has been read / issued by a maximum number of readers

MATCH (a:Author)-[:WROTE]->(b:Book)<-[:READ|ISSUED_BY]-(r:Person)
WITH a, b, count(DISTINCT r) AS readerCount
ORDER BY readerCount DESC
WITH max(readerCount) AS maxCount
MATCH (a:Author)-[:WROTE]->(b:Book)<-[:READ|ISSUED_BY]-(r:Person)
WITH a, b, count(DISTINCT r) AS readerCount, maxCount
WHERE readerCount = maxCount
RETURN DISTINCT a.name AS Author, b.title AS Book, readerCount;


//d) List the names of books recommended by “Alan” and read by at least one reader

MATCH (rec:Person {name: 'Alan'})-[:RECOMMENDED]->(b:Book)<-[:READ]-(reader:Person)
RETURN DISTINCT b.title AS Book;


//e) List the names of books recommended by “Alan” and read by the maximum number of readers

MATCH (rec:Person {name: 'Alan'})-[:RECOMMENDED]->(b:Book)<-[:READ]-(reader:Person)
WITH b, count(DISTINCT reader) AS readers
ORDER BY readers DESC
WITH collect({book: b, cnt: readers}) AS data, max(readers) AS maxReaders
UNWIND data AS d
WHERE d.cnt = maxReaders
RETURN d.book.title AS Book, d.cnt AS NumberOfReaders;


//f) List the names of publishers who haven’t published any books written by authors from Pune and Mumbai

// First ensure some authors have city property if needed
MATCH (p:Publisher)
WHERE NOT EXISTS {
  MATCH (p)<-[:PUBLISHED_BY]-(b:Book)<-[:WROTE]-(a:Author)
  WHERE a.city IN ['Pune', 'Mumbai']
}
RETURN p.name AS Publisher;


//g) List the names of voracious readers in our library
//(Assuming voracious = readers who have issued/read more books than average)

MATCH (r:Person:Reader)-[:READ|ISSUED_BY]->(b:Book)
WITH r, count(DISTINCT b) AS booksRead
WITH avg(booksRead) AS avgBooks
MATCH (r:Person:Reader)-[:READ|ISSUED_BY]->(b:Book)
WITH r, count(DISTINCT b) AS booksRead, avgBooks
WHERE booksRead > avgBooks
RETURN r.name AS VoraciousReader, booksRead
ORDER BY booksRead DESC;


2. Song Database
//a) List the names of artists who have sung only songs written by “John Lennon”

MATCH (a:Artist)-[:PERFORMS]->(s:Song)-[:WRITTEN_BY]->(w:SongAuthor {name: 'John Lennon'})
WITH a, collect(s) AS songsByLennon
MATCH (a)-[:PERFORMS]->(allSongs:Song)
WITH a, songsByLennon, collect(allSongs) AS allSongs
WHERE size(songsByLennon) = size(allSongs)
RETURN a.name AS Artist;


//b) List the names of artists who have sung the maximum number of songs recorded by “Abbey Road Studios”

MATCH (a:Artist)-[:PERFORMS]->(s:Song)-[:RECORDED_IN]->(st:RecordingStudio {name: 'Abbey Road Studios'})
WITH a, count(s) AS songCount
ORDER BY songCount DESC
WITH collect({artist: a, cnt: songCount}) AS data, max(songCount) AS maxCount
UNWIND data AS d
WHERE d.cnt = maxCount
RETURN d.artist.name AS Artist, d.cnt AS SongsRecorded;


//c) List the names of songs financed by “EMI” and sung by “The Beatles”

MATCH (c:RecordingCompany {name: 'EMI'})-[:FINANCES]->(s:Song)<-[:PERFORMS]-(a:Artist {name: 'The Beatles'})
RETURN s.title AS Song;



3. Employee Database
//a) List the names of employees having the same skills as employee “Alice Chen”

MATCH (alice:Employee {name: 'Alice Chen'})-[:HAS_ACQUIRED]->(s:Skillset)
WITH alice, collect(s) AS aliceSkills
MATCH (e:Employee)-[:HAS_ACQUIRED]->(s:Skillset)
WHERE e <> alice
WITH e, collect(s) AS empSkills, aliceSkills
WHERE all(skill IN aliceSkills WHERE skill IN empSkills)
  AND size(empSkills) = size(aliceSkills)
RETURN e.name AS Employee;


//b) List the projects controlled by a department “Engineering” and have employees of the same department working in it

MATCH (p:Project)-[:CONTROLLED_BY]->(d:Department {name: 'Engineering'})
MATCH (e:Employee)-[:WORKS_IN]->(d)
MATCH (e)-[:ASSIGNED_TO]->(p)
RETURN DISTINCT p.name AS Project, p.status AS Status;


//c) List the names of the projects belonging to departments managed by employee “Alice Chen”
//(Assuming a MANAGES relationship from Employee to Department)

// If you haven't created MANAGES yet, first add:
// MATCH (alice:Employee {name:'Alice Chen'}), (eng:Department {name:'Engineering'})
// CREATE (alice)-[:MANAGES]->(eng);

MATCH (e:Employee {name: 'Alice Chen'})-[:MANAGES]->(d:Department)<-[:CONTROLLED_BY]-(p:Project)
RETURN p.name AS Project;



4. Movie Database
//a) List the names of actors that paired in multiple movies together

MATCH (a1:Actor)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(a2:Actor)
WHERE id(a1) < id(a2)
WITH a1, a2, count(m) AS moviesTogether
WHERE moviesTogether > 1
RETURN a1.name AS Actor1, a2.name AS Actor2, moviesTogether
ORDER BY moviesTogether DESC;


//b) List all pairs of actors–movie subgraphs along with the roles played

MATCH (a1:Actor)-[r1:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(a2:Actor)
WHERE id(a1) < id(a2)
RETURN a1.name AS Actor1, 
       r1.role AS Role1, 
       m.title AS Movie, 
       a2.name AS Actor2, 
       r2.role AS Role2;

//c) List all reviewers and the ones they are following directly or via another third Reviewer

MATCH (r1:Reviewer)-[:FOLLOWS*1..2]->(r2:Reviewer)
WHERE r1 <> r2
RETURN DISTINCT r1.name AS Reviewer, 
                collect(DISTINCT r2.name) AS Following
ORDER BY Reviewer;

//d) List the names of movies that have the most number of reviews

MATCH (m:Movie)<-[:REVIEWED]-(r:Reviewer)
WITH m, count(r) AS reviewCount
ORDER BY reviewCount DESC
WITH collect({movie: m, cnt: reviewCount}) AS data, max(reviewCount) AS maxReviews
UNWIND data AS d
WHERE d.cnt = maxReviews
RETURN d.movie.title AS Movie, d.cnt AS NumberOfReviews;

5. Social Network Database
//a) List out the people who have created maximum timeline messages

MATCH (p:Person)-[:CREATES]->(t:Timeline)-[:CONTAINS]->(m:Message)
WITH p, count(m) AS messageCount
ORDER BY messageCount DESC
WITH collect({person: p, cnt: messageCount}) AS data, max(messageCount) AS maxCount
UNWIND data AS d
WHERE d.cnt = maxCount
RETURN d.person.name AS Person, d.cnt AS MessagesCreated;


//b) List all friends of John’s friend, Tom

MATCH (john:Person {name: 'John'})-[:FRIEND_OF]->(tom:Person {name: 'Tom'})-[:FRIEND_OF]->(friend:Person)
WHERE friend <> john
RETURN DISTINCT friend.name AS FriendOfTom;


//c) List the people with maximum friends

MATCH (p:Person)-[:FRIEND_OF]->(f:Person)
WITH p, count(f) AS friendCount
ORDER BY friendCount DESC
WITH collect({person: p, cnt: friendCount}) AS data, max(friendCount) AS maxFriends
UNWIND data AS d
WHERE d.cnt = maxFriends
RETURN d.person.name AS Person, d.cnt AS NumberOfFriends;


//d) List the people who are part of more than 3 groups

MATCH (p:Person)-[:BELONGS_TO]->(g:Group)
WITH p, count(g) AS groupCount
WHERE groupCount > 3
RETURN p.name AS Person, groupCount
ORDER BY groupCount DESC;


