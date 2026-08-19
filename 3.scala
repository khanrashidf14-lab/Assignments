import scala.io.StdIn

object NumberConversion {
  // User-defined function: decimal ? binary (as String)
  def toBinary(n: Int): String = {
    if (n == 0) return "0"
    var num = Math.abs(n)
    var binary = ""
    while (num > 0) {
      binary = (num % 2).toString + binary
      num /= 2
    }
    if (n < 0) "-" + binary else binary
  }

  // User-defined function: decimal ? octal (as String)
  def toOctal(n: Int): String = {
    if (n == 0) return "0"
    var num = Math.abs(n)
    var octal = ""
    while (num > 0) {
      octal = (num % 8).toString + octal
      num /= 8
    }
    if (n < 0) "-" + octal else octal
  }

  def main(args: Array[String]): Unit = {
    print("Enter an integer: ")
    val number = StdIn.readInt()

    println(s"Binary  of $number = ${toBinary(number)}")
    println(s"Octal   of $number = ${toOctal(number)}")
  }
}