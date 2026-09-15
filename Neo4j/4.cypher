1.

// Optional clean-up
MATCH (n) DETACH DELETE n;

// ===== Nodes =====
// Authors / Persons
CREATE (a1:Person:Author {
  name: 'John le Carré',
  born: date('1931-10-19'),
  nationality: 'British'
})

CREATE (a2:Person:Author {
  name: 'Graham Greene',
  born: date('1904-10-02'),
  died: date('1991-04-03'),
  nationality: 'British'
})

// Readers
CREATE (r1:Person:Reader {name: 'Alan', memberId: 'R001'})
CREATE (r2:Person:Reader:Author {name: 'Ian', memberId: 'R002'})

// Books
CREATE (b1:Book {
  title: 'Tinker Tailor Soldier Spy',
  published: 1974,
  tags: ['spy', 'cold war', 'thriller'],
  status: 'available',
  condition: 'good',
  cost: 12.99,
  type: 'Novel'
})

CREATE (b2:Book {
  title: 'Our Man in Havana',
  published: 1958,
  tags: ['spy', 'satire', 'cuba'],
  status: 'available',
  condition: 'new',
  cost: 9.50,
  type: 'Novel'
})

// Publisher
CREATE (p:Publisher {name: 'Hodder & Stoughton', country: 'UK'})

// ===== Relationships =====
CREATE (a1)-[:WROTE {year: 1974}]->(b1)
CREATE (a2)-[:WROTE {year: 1958}]->(b2)

CREATE (b1)-[:PUBLISHED_BY {year: 1974}]->(p)
CREATE (b2)-[:PUBLISHED_BY {year: 1958}]->(p)

CREATE (r1)-[:RECOMMENDED {date: date('2011-07-05'), rating: 5}]->(b1)
CREATE (r1)-[:RECOMMENDED {date: date('2011-09-09'), rating: 4}]->(b2)
CREATE (r2)-[:RECOMMENDED {date: date('2011-02-03'), rating: 5}]->(b1)

CREATE (r1)-[:ISSUED_BY {date: date('2023-01-15')}]->(b1)
CREATE (r1)-[:RETURNED_BY {date: date('2023-02-10')}]->(b1);


2.

MATCH (n) DETACH DELETE n;

// Artists
CREATE (ar1:Artist {name: 'The Beatles', formed: 1960, country: 'UK'})
CREATE (ar2:Artist {name: 'Adele', born: 1988, country: 'UK'})

// Song authors / writers
CREATE (w1:SongAuthor {name: 'John Lennon'})
CREATE (w2:SongAuthor {name: 'Paul McCartney'})
CREATE (w3:SongAuthor {name: 'Adele Adkins'})

// Songs
CREATE (s1:Song {title: 'Hey Jude', year: 1968, duration: '7:11', genre: 'Rock'})
CREATE (s2:Song {title: 'Someone Like You', year: 2011, duration: '4:45', genre: 'Pop'})

// Recording Studio & Company
CREATE (st:RecordingStudio {name: 'Abbey Road Studios', location: 'London'})
CREATE (rc:RecordingCompany {name: 'EMI', founded: 1931})

// Relationships
CREATE (ar1)-[:PERFORMS]->(s1)
CREATE (ar2)-[:PERFORMS]->(s2)

CREATE (s1)-[:WRITTEN_BY]->(w1)
CREATE (s1)-[:WRITTEN_BY]->(w2)
CREATE (s2)-[:WRITTEN_BY]->(w3)

CREATE (s1)-[:RECORDED_IN {year: 1968}]->(st)
CREATE (s2)-[:RECORDED_IN {year: 2010}]->(st)

CREATE (st)-[:MANAGED_BY]->(rc)
CREATE (rc)-[:FINANCES {budget: 50000}]->(s1)
CREATE (rc)-[:FINANCES {budget: 120000}]->(s2);



3.

MATCH (n) DETACH DELETE n;

// Departments
CREATE (d1:Department {name: 'Engineering', location: 'Building A'})
CREATE (d2:Department {name: 'Marketing', location: 'Building B'})

// Employees
CREATE (e1:Employee {name: 'Alice Chen', empId: 'E1001', joinDate: date('2019-03-15')})
CREATE (e2:Employee {name: 'Bob Smith', empId: 'E1002', joinDate: date('2020-07-01')})
CREATE (e3:Employee {name: 'Carol Diaz', empId: 'E1003', joinDate: date('2018-11-20')})

// Skills
CREATE (sk1:Skillset {name: 'Python', level: 'Expert'})
CREATE (sk2:Skillset {name: 'Project Management', level: 'Advanced'})
CREATE (sk3:Skillset {name: 'Digital Marketing', level: 'Intermediate'})

