# Assignments
All about lab codes
All u c here is lab codes. 

scala:
" export PATH=/opt/scala3-3.3.6/bin:$PATH "

"cd /home/fymsc38/scala/A5" -to change directory


create(f:Film{id:101,title:'Titanic',year_of_release:date('2014'),genre:['Romantic','biographic'],actors:['Elon Musk','sophie jhonson'],director:'Christopher Nolan',release_details:date('2014-02-23')})


create(a:Actor{id:1,first_name:'Elon',Last_Name:'Musk',street:101,City:'NewYork',State:'Maharashtra',Country:'Africa',Pincode:411006,contact_details:['leo@gmail.com','1234567890'],age_of_actor:74})


create (a:Elon_Musk)-[:Performed_in]->(f:Titanic)
