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

object MergeAndRemoveDuplicates {
  def main(args: Array[String]): Unit = {
    val list1 = List(1, 2, 3, 4, 5, 2)
    val list2 = List(4, 5, 6, 7, 8, 3)

    println("List 1: " + list1)
    println("List 2: " + list2)

    // Merge the two lists
    var mergedList = list1 ++ list2
    println("Merged List: " + mergedList)

    // Add a new element
    mergedList = mergedList :+ 9
    println("After adding new element (9): " + mergedList)

    // Remove all duplicate elements
    val uniqueList = mergedList.distinct
    println("Final List (after removing duplicates): " + uniqueList)
  }
}

