db.employees.insertMany([
  {
    _id: 1,
    name: "Joel Guedes",
    designation: "manager",
    salary: 85000,
    department: "Sales"
  },
  {
    _id: 2,
    name: "Gayatri Gawande",
    designation: "floor supervisor",
    salary: 62000,
    department: "Operations"
  },
  {
    _id: 3,
    name: "Ganesh Divase",
    designation: "sales executive",
    salary: 48000,
    department: "Sales"
  },
  {
    _id: 4,
    name: "Vaibhav Jadhav",
    designation: "manager",
    salary: 92000,
    department: "Marketing"
  },
  {
    _id: 5,
    name: "Sneha Yamagar",
    designation: "floor supervisor",
    salary: 58000,
    department: "Operations"
  }
])



db.transactions.insertMany([
  {
    _id: ObjectId(),
    transaction_id: "TXN1001",
    emp_id: 1,                          // Joel Guedes
    amount: 1250,
    payment_type: "Cash",
    date: ISODate("2026-08-15T10:30:00Z"),
    items: [
      { item: "Laptop Bag", quantity: 2 },
      { item: "Wireless Mouse", quantity: 3 }
    ]
  },
  {
    _id: ObjectId(),
    transaction_id: "TXN1002",
    emp_id: 2,                          // Gayatri Gawande
    amount: 450,
    payment_type: "UPI",
    date: ISODate("2026-08-16T14:20:00Z"),
    items: [
      { item: "Notebook", quantity: 5 },
      { item: "Pen Set", quantity: 2 }
    ]
  },
  {
    _id: ObjectId(),
    transaction_id: "TXN1003",
    emp_id: 3,                          // Ganesh Divase
    amount: 780,
    payment_type: "Card",
    date: ISODate("2026-08-18T09:15:00Z"),
    items: [
      { item: "Wireless Mouse", quantity: 4 },
      { item: "USB Cable", quantity: 6 }
    ]
  },
  {
    _id: ObjectId(),
    transaction_id: "TXN1004",
    emp_id: 4,                          // Vaibhav Jadhav
    amount: 2100,
    payment_type: "Cash",
    date: ISODate("2026-08-20T16:45:00Z"),
    items: [
      { item: "Laptop Bag", quantity: 1 },
      { item: "External Hard Disk", quantity: 1 }
    ]
  },
  {
    _id: ObjectId(),
    transaction_id: "TXN1005",
    emp_id: 5,                          // Sneha Yamagar
    amount: 320,
    payment_type: "UPI",
    date: ISODate("2026-08-21T11:10:00Z"),
    items: [
      { item: "Notebook", quantity: 3 },
      { item: "Pen Set", quantity: 4 }
    ]
  }
])




// 1. Managers or Floor Supervisors
db.employees.find({ designation: { $in: ["manager", "floor supervisor"] } })

// 2. Name ending with a specific string (example: ends with "e")
db.employees.find({ name: { $regex: /e$/i } }).pretty()             //$regex: /e$ //searches text using a pattern/ends with e

// 3. Salary > 60000 (using cursor)
const cursor = db.employees.find({ salary: { $gt: 60000 } }, { name: 1, _id: 0 });
cursor.forEach(printjson);

// 4. Sort by designation descending
db.employees.find().sort({ designation: -1 })

// 5. Total employees
db.employees.countDocuments()

// 6. Sum of all transaction amounts
db.transactions.aggregate([
  { $group: { _id: null, totalAmount: { $sum: "$amount" } } }
])

// 7. Sum by payment type
db.transactions.aggregate([
  { $group: { _id: "$payment_type", totalAmount: { $sum: "$amount" } } }
])

// 8. Latest transaction ID
db.transactions.find(
  {},
  { transaction_id: 1, _id: 0 }
).sort({ date: -1 }).limit(1);

// 9. Designations of employees who made transactions > 500
db.transactions.aggregate([
  { $match: { amount: { $gt: 500 } } },    //filters transactions
  { $lookup: {
      from: "employees",
      localField: "emp_Id",
      foreignField: "_id",
      as: "emp"
  }},
  { $unwind: "$emp" },      //turn into individual docs
  { $group: { _id: "$emp.designation" } }
])

// 10. Total quantity of a particular item using Map-Reduce
db.transactions.mapReduce(          //Map function
  function() {
    this.items.forEach(function(i) {
      if (i.item === "Wireless Mouse") {
        emit(i.item, i.quantity);
      }
    });
  },
  function(key, values) {     //Reduce function
    return Array.sum(values);   //Array.sum(values) adds them together
  },
  { out: { inline: 1 } }
)