// Projects
CREATE (p1:Project {name: 'Neo4j Migration', startDate: date('2024-01-10'), status: 'Active'})
CREATE (p2:Project {name: 'Q3 Campaign', startDate: date('2024-06-01'), status: 'Planning'})

// Relationships
CREATE (e1)-[:WORKS_IN {role: 'Senior Developer'}]->(d1)
CREATE (e2)-[:WORKS_IN {role: 'Developer'}]->(d1)
CREATE (e3)-[:WORKS_IN {role: 'Marketing Lead'}]->(d2)

CREATE (e1)-[:HAS_ACQUIRED {since: 2018}]->(sk1)
CREATE (e1)-[:HAS_ACQUIRED {since: 2021}]->(sk2)
CREATE (e3)-[:HAS_ACQUIRED {since: 2019}]->(sk3)

CREATE (e1)-[:ASSIGNED_TO {allocation: 80}]->(p1)
CREATE (e2)-[:ASSIGNED_TO {allocation: 100}]->(p1)
CREATE (e3)-[:ASSIGNED_TO {allocation: 60}]->(p2)

CREATE (p1)-[:CONTROLLED_BY]->(d1)
CREATE (p2)-[:CONTROLLED_BY]->(d2)

CREATE (e1)-[:PROJECT_MANAGER {since: date('2024-01-10')}]->(p1);


4.

MATCH (n) DETACH DELETE n;

// People
CREATE (a1:Actor {name: 'Leonardo DiCaprio', born: 1974})
CREATE (a2:Actor {name: 'Kate Winslet', born: 1975})
CREATE (d1:Director {name: 'Christopher Nolan', born: 1970})
CREATE (p1:Producer {name: 'Emma Thomas'})
CREATE (f1:Financier {name: 'Warner Bros.', type: 'Studio'})

// Movies
CREATE (m1:Movie {title: 'Inception', year: 2010, runtime: 148, genre: ['Sci-Fi', 'Thriller']})
CREATE (m2:Movie {title: 'Titanic', year: 1997, runtime: 195, genre: ['Drama', 'Romance']})

// Roles
CREATE (r1:Role {character: 'Dom Cobb'})
CREATE (r2:Role {character: 'Rose DeWitt Bukater'})

// Relationships
CREATE (a1)-[:ACTED_IN {role: 'Dom Cobb'}]->(m1)
CREATE (a1)-[:PLAYED]->(r1)
CREATE (r1)-[:IN_MOVIE]->(m1)

CREATE (a2)-[:ACTED_IN {role: 'Rose'}]->(m2)
CREATE (a2)-[:PLAYED]->(r2)
CREATE (r2)-[:IN_MOVIE]->(m2)

CREATE (d1)-[:DIRECTED {year: 2010}]->(m1)
CREATE (p1)-[:PRODUCED]->(m1)
CREATE (f1)-[:FINANCED {budget: 160000000}]->(m1)

CREATE (a1)-[:ACTED_IN]->(m2);   // also in Titanic


5.

MATCH (n) DETACH DELETE n;

// Persons
CREATE (p1:Person {name: 'Alice', age: 28, city: 'Mumbai'})
CREATE (p2:Person {name: 'Bob', age: 32, city: 'Delhi'})
CREATE (p3:Person {name: 'Carol', age: 25, city: 'Bangalore'})

// Affiliations & Groups
CREATE (aff1:Affiliation {name: 'IIIT Hyderabad', type: 'University'})
CREATE (g1:Group {name: 'Neo4j Enthusiasts', privacy: 'public'})
CREATE (g2:Group {name: 'Photography Club', privacy: 'private'})

// Stories & Timeline
CREATE (s1:Story {content: 'Just finished Assignment 4!', created: datetime()})
CREATE (s2:Story {content: 'Beautiful sunset today', created: datetime()})
CREATE (t1:Timeline {owner: 'Alice'})
CREATE (msg1:Message {text: 'Great work!', timestamp: datetime()})

// Relationships
CREATE (p1)-[:FRIEND_OF {since: 2019}]->(p2)
CREATE (p1)-[:FRIEND_OF {since: 2021}]->(p3)
CREATE (p2)-[:FRIEND_OF]->(p3)

CREATE (p1)-[:AFFILIATED_TO {role: 'Alumnus'}]->(aff1)
CREATE (p2)-[:AFFILIATED_TO {role: 'Student'}]->(aff1)

CREATE (p1)-[:BELONGS_TO {joined: date('2023-05-10')}]->(g1)
CREATE (p2)-[:BELONGS_TO]->(g1)
CREATE (p3)-[:BELONGS_TO]->(g2)

CREATE (p1)-[:CREATE]->(s1)
CREATE (s1)-[:REFERS_TO]->(p2)

CREATE (p1)-[:CREATES]->(t1)
CREATE (t1)-[:REFERENCE_FOR]->(s1)
CREATE (t1)-[:CONTAINS]->(msg1);

