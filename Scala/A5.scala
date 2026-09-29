1.

object ListOperations {
  def main(args: Array[String]): Unit = {
    // Create an initial List
    var numbers = List(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    println("Original List: " + numbers)

    // Add 3 new elements
    numbers = numbers :+ 11 :+ 12 :+ 13
    println("After adding 3 elements: " + numbers)

    // Remove all even numbers
    val oddNumbers = numbers.filter(_ % 2 != 0)
    println("Final List (after removing even numbers): " + oddNumbers)
  }
}



2.

import scala.io.StdIn

object RemoveElement {
  def main(args: Array[String]): Unit = {
    var numbers = List(10, 20, 30, 40, 50, 60, 70)
    println("Original List: " + numbers)

    // Remove by value
    print("Enter the value to remove: ")
    val valueToRemove = StdIn.readInt()
    val afterValueRemoval = numbers.filter(_ != valueToRemove)
    println("List after removing value " + valueToRemove + ": " + afterValueRemoval)

    // Remove by index
    print("Enter the index to remove: ")
    val indexToRemove = StdIn.readInt()
    if (indexToRemove >= 0 && indexToRemove < numbers.length) {
      val afterIndexRemoval = numbers.patch(indexToRemove, Nil, 1)
      println("List after removing index " + indexToRemove + ": " + afterIndexRemoval)
    } else {
      println("Invalid index!")
    }
  }
}


3.

object MaxMinArray {
  def main(args: Array[String]): Unit = {
    val arr = Array(45, 12, 78, 3, 90, 21, 56)
    println("Array: " + arr.mkString(", "))

    val max = arr.max
    val min = arr.min

    println("Maximum element: " + max)
    println("Minimum element: " + min)
  }
}


4.

object SeparateEvenOdd {
  def main(args: Array[String]): Unit = {
    val arr = Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    println("Original Array: " + arr.mkString(", "))

    val evenList = arr.filter(_ % 2 == 0).toList
    val oddList  = arr.filter(_ % 2 != 0).toList

    println("Even numbers List: " + evenList)
    println("Odd numbers List : " + oddList)
  }
}


/*  ---------set B----------  */

1.

import scala.io.StdIn

object SearchElement {
  def main(args: Array[String]): Unit = {
    val arr = Array(10, 25, 37, 42, 58, 63, 79, 85)
    println("Array: " + arr.mkString(", "))

    print("Enter the element to search: ")
    val key = StdIn.readInt()

    val index = arr.indexOf(key)

    if (index != -1) {
      println(s"Element $key found at index position: $index")
    } else {
      println(s"Element $key is not present in the array.")
    }
  }
}


2.

import scala.io.StdIn

object MergeList{
  def main(args: Array[String]): Unit = {

    print("Enter size of List 1: ")
    val n1 = StdIn.readInt()

    var list1 = List[Int]()
    var i = 0

    while (i < n1) {
      print("Enter element " + (i + 1) + ": ")
      list1 = list1 :+ StdIn.readInt()
      i += 1
    }

    print("Enter size of List 2: ")
    val n2 = StdIn.readInt()

    var list2 = List[Int]()
    i = 0

    while (i < n2) {
      print("Enter element " + (i + 1) + ": ")
      list2 = list2 :+ StdIn.readInt()
      i += 1
    }

    println("List 1: " + list1)
    println("List 2: " + list2)

    print("Enter a new element: ")
    val element = StdIn.readInt()

    val merged = list1 ++ list2 :+ element

    var result = List[Int]()
    i = 0

    while (i < merged.length) {
      var count = 0
      var j = 0

      while (j < merged.length) {
        if (merged(i) == merged(j)) {
          count += 1
        }
        j += 1
      }

      if (count == 1) {
        result = result :+ merged(i)
      }

      i += 1
    }

    println("Final List: " + result)
  }
}
