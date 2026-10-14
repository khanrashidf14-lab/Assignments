// 1.lib
// Persons
CREATE (joshi:Person:Reader {name: 'Mr. Joshi', memberId: 'R010'})
CREATE (alan:Person:Reader {name: 'Alan', memberId: 'R001'})
CREATE (ian:Person:Reader {name: 'Ian', memberId: 'R002'})
CREATE (lecarre:Person:Author {name: 'John le Carré', born: date('1931-10-19')})
CREATE (greene:Person:Author {name: 'Graham Greene', born: date('1904-10-02'), died: date('1991-04-03')})

// Books
CREATE (b1:Book {title: 'Tinker Tailor Soldier Spy', published: 1974, status: 'issued', type: 'Novel'})
CREATE (b2:Book {title: 'Our Man in Havana', published: 1958, status: 'available', type: 'Novel'})
CREATE (b3:Book {title: 'The Spy Who Came in from the Cold', published: 1963, status: 'issued', type: 'Novel'})

// Publishers
CREATE (p1:Publisher {name: 'Hodder & Stoughton', city: 'London'})
CREATE (p2:Publisher {name: 'Mehta Publishing House', city: 'Pune'})
CREATE (p3:Publisher {name: 'Popular Prakashan', city: 'Pune'})

// Relationships
CREATE (lecarre)-[:WROTE]->(b1)
CREATE (greene)-[:WROTE]->(b2)
CREATE (lecarre)-[:WROTE]->(b3)

CREATE (b1)-[:PUBLISHED_BY]->(p1)
CREATE (b2)-[:PUBLISHED_BY]->(p1)
CREATE (b3)-[:PUBLISHED_BY]->(p2)

CREATE (joshi)-[:ISSUED_BY {date: date('2024-03-10')}]->(b1)
CREATE (joshi)-[:ISSUED_BY {date: date('2024-05-22')}]->(b3)
CREATE (alan)-[:ISSUED_BY {date: date('2023-11-05')}]->(b2)

CREATE (joshi)-[:READ]->(b1)
CREATE (joshi)-[:READ]->(b3)
CREATE (alan)-[:READ]->(b1)
CREATE (ian)-[:READ]->(b1);

MATCH (a:Person:Author {name: 'John le Carré'})
SET a.city = 'Mumbai';
MATCH (a:Person:Author {name: 'Graham Greene'})
SET a.city = 'Pune';


MATCH (alan:Person:Reader {name: 'Alan'}),
      (joshi:Person:Reader {name: 'Mr. Joshi'}),
      (b1:Book {title: 'Tinker Tailor Soldier Spy'}),
      (b2:Book {title: 'Our Man in Havana'}),
      (b3:Book {title: 'The Spy Who Came in from the Cold'})
MERGE (alan)-[:RECOMMENDED]->(b1)
MERGE (alan)-[:RECOMMENDED]->(b2)
MERGE (joshi)-[:RECOMMENDED]->(b3);


// (a) List all readers who have recommended any of the three books.
MATCH (r:Person:Reader)-[:RECOMMENDED]->(b:Book)
WHERE b.title IN [
  'Tinker Tailor Soldier Spy',
  'Our Man in Havana',
  'The Spy Who Came in from the Cold'
]
RETURN DISTINCT r.name AS Reader;

// (b) List readers who have not recommended any book.
MATCH (r:Person:Reader)
WHERE NOT (r)-[:RECOMMENDED]->(:Book)
RETURN r.name AS Reader;

// (c) List authors whose books have been read or issued by the maximum number of readers.
MATCH (a:Person:Author)-[:WROTE]->(b:Book)<-[:READ|ISSUED_BY]-(r:Person)
WITH a, b, count(DISTINCT r) AS readerCount
WITH collect({author: a.name, book: b.title, readers: readerCount}) AS data,
     max(readerCount) AS maxCount
UNWIND data AS d
WITH d, maxCount
WHERE d.readers = maxCount
RETURN DISTINCT d.author AS Author,
       d.book AS Book,
       d.readers AS NumberOfReaders;

// (d) List books recommended by Alan and read by at least one reader.
MATCH (:Person:Reader {name: 'Alan'})-[:RECOMMENDED]->(b:Book)<-[:READ]-(r:Person)
RETURN DISTINCT b.title AS Book;

// (e) List books recommended by Alan and read by the maximum number of readers.
MATCH (:Person:Reader {name: 'Alan'})-[:RECOMMENDED]->(b:Book)<-[:READ]-(r:Person)
WITH b, count(DISTINCT r) AS readerCount
WITH collect({book: b.title, readers: readerCount}) AS data,
     max(readerCount) AS maxCount
UNWIND data AS d
WITH d, maxCount
WHERE d.readers = maxCount
RETURN d.book AS Book, d.readers AS NumberOfReaders;

// (f) List publishers who have not published books written by authors from Pune or Mumbai.
MATCH (p:Publisher)
WHERE NOT EXISTS {
  MATCH (a:Person:Author)-[:WROTE]->(b:Book)-[:PUBLISHED_BY]->(p)
  WHERE a.city IN ['Pune', 'Mumbai']
}
RETURN p.name AS Publisher;

// (g) List voracious readers: readers who have read/issued more books than the average.
MATCH (r:Person:Reader)-[:READ|ISSUED_BY]->(b:Book)
WITH r, count(DISTINCT b) AS booksRead
WITH collect({reader: r.name, count: booksRead}) AS data,
     avg(booksRead) AS avgBooks
UNWIND data AS d
WITH d, avgBooks
WHERE d.count > avgBooks
RETURN d.reader AS VoraciousReader, d.count AS BooksRead
ORDER BY BooksRead DESC;


//2.Song
CREATE (beatles:Artist {name: 'The Beatles'})
CREATE (adele:Artist {name: 'Adele'})

CREATE (lennon:SongAuthor {name: 'John Lennon'})
CREATE (mccartney:SongAuthor {name: 'Paul McCartney'})
CREATE (adeleAuthor:SongAuthor {name: 'Adele Adkins'})

CREATE (heyJude:Song {title: 'Hey Jude', year: 1968})
CREATE (someone:Song {title: 'Someone Like You', year: 2011})
CREATE (letItBe:Song {title: 'Let It Be', year: 1970})

CREATE (abbey:RecordingStudio {name: 'Abbey Road Studios'})
CREATE (electric:RecordingStudio {name: 'Electric Lady Studios'})

CREATE (emi:RecordingCompany {name: 'EMI'})
CREATE (xl:RecordingCompany {name: 'XL Recordings'})

CREATE (beatles)-[:PERFORMS]->(heyJude)
CREATE (beatles)-[:PERFORMS]->(letItBe)
CREATE (adele)-[:PERFORMS]->(someone)

CREATE (heyJude)-[:WRITTEN_BY]->(lennon)
CREATE (heyJude)-[:WRITTEN_BY]->(mccartney)
CREATE (letItBe)-[:WRITTEN_BY]->(mccartney)
CREATE (someone)-[:WRITTEN_BY]->(adeleAuthor)

CREATE (heyJude)-[:RECORDED_IN]->(abbey)
CREATE (letItBe)-[:RECORDED_IN]->(abbey)
CREATE (someone)-[:RECORDED_IN]->(electric)

CREATE (emi)-[:FINANCES]->(heyJude)
CREATE (emi)-[:FINANCES]->(letItBe)
CREATE (xl)-[:FINANCES]->(someone);


MERGE (johnLennon:Artist {name: 'John Lennon'})
MERGE (imagine:Song {title: 'Imagine', year: 1971})
MERGE (johnLennon)-[:PERFORMS]->(imagine)
MERGE (imagine)-[:WRITTEN_BY]->(:SongAuthor {name: 'John Lennon'});


// (a) List artists who have sung only songs written by John Lennon.
MATCH (a:Artist)-[:PERFORMS]->(s:Song)
WHERE EXISTS {
  MATCH (s)-[:WRITTEN_BY]->(:SongAuthor {name: 'John Lennon'})
}
AND NOT EXISTS {
  MATCH (a)-[:PERFORMS]->(other:Song)
  WHERE NOT EXISTS {
    MATCH (other)-[:WRITTEN_BY]->(:SongAuthor {name: 'John Lennon'})
  }
}
RETURN DISTINCT a.name AS Artist;

// (b) List artists who have sung the maximum number of songs recorded by Abbey Road Studios.
MATCH (a:Artist)-[:PERFORMS]->(s:Song)-[:RECORDED_IN]->(:RecordingStudio {name: 'Abbey Road Studios'})
WITH a, count(DISTINCT s) AS songCount
WITH collect({artist: a.name, count: songCount}) AS data,
     max(songCount) AS maxCount
UNWIND data AS d
WITH d, maxCount
WHERE d.count = maxCount
RETURN d.artist AS Artist, d.count AS SongsRecorded;

// (c) List songs financed by EMI and sung by The Beatles.
MATCH (:RecordingCompany {name: 'EMI'})-[:FINANCES]->(s:Song)<-[:PERFORMS]-(:Artist {name: 'The Beatles'})
RETURN DISTINCT s.title AS Song;


//3.employee

// emp
CREATE (eng:Department {name: 'Engineering'})
CREATE (mkt:Department {name: 'Marketing'})
CREATE (hr:Department {name: 'Human Resources'})

CREATE (alice:Employee {name: 'Alice Chen', empId: 'E1001'})
CREATE (bob:Employee {name: 'Bob Smith', empId: 'E1002'})
CREATE (carol:Employee {name: 'Carol Diaz', empId: 'E1003'})
CREATE (dave:Employee {name: 'Dave Kumar', empId: 'E1004'})

CREATE (python:Skillset {name: 'Python'})
CREATE (pm:Skillset {name: 'Project Management'})
CREATE (seo:Skillset {name: 'SEO'})

CREATE (proj1:Project {name: 'Neo4j Migration', status: 'Active', budget: 500000})
CREATE (proj2:Project {name: 'Q3 Campaign', status: 'Planning', budget: 200000})

CREATE (alice)-[:WORKS_IN]->(eng)
CREATE (bob)-[:WORKS_IN]->(eng)
CREATE (dave)-[:WORKS_IN]->(eng)
CREATE (carol)-[:WORKS_IN]->(mkt)

CREATE (alice)-[:HAS_ACQUIRED]->(python)
CREATE (alice)-[:HAS_ACQUIRED]->(pm)
CREATE (bob)-[:HAS_ACQUIRED]->(python)
CREATE (carol)-[:HAS_ACQUIRED]->(seo)

CREATE (alice)-[:ASSIGNED_TO]->(proj1)
CREATE (bob)-[:ASSIGNED_TO]->(proj1)
CREATE (carol)-[:ASSIGNED_TO]->(proj2)

CREATE (proj1)-[:CONTROLLED_BY]->(eng)
CREATE (proj2)-[:CONTROLLED_BY]->(mkt)

CREATE (alice)-[:PROJECT_MANAGER]->(proj1);


MATCH (bob:Employee {name: 'Bob Smith'}),
      (pm:Skillset {name: 'Project Management'})
MERGE (bob)-[:HAS_ACQUIRED]->(pm);


MATCH (alice:Employee {name: 'Alice Chen'}),
      (eng:Department {name: 'Engineering'})
MERGE (alice)-[:MANAGES]->(eng);

// emp
CREATE (eng:Department {name: 'Engineering'})
CREATE (mkt:Department {name: 'Marketing'})
CREATE (hr:Department {name: 'Human Resources'})

CREATE (alice:Employee {name: 'Alice Chen', empId: 'E1001'})
CREATE (bob:Employee {name: 'Bob Smith', empId: 'E1002'})
CREATE (carol:Employee {name: 'Carol Diaz', empId: 'E1003'})
CREATE (dave:Employee {name: 'Dave Kumar', empId: 'E1004'})

CREATE (python:Skillset {name: 'Python'})
CREATE (pm:Skillset {name: 'Project Management'})
CREATE (seo:Skillset {name: 'SEO'})

CREATE (proj1:Project {name: 'Neo4j Migration', status: 'Active', budget: 500000})
CREATE (proj2:Project {name: 'Q3 Campaign', status: 'Planning', budget: 200000})

CREATE (alice)-[:WORKS_IN]->(eng)
CREATE (bob)-[:WORKS_IN]->(eng)
CREATE (dave)-[:WORKS_IN]->(eng)
CREATE (carol)-[:WORKS_IN]->(mkt)

CREATE (alice)-[:HAS_ACQUIRED]->(python)
CREATE (alice)-[:HAS_ACQUIRED]->(pm)
CREATE (bob)-[:HAS_ACQUIRED]->(python)
CREATE (carol)-[:HAS_ACQUIRED]->(seo)

CREATE (alice)-[:ASSIGNED_TO]->(proj1)
CREATE (bob)-[:ASSIGNED_TO]->(proj1)
CREATE (carol)-[:ASSIGNED_TO]->(proj2)

CREATE (proj1)-[:CONTROLLED_BY]->(eng)
CREATE (proj2)-[:CONTROLLED_BY]->(mkt)

CREATE (alice)-[:PROJECT_MANAGER]->(proj1);


MATCH (bob:Employee {name: 'Bob Smith'}),
      (pm:Skillset {name: 'Project Management'})
MERGE (bob)-[:HAS_ACQUIRED]->(pm);


MATCH (alice:Employee {name: 'Alice Chen'}),
      (eng:Department {name: 'Engineering'})
MERGE (alice)-[:MANAGES]->(eng);


//4.movie

// movie
CREATE (leo:Actor {name: 'Leonardo DiCaprio'})
CREATE (kate:Actor {name: 'Kate Winslet'})
CREATE (tom:Actor {name: 'Tom Hardy'})
CREATE (cillian:Actor {name: 'Cillian Murphy'})

CREATE (nolan:Director {name: 'Christopher Nolan'})
CREATE (james:Director {name: 'James Cameron'})

CREATE (emma:Producer {name: 'Emma Thomas'})
CREATE (jon:Producer {name: 'Jon Landau'})

CREATE (inception:Movie {title: 'Inception', year: 2010})
CREATE (dunkirk:Movie {title: 'Dunkirk', year: 2017})
CREATE (titanic:Movie {title: 'Titanic', year: 1997})
CREATE (oppenheimer:Movie {title: 'Oppenheimer', year: 2023})

CREATE (r1:Reviewer {name: 'Critic A'})
CREATE (r2:Reviewer {name: 'Critic B'})
CREATE (r3:Reviewer {name: 'Critic C'})

// Acting
CREATE (leo)-[:ACTED_IN]->(inception)
CREATE (tom)-[:ACTED_IN]->(inception)
CREATE (leo)-[:ACTED_IN]->(titanic)
CREATE (kate)-[:ACTED_IN]->(titanic)
CREATE (cillian)-[:ACTED_IN]->(oppenheimer)
CREATE (tom)-[:ACTED_IN]->(dunkirk)
CREATE (leo)-[:ACTED_IN]->(dunkirk)

// Directing & Producing
CREATE (nolan)-[:DIRECTED]->(inception)
CREATE (nolan)-[:DIRECTED]->(dunkirk)
CREATE (nolan)-[:DIRECTED]->(oppenheimer)
CREATE (james)-[:DIRECTED]->(titanic)

CREATE (emma)-[:PRODUCED]->(inception)
CREATE (emma)-[:PRODUCED]->(dunkirk)
CREATE (emma)-[:PRODUCED]->(oppenheimer)
CREATE (jon)-[:PRODUCED]->(titanic)

// Reviews + Following
CREATE (r1)-[:REVIEWED]->(inception)
CREATE (r2)-[:REVIEWED]->(inception)
CREATE (r1)-[:REVIEWED]->(dunkirk)
CREATE (r3)-[:REVIEWED]->(oppenheimer)

CREATE (r1)-[:FOLLOWS]->(r2)
CREATE (r2)-[:FOLLOWS]->(r3);


MATCH (:Actor {name: 'Leonardo DiCaprio'})-[r:ACTED_IN]->(:Movie {title: 'Inception'})
SET r.role = 'Cobb';
MATCH (:Actor {name: 'Tom Hardy'})-[r:ACTED_IN]->(:Movie {title: 'Inception'})
SET r.role = 'Eames';
MATCH (:Actor {name: 'Leonardo DiCaprio'})-[r:ACTED_IN]->(:Movie {title: 'Titanic'})
SET r.role = 'Jack';
MATCH (:Actor {name: 'Kate Winslet'})-[r:ACTED_IN]->(:Movie {title: 'Titanic'})
SET r.role = 'Rose';
MATCH (:Actor {name: 'Tom Hardy'})-[r:ACTED_IN]->(:Movie {title: 'Dunkirk'})
SET r.role = 'Farrier';
MATCH (:Actor {name: 'Leonardo DiCaprio'})-[r:ACTED_IN]->(:Movie {title: 'Dunkirk'})
SET r.role = 'Pilot';


// (a) List pairs of actors who acted together in more than one movie.
MATCH (a1:Actor)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(a2:Actor)
WHERE elementId(a1) < elementId(a2)
WITH a1, a2, count(DISTINCT m) AS moviesTogether
WHERE moviesTogether > 1
RETURN a1.name AS Actor1, a2.name AS Actor2,
       moviesTogether AS MoviesTogether
ORDER BY MoviesTogether DESC;

