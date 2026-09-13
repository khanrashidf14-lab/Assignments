1. Library Database
//Sample Data (run this first)
MATCH (n) DETACH DELETE n;

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



//a)List all people who have issued a book “Tinker Tailor Soldier Spy”

MATCH (p:Person)-[:ISSUED_BY]->(b:Book {title: 'Tinker Tailor Soldier Spy'})
RETURN p.name AS Person;

//b)Count the number of people who have read “Tinker Tailor Soldier Spy”

MATCH (p:Person)-[:READ]->(b:Book {title: 'Tinker Tailor Soldier Spy'})
RETURN count(p) AS NumberOfReaders;

//c)Add a property “Number of books issued” for Mr. Joshi and set its value as the count

MATCH (joshi:Person {name: 'Mr. Joshi'})-[r:ISSUED_BY]->(:Book)
WITH joshi, count(r) AS cnt
SET joshi.numberOfBooksIssued = cnt
RETURN joshi.name, joshi.numberOfBooksIssued;

//d)List the names of publishers from Pune city

MATCH (p:Publisher {city: 'Pune'})
RETURN p.name AS PublisherName;



2. Song Database
//Sample Data

MATCH (n) DETACH DELETE n;

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


//a) List the names of songs written by “John Lennon”

MATCH (s:Song)-[:WRITTEN_BY]->(a:SongAuthor {name: 'John Lennon'})
RETURN s.title AS Song;


//b) List the names of record companies who have financed for the song “Hey Jude”

MATCH (c:RecordingCompany)-[:FINANCES]->(s:Song {title: 'Hey Jude'})
RETURN c.name AS RecordCompany;


//c) List the names of artists performing the song “Someone Like You”\

MATCH (a:Artist)-[:PERFORMS]->(s:Song {title: 'Someone Like You'})
RETURN a.name AS Artist;


//d) Name the songs recorded by the studio “Abbey Road Studios”

MATCH (s:Song)-[:RECORDED_IN]->(st:RecordingStudio {name: 'Abbey Road Studios'})
RETURN s.title AS Song;



3. Employee Database
//Sample Data


MATCH (n) DETACH DELETE n;

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



//a) List the names of employees in the department “Engineering”

MATCH (e:Employee)-[:WORKS_IN]->(d:Department {name: 'Engineering'})
RETURN e.name AS Employee;


//b) List the projects along with their properties, controlled by department “Engineering”

MATCH (p:Project)-[:CONTROLLED_BY]->(d:Department {name: 'Engineering'})
RETURN p.name AS Project, properties(p) AS Properties;


//c) List the departments along with the count of employees in it

MATCH (e:Employee)-[:WORKS_IN]->(d:Department)
RETURN d.name AS Department, count(e) AS EmployeeCount
ORDER BY EmployeeCount DESC;


//d) List the skillset for an employee “Alice Chen”

MATCH (e:Employee {name: 'Alice Chen'})-[:HAS_ACQUIRED]->(s:Skillset)
RETURN s.name AS Skill;


4. Movie Database
//Sample Data (includes Reviewers + FOLLOWS)

MATCH (n) DETACH DELETE n;

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



//a) Find all actors who have acted in a movie “Inception”

MATCH (a:Actor)-[:ACTED_IN]->(m:Movie {title: 'Inception'})
RETURN a.name AS Actor;


//b) Find all reviewer pairs, one following the other and both reviewing the same movie, and return entire subgraphs

MATCH path = (r1:Reviewer)-[:FOLLOWS]->(r2:Reviewer),
             (r1)-[:REVIEWED]->(m:Movie)<-[:REVIEWED]-(r2)
RETURN path;


//c) Find all actors that acted in a movie together after 2010 and return the actor names and movie node

MATCH (a1:Actor)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(a2:Actor)
WHERE m.year > 2010 AND id(a1) < id(a2)
RETURN a1.name AS Actor1, a2.name AS Actor2, m;


//d) Find all movies produced by “Emma Thomas”

MATCH (p:Producer {name: 'Emma Thomas'})-[:PRODUCED]->(m:Movie)
RETURN m.title AS Movie, m.year AS Year;



5. Social Network Database
//Sample Data

MATCH (n) DETACH DELETE n;

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


//a) Find all friends of “John”, along with the year, since when John knows them

MATCH (john:Person {name: 'John'})-[r:FRIEND_OF]->(friend:Person)
RETURN friend.name AS Friend, r.since AS FriendsSince
ORDER BY r.since;


//b) List out the affiliations of John

MATCH (john:Person {name: 'John'})-[:AFFILIATED_TO]->(a:Affiliation)
RETURN a.name AS Affiliation, a.type AS Type;


//c) Find all friends of John who are born in the same year as John

MATCH (john:Person {name: 'John'})-[:FRIEND_OF]->(friend:Person)
WHERE friend.born = john.born
RETURN friend.name AS Friend, friend.born AS BirthYear;


//d) List out the messages posted by John in his timeline, during the year 2015

MATCH (john:Person {name: 'John'})-[:CREATES]->(t:Timeline)-[:CONTAINS]->(m:Message)
WHERE m.year = 2015
RETURN m.text AS Message, m.timestamp AS PostedAt
ORDER BY m.timestamp;

