ssobject HelloWorld{
  def main (args:Array[string]):Unit={
    println("Hello,World!")
  }
}


1.

object checkNumber{
    def main(args: Array[String]) :Unit ={
       val number = -20
        if(number > 0){
            println("positive")
        }else if(number < 0){
            println("negative")
        }else{
            println("zero")
        }
    }
}




2.

import scala.io.StdIn

object secondMaximum{
  def main(args: Array[String]): Unit ={

    print("Enter 1st number: ")
    val num1 = StdIn.readInt()
    print("Enter 2nd number: ")
    val num2 = StdIn.readInt()
    print("Enter 3rd number: ")
    val num3 = StdIn.readInt()
    print("Enter 4th number: ")
    val num4 = StdIn.readInt()

    var max = num1
    var secondMax = num1

    for(i <- 2 to 4){
      val num = if(i == 2) num2 else if(i == 3) num3 else num4

      if(num > max){
        secondMax = max
        max = num
      }
      else if(num > secondMax && num != max){
        secondMax = num
      }
    }

    println(s"The number $secondMax is the second maximum")
  }
}




3.

import scala.io.StdIn
object factorial{
  def main(args: Array[String]): Unit ={
    print("Enter a number - ")
    val n = StdIn.readInt()

    var i = 1
    var factorial = 1

    while (i <= n) {
      factorial = factorial * i
      i += 1
    }

    println(s"Factorial of $n is $factorial")
  }
}




4.

import scala.io.StdIn
object Avg{
  def main(args: Array[String]): Unit ={
    print("Enter From - ")
    var lowerlim = StdIn.readInt()
    print("Enter To - ")
    var upperlim = StdIn.readInt()

    var sum = 0
    var count = 0

    for (i <- lowerlim to upperlim){
      sum = sum + i
      count = count + 1
    }
    val result = sum.toDouble / count
    println(s"The Average of $lowerlim to $upperlim is $result")
  }
}



                    /* -----Set B-------*/
1.

import scala.io.StdIn.readInt

object LeapYear {

  def main(args: Array[String]): Unit = {

    print("Enter a year: ")
    val year = readInt()

    if ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0))
      println(s"$year is a Leap Year")
    else
      println(s"$year is not a Leap Year")
  }
}




2.

import scala.io.StdIn.readInt

object SwapNumbers {

  def main(args: Array[String]): Unit = {

    print("Enter first number: ")
    var a = readInt()

    print("Enter second number: ")
    var b = readInt()

    println(s"Before swapping: a = $a, b = $b")

    // Swapping without using a third variable
    a = a + b
    b = a - b
    a = a - b

    println(s"After swapping: a = $a, b = $b")
  }
}



