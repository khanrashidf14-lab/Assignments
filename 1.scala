import scala.util.Random
import scala.io.StdIn

object PerfectNumbers {
  // User-defined function to check if a number is perfect
  def isPerfect(n: Int): Boolean = {
    if (n <= 1) return false
    var sum = 0
    for (i <- 1 until n) {
      if (n % i == 0) sum += i
    }
    sum == n
  }

  def main(args: Array[String]): Unit = {
    val rand = new Random()
    println("Five random numbers and perfect-number check:")
    
    for (i <- 1 to 5) {
      val num = rand.nextInt(1000) + 1   // random number in 1..1000
      val result = if (isPerfect(num)) "Perfect" else "Not Perfect"
      println(s"$i. Number = $num  -->  $result")
    }
  }
}