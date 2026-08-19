import scala.io.StdIn

object FibonacciSeries {
  // User-defined function that prints Fibonacci numbers = limit
  def printFibonacciUpTo(limit: Int): Unit = {
    if (limit < 0) {
      println("Please enter a non-negative number.")
      return
    }

    var a = 0
    var b = 1
    print("Fibonacci series up to $limit: ")

    if (a <= limit) print(s"$a ")
    while (b <= limit) {
      print(s"$b ")
      val next = a + b
      a = b
      b = next
    }
    println()
  }

  def main(args: Array[String]): Unit = {
    print("Enter the upper limit for Fibonacci series: ")
    val limit = StdIn.readInt()
    printFibonacciUpTo(limit)
  }
}