object SumOfPrimes {
  // User-defined function to check primality
  def isPrime(n: Int): Boolean = {
    if (n <= 1) return false
    if (n == 2) return true
    if (n % 2 == 0) return false
    var i = 3
    while (i * i <= n) {
      if (n % i == 0) return false
      i += 2
    }
    true
  }

  def main(args: Array[String]): Unit = {
    var sum = 0
    for (num <- 1 to 100) {
      if (isPrime(num)) {
        sum += num
        // optional: print the primes
        // print(s"$num ")
      }
    }
    println(s"\nSum of prime numbers between 1 and 100 = $sum")
  }
}