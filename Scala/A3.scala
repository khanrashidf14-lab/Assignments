1.
object UppercaseCount {
  def main(args: Array[String]): Unit = {
    val input = "Hello World! Scala is AWESOME."
    
    val uppercaseCount = input.count(_.isUpper)
    val lowerString = input.toLowerCase
    
    println(s"Original string: $input")
    println(s"Number of uppercase letters: $uppercaseCount")
    println(s"String in lowercase: $lowerString")
  }
}





2.
object CharCount {
  def main(args: Array[String]): Unit = {
    val str = "Hello World! Welcome to Scala programming."
    print("Enter a character to count: ")
    val ch = scala.io.StdIn.readChar()
    
    val count = str.count(_ == ch)
    
    println(s"The character '$ch' appears $count time(s) in the string.")
  }
}







3.
object RemoveChar {
  def removeCharAt(str: String, pos: Int): String = {
    if (pos < 0 || pos >= str.length) {
      println(s"Invalid position! Position must be between 0 and ${str.length - 1}")
      str   // return original string if invalid
    } else {
      str.take(pos) + str.drop(pos + 1) //for getting only required output
    }
  }

  def main(args: Array[String]): Unit = {
    val original = "ScalaProgramming"
    println(s"Original string: $original")
    
    // Valid position
    val result1 = removeCharAt(original, 5)
    println(s"After removing char at position 5: $result1")
    
    // Invalid position
    val result2 = removeCharAt(original, 20)
    println(s"After invalid position: $result2")
  }
}








4.
object PalindromeCheck {
  def isPalindrome(str: String): Boolean = {
    val cleaned = str.toLowerCase.filter(_.isLetterOrDigit)  // optional cleaning
    cleaned match {
      case s if s.length <= 1 => true
      case s if s.head != s.last => false
      case s => isPalindrome(s.substring(1, s.length - 1))
    }
  }

  def main(args: Array[String]): Unit = {
    val testStrings = List("Madam", "Hello", "A man a plan a canal Panama", "12321", "Scala")

    testStrings.foreach { s =>
      val result = if (isPalindrome(s)) "is a palindrome" else "is NOT a palindrome"
      println(s"\"$s\" $result")
    }
  }
}




/* -------Set B---------*/

1.

import scala.io.StdIn.readLine

object VowelsConsonants {

  // User-defined function to count vowels and consonants
  def countVowelsConsonants(str: String): (Int, Int) = {
    var vowels = 0
    var consonants = 0

    for (ch <- str.toLowerCase) {
      if ("aeiou".contains(ch))
        vowels += 1
      else if (ch >= 'a' && ch <= 'z')
        consonants += 1
    }

    (vowels, consonants)
  }

  def main(args: Array[String]): Unit = {

    print("Enter a string: ")
    val str = readLine()

    val (vowels, consonants) = countVowelsConsonants(str)

    println(s"Total number of vowels: $vowels")
    println(s"Total number of consonants: $consonants")
  }
}





2.

import scala.io.StdIn.readLine

object ReplaceCharacters {

  def main(args: Array[String]): Unit = {

    print("Enter a string: ")
    val str = readLine()

    val result = str.map(_ => '-')

    println("String after replacing characters: " + result)
  }
}