// (b) List actor pairs, movies, and the roles they played.
MATCH (a1:Actor)-[r1:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(a2:Actor)
WHERE elementId(a1) < elementId(a2)
RETURN a1.name AS Actor1, r1.role AS Role1,
       m.title AS Movie,
       a2.name AS Actor2, r2.role AS Role2;

// (c) List reviewers and reviewers they follow directly or through one other reviewer.
MATCH (r1:Reviewer)-[:FOLLOWS*1..2]->(r2:Reviewer)
WHERE r1 <> r2
RETURN r1.name AS Reviewer,
       collect(DISTINCT r2.name) AS Following
ORDER BY Reviewer;

// (d) List movies with the maximum number of reviews.
MATCH (m:Movie)<-[:REVIEWED]-(r:Reviewer)
WITH m, count(DISTINCT r) AS reviewCount
WITH collect({movie: m.title, count: reviewCount}) AS data,
     max(reviewCount) AS maxReviews
UNWIND data AS d
WITH d, maxReviews
WHERE d.count = maxReviews
RETURN d.movie AS Movie, d.count AS NumberOfReviews;


//5.social

// social
CREATE (john:Person {name: 'John', born: 1990})
CREATE (alice:Person {name: 'Alice', born: 1990})
CREATE (bob:Person {name: 'Bob', born: 1988})
CREATE (carol:Person {name: 'Carol', born: 1992})
CREATE (dave:Person {name: 'Dave', born: 1990})

CREATE (univ:Affiliation {name: 'IIT Bombay', type: 'University'})
CREATE (company:Affiliation {name: 'TCS', type: 'Company'})

CREATE (t:Timeline {owner: 'John'})

CREATE (m1:Message {text: 'Happy New Year!', year: 2015, timestamp: datetime('2015-01-01T10:00:00')})
CREATE (m2:Message {text: 'Finished my project', year: 2015, timestamp: datetime('2015-06-15T18:30:00')})
CREATE (m3:Message {text: 'Hello 2024', year: 2024, timestamp: datetime('2024-01-01T09:00:00')})

// Friendships
CREATE (john)-[:FRIEND_OF {since: 2012}]->(alice)
CREATE (john)-[:FRIEND_OF {since: 2015}]->(bob)
CREATE (john)-[:FRIEND_OF {since: 2018}]->(dave)
CREATE (alice)-[:FRIEND_OF {since: 2013}]->(carol)

// Affiliations
CREATE (john)-[:AFFILIATED_TO]->(univ)
CREATE (john)-[:AFFILIATED_TO]->(company)

// Timeline & Messages
CREATE (john)-[:CREATES]->(t)
CREATE (t)-[:CONTAINS]->(m1)
CREATE (t)-[:CONTAINS]->(m2)
CREATE (t)-[:CONTAINS]->(m3);


MERGE (tom:Person {name: 'Tom'})
WITH tom
MATCH (john:Person {name: 'John'}),
      (alice:Person {name: 'Alice'}),
      (bob:Person {name: 'Bob'})
MERGE (john)-[:FRIEND_OF]->(tom)
MERGE (tom)-[:FRIEND_OF]->(alice)
MERGE (tom)-[:FRIEND_OF]->(bob);


MERGE (g1:Group {name: 'Sports'})
MERGE (g2:Group {name: 'Music'})
MERGE (g3:Group {name: 'Reading'})
MERGE (g4:Group {name: 'Technology'})
WITH g1, g2, g3, g4
MATCH (john:Person {name: 'John'})
MERGE (john)-[:BELONGS_TO]->(g1)
MERGE (john)-[:BELONGS_TO]->(g2)
MERGE (john)-[:BELONGS_TO]->(g3)
MERGE (john)-[:BELONGS_TO]->(g4);


// (a) List people who created the maximum number of timeline messages.
MATCH (p:Person)-[:CREATES]->(:Timeline)-[:CONTAINS]->(m:Message)
WITH p, count(DISTINCT m) AS messageCount
WITH collect({person: p.name, count: messageCount}) AS data,
     max(messageCount) AS maxCount
UNWIND data AS d
WITH d, maxCount
WHERE d.count = maxCount
RETURN d.person AS Person, d.count AS MessagesCreated;

// (b) List friends of Tom, who is John's friend.
MATCH (:Person {name: 'John'})-[:FRIEND_OF]->(:Person {name: 'Tom'})-[:FRIEND_OF]->(friend:Person)
WHERE friend.name <> 'John'
RETURN DISTINCT friend.name AS FriendOfTom;

// (c) List people with the maximum number of friends.
MATCH (p:Person)-[:FRIEND_OF]->(f:Person)
WITH p, count(DISTINCT f) AS friendCount
WITH collect({person: p.name, count: friendCount}) AS data,
     max(friendCount) AS maxFriends
UNWIND data AS d
WITH d, maxFriends
WHERE d.count = maxFriends
RETURN d.person AS Person, d.count AS NumberOfFriends;

// (d) List people who belong to more than three groups.
MATCH (p:Person)-[:BELONGS_TO]->(g:Group)
WITH p, count(DISTINCT g) AS groupCount
WHERE groupCount > 3
RETURN p.name AS Person, groupCount AS NumberOfGroups
ORDER BY NumberOfGroups DESC;
