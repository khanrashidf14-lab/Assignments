1.
db.Employee.insertMany([
{
Emp_Id:101,
First_Name:"Karan",
Last_Name:"Sharma",
Email:"karan.sharma@company.com",
Phone:"9876543210",
Address:{House_No:"12A",Street:"MG Road",City:"Pune",State:"Maharashtra",Country:"India",Pincode:"411001"},
Salary:55000,
Designation:"Supervisor",
Experience:5,
Date_of_Joining:ISODate("2020-03-15"),
Birthdate:ISODate("1995-03-15")
},

{
Emp_Id:102,
First_Name:"Kavita",
Last_Name:"Patel",
Email:"kavita.patel@company.com",
Phone:"9876543211",
Address:{House_No:"45",Street:"FC Road",City:"Pune",State:"Maharashtra",Country:"India",Pincode:"411004"},
Salary:45000,
Designation:"Developer",
Experience:3,
Date_of_Joining:ISODate("2021-07-01"),
Birthdate:ISODate("1997-11-12")
},

{
Emp_Id:103,
First_Name:"Rahul",
Last_Name:"Verma",
Email:"rahul.verma@company.com",
Phone:"9876543212",
Address:{House_No:"88",Street:"JM Road",City:"Pune",State:"Maharashtra",Country:"India",Pincode:"411005"},
Salary:60000,
Designation:"Supervisor",
Experience:6,
Date_of_Joining:ISODate("2019-01-10"),
Birthdate:ISODate("1993-04-05")
},

{
Emp_Id:104,
First_Name:"Priya",
Last_Name:"Nair",
Email:"priya.nair@company.com",
Phone:"9876543213",
Address:{House_No:"102",Street:"SB Road",City:"Pune",State:"Maharashtra",Country:"India",Pincode:"411006"},
Salary:70000,
Designation:"Analyst",
Experience:7,
Date_of_Joining:ISODate("2018-09-20"),
Birthdate:ISODate("1992-08-15")
},{
Transaction_Id:201,
Transaction_Date:ISODate("2026-01-10"),
Name:"Karan",
Transaction_Details:{Item_Id:"IT01",Item_Name:"Laptop",Quantity:1,Price:50000},
Payment:{Type:"Credit",Total_Amount:50000,Payment_Successful:true},
Remark:""
},



{
Emp_Id:105,
First_Name:"Amit",
Last_Name:"Kulkarni",
Email:"amit.kulkarni@company.com",
Phone:"9876543214",
Address:{House_No:"304",Street:"Kothrud",City:"Pune",State:"Maharashtra",Country:"India",Pincode:"411038"},
Salary:50000,
Designation:"Tester",
Experience:4,
Date_of_Joining:ISODate("2022-02-01"),
Birthdate:ISODate("1996-03-30")
}
]);



2.
db.Transaction.insertMany([
{
Transaction_Id:201,
Transaction_Date:ISODate("2026-01-10"),
Name:"Karan",
Transaction_Details:{Item_Id:"IT01",Item_Name:"Laptop",Quantity:1,Price:50000},
Payment:{Type:"Credit",Total_Amount:50000,Payment_Successful:true},
Remark:""
},

{
Transaction_Id:202,
Transaction_Date:ISODate("2026-01-11"),
Name:"Kavita",
Transaction_Details:{Item_Id:"IT02",Item_Name:"Mouse",Quantity:5,Price:500},
Payment:{Type:"Cash",Total_Amount:2500,Payment_Successful:true},
Remark:"Completed"
},

{
Transaction_Id:203,
Transaction_Date:ISODate("2026-01-12"),
Name:"Rahul",
Transaction_Details:{Item_Id:"IT03",Item_Name:"Keyboard",Quantity:2,Price:1500},
Payment:{Type:"Debit",Total_Amount:3000,Payment_Successful:true},
Remark:""
},

{
Transaction_Id:204,
Transaction_Date:ISODate("2026-01-13"),
Name:"Priya",
Transaction_Details:{Item_Id:"IT04",Item_Name:"Monitor",Quantity:1,Price:15000},
Payment:{Type:"Debit",Total_Amount:50000,Payment_Successful:true},
Remark:"Urgent delivery"
},

{
Transaction_Id:205,
Transaction_Date:ISODate("2026-01-14"),
Name:"Amit",
Transaction_Details:{Item_Id:"IT05",Item_Name:"Printer",Quantity:1,Price:8000},
Payment:{Type:"Debit",Total_Amount:8000,Payment_Successful:false},
Remark:"Payment Failed"
},

{
Transaction_Id:206,
Transaction_Date:ISODate("2026-01-15"),
Name:"Karan",
Transaction_Details:{Item_Id:"IT06",Item_Name:"Desk Chair",Quantity:2,Price:6000},
Payment:{Type:"Cash",Total_Amount:12000,Payment_Successful:true},
Remark:""
},

{
Transaction_Id:207,
Transaction_Date:ISODate("2026-01-16"),
Name:"Kavita",
Transaction_Details:{Item_Id:"IT07",Item_Name:"USB Cable",Quantity:10,Price:200},
Payment:{Type:"Credit",Total_Amount:2000,Payment_Successful:true},
Remark:""
},

{
Transaction_Id:208,
Transaction_Date:ISODate("2026-01-17"),
Name:"Rahul",
Transaction_Details:{Item_Id:"IT08",Item_Name:"Headphones",Quantity:1,Price:3000},
Payment:{Type:"Debit",Total_Amount:3000,Payment_Successful:true},
Remark:"Discount Applied"
},

{
Transaction_Id:209,
Transaction_Date:ISODate("2026-01-18"),
Name:"Priya",
Transaction_Details:{Item_Id:"IT09",Item_Name:"Webcam",Quantity:3,Price:2500},
Payment:{Type:"Credit",Total_Amount:7500,Payment_Successful:true},
Remark:""
},

{
Transaction_Id:210,
Transaction_Date:ISODate("2026-01-19"),
Name:"Amit",
Transaction_Details:{Item_Id:"IT10",Item_Name:"HardDrive",Quantity:2,Price:4000},
Payment:{Type:"Cash",Total_Amount:8000,Payment_Successful:true},
Remark:"Varified"
}
])



3.
db.Employee.find().pretty()
db.Transaction.find().pretty()



4.
db.Employee.updateMany({},{$inc:{Salary:400}})



5.
db.Transcation.updateOne(
{Transaction_Id:201},
{$set:{Remark:"Payment verified and order delivered successfully"}})



6.
db.Employee.updateOne(
{First_Name:"Rahul",Designation:"Supervisor"},
{$set:{Designation:"Manager"}})



7.
db.Employee.updateOne(
{Emp_Id:104},
{$set:{Designation:"Senior Analyst"}})



8.
db.Emplyee.updateOne(
{Emp_Id:105},
{
$set:{
Address:{
House_NO:"501",
Street:"Baner Road",
City:"Pune",
State:"Maharashtra",
Country:"India",
Pincode:"411045"
}}})




9.
db.Transaction.deleteOne(
{
Name:"Rahul",
Transaction_Date:ISODate("2026-01-12")
})



10.
db.Employee.deleteMany(
{First_Name:/^K/i}
)
