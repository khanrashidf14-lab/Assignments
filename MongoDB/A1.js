db.Film.insertMany([
{
filmId:1,
title:"Inception",
year:2010,
genre:["Action","Sci-Fi"],
actors:[
{firstName:"Leonardo",lastName:"DiCaprio"},
{firstName:"Joseph",lastName:"Gordon-Levitt"}
],
directors:[
{firstName:"Christopher",lastName:"Nolan"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("2010-07-16"),rating:8.8},
{place:"India",releaseDate:ISODate("2010-07-16"),rating:8.7}
]
},

 //---Multi-release
{
filmId:2,
title:"Avatar",
year:2009,
genre:["Action","Sci-Fi","Adventure"],
actors:[
{firstName:"Sam",lastName:"Worthington"},
{firstName:"Zoe",lastName:"Saldana"}
],
directors:[
{firstName:"James",lastName:"Cameron"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("2009-12-18"),rating:7.9},
{place:"UK",releaseDate:ISODate("2009-12-17"),rating:8.0}
]
},

 //Same year
{
filmId:3,
title:"Pulp Fiction",
year:1994,
genre:["Crime","Drama"],
actors:[
{firstName:"John",lastName:"Travolta"},
{firstName:"Uma",lastName:"Thurman"}
],
directors:[
{firstName:"Quentin",lastName:"Tarantino"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("1994-10-14"),rating:8.9}
]
},

{
filmId:4,
title:"The Shawshank Redemption",
year:1994,
genre:["Drama"],
actors:[
{firstName:"Tim",lastName:"Robbins"},
{firstName:"Morgan",lastName:"Freeman"}
],
directors:[
{firstName:"Frank",lastName:"Darabont"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("1994-09-23"),rating:9.3}
]
},

{
filmId:5,
title:"Forest Gump",
year:1994,
genre:["Crime","Romance"],
actors:[
{firstName:"Tom",lastName:"Hanks"},
{firstName:"Robin",lastName:"Wright"}
],
directors:[
{firstName:"Robert",lastName:"Zemeckis"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("1994-07-06"),rating:8.8}
]
},

 //two films directed by the same director
{
filmId:6,
title:"The Dark Knight",
year:2008,
genre:["Action","Crime","Drama"],
actors:[
{firstName:"Christian",lastName:"Bale"},
{firstName:"Heath",lastName:"Ledger"}
],
directors:[
{firstName:"Christopher",lastName:"Nolan"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("2008-07-18"),rating:9.0}
]
}, 

{
filmId:7,
title:"Intersteller",
year:2018,
genre:["Adventure","Drama","Sci-Fi"],
actors:[
{firstName:"Matthew",lastName:"McConaughey"},
{firstName:"Anne",lastName:"Hathaway"}
],
directors:[
{firstName:"Christopher",lastName:"Nolan"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("2014-11-07"),rating:8.7}
]
},

{
filmId:8,
title:"Dil to pagal hai",
year:1997,
genre:["Romance","Drama","Musical"],
actors:[
{firstName:"Shah Rukh",lastName:"Khan"},
{firstName:"Madhuri",lastName:"Dixit"}
],
directors:[
{firstName:"Yash",lastName:"Chopra"}
],
releaseDetails:[
{place:"India",releaseDate:ISODate("1997-10-30"),rating:7.8}
]
},

{
filmId:9,
title:"Devdas",
year:2002,
genre:["Romance","Drama"],
actors:[
{firstName:"Shah Rukh",lastName:"Khan"},
{firstName:"Madhuri",lastName:"Dixit"}
],
directors:[
{firstName:"Sanjay leela",lastName:"Bhansali"}
],
releaseDetails:[
{place:"India",releaseDate:ISODate("2002-07-12"),rating:7.6},
{place:"UK",releaseDate:ISODate("2002-07-12"),rating:7.5}
]
},

{
filmId:10,
title:"Titanic",
year:1997,
genre:["Romance","Drama"],
actors:[
{firstName:"Leonardo",lastName:"DiCaprio"},
{firstName:"KAte",lastName:"Winslet"}
],
directors:[
{firstName:"James",lastName:"Cameron"}
],
releaseDetails:[
{place:"USA",releaseDate:ISODate("1997-12-19"),rating:7.9}
]
}
]);




db.Actor.insertMany([
{
actorId:1,
firstName:"Leonardo",
lastName:"DiCaprio",
address:{
street:"123 Hollywood Blvd",
city:"Los Angeles",
state:"California",
country:"USA",
pinCode:"90028"
},
contactDetails:{
email:"leo@example.com",
phone:"+1-310-555-0101"
},
age:51
},

{
actorId:2,
firstName:"Shah Rukh",
lastName:"Khan",
address:{
street:"Mannat,Bandstand",
city:"Mumbai",
state:"Maharashtra",
country:"India",
pinCode:"400050"
},
contactDetails:{
email:"srk@example.com",
phone:"+91-98200-00001"
},
age:60
},

{
actorId:3,
firstName:"Madhuri",
lastName:"Dixit",
address:{
street:"Pali Hill",
city:"Mumbai",
state:"Maharashtra",
country:"India",
pinCode:"400050"
},
contactDetails:{
email:"Madhu@example.com",
phone:"+1-110-655-0101"
},
age:58
},

{
actorId:4,
firstName:"Christian",
lastName:"Bale",
address:{
street:"456 Sunset Ave",
city:"Los Angeles",
state:"California",
country:"USA",
pinCode:"90046"
},
contactDetails:{
email:"bale@example.com",
phone:"+1-310-555-0104"
},
age:51
},

{
actorId:5,
firstName:"Tom",
lastName:"Hanks",
address:{
street:"789 Pacific Coast Hwy",
city:"Malibu",
state:"California",
country:"USA",
pinCode:"90265"
},
contactDetails:{
email:"tomhanks@example.com",
phone:"+1-310-555-0105"
},
age:69
},

{
actorId:6,
firstName:"Morgan",
lastName:"Freeman",
address:{
street:"101 Missippi Rd",
city:"Charleston",
state:"Mississippi",
country:"USA",
pinCode:"38921"
},
contactDetails:{
email:"morgan@example.com",
phone:"+1-662-555-0106"
},
age:88
},

{
actorId:7,
firstName:"Matthew",
lastName:"McConaughey",
address:{
street:"222 Austin St",
city:"Austin",
state:"Texas",
country:"USA",
pinCode:"78701"
},
contactDetails:{
email:"matthew@example.com",
phone:"+1-512-555-0107"
},
age:56
},

{
actorId:8,
firstName:"Kate",
lastName:"Winslet",
address:{
street:"33 Reading Rd",
city:"Reading",
state:"Berkshire",
country:"UK",
pinCode:"RGI IAA"
},
contactDetails:{
email:"kate@example.com",
phone:"+44-118-555-0108"
},
age:50
},

{
actorId:9,
firstName:"John",
lastName:"Travolta",
address:{
street:"55 Englewood Dr",
city:"Englewood",
state:"Florida",
country:"USA",
pinCode:"34223"
},
contactDetails:{
email:"travolta@example.com",
phone:"+1-941-555-0109"
},
age:71
},

{
actorId:10,
firstName:"Uma",
lastName:"Thurman",
address:{
street:"77 Boston Ave",
city:"Boston",
state:"Massachusetts",
country:"USA",
pinCode:"02108"
},
contactDetails:{
email:"uma@example.com",
phone:"+1-617-555-0110"
},
age:55
}
]);



3.
db.Film.find().pretty()
db.Actor.find().pretty()




4.
db.Film.updateMany(
{title:/^T/},
{$inc:{"releaseDetails.$[].rating":0.5}}
)




5.
db.Actor.insertOne({
ActorId:11,
firstName:"Aamir",
lastName:"Khan",
address:{
street:"Pali Hill Road",
city:"Mumbai",
state:"Maharashtra",
country:"India",
pinCode:"400050"
},
contactDetails:{
email:"aamir@example.com",
phone:"+90-98200-00011"
},
age:60
})

db.Film.insertOne({
FilmId:11,
title:"3 Idiots",
year:2009,
genre:["Comedy","Drama"],
actors:[
{firstName:"Aamir",lastName:"Khan"},
{firstName:"Sharman",lastName:"Joshi"}
],
directors:[
{firstName:"Rajkumar",lastName:"Hirani"}
],
releaseDetails:[
{place:"India",releaseDate:ISODate("2009-12-25"),rating:8.4},
]
})





6.
db.Film.deleteOne({
title:"Pulp Fiction"
})





7. 
db.Actor.deleteOne({
firstName:"Uma",lastName:"Thurman"
})




8.
db.Actor.deleteMany({
age:{$gt:70
}})





9.
db.Actor.updateOne(
{actorId:2},
{
$set:{
"address.street":"Sea View Apartment,Bandstand",
"address.city":"Mumbai",
"address.state":"Maharashtra",
"address.country":"India",
"address.pinCode":"400050"
}})




10.
db.Film.updateMany(
{"directors.firstName":"Christopher","directors.lastName":"Nolan"},
{$addToSet:{genre:"Thriller"}}
)


