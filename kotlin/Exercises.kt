import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException


fun change(amount: Long): Map<Int, Long> {
    require(amount >= 0) { "Amount cannot be negative" }
    
    val counts = mutableMapOf<Int, Long>()
    var remaining = amount
    for (denomination in listOf(25, 10, 5, 1)) {
        counts[denomination] = remaining / denomination
        remaining %= denomination
    }
    return counts
}


fun firstThenLowerCase(strings: List<String>, predicate: (String) -> Boolean): String? {
    return strings.firstOrNull(predicate)?.lowercase()
}


data class Say(val phrase: String) {
    fun and(nextPhrase: String): Say {
        return Say("$phrase $nextPhrase")
    }
}

fun say(phrase: String = ""): Say {
    return Say(phrase)
}


@Throws(IOException::class)
fun meaningfulLineCount(filename: String): Long {
    BufferedReader(FileReader(filename)).use { reader ->
        return reader.lines()
        .filter { it.trim().isNotEmpty() }
        .filter { !it.trim().startsWith("#") } 
        .count()
    }
}


data class Quaternion(val a: Double, val b: Double, val c: Double, val d: Double) {
    
    companion object {
        val ZERO = Quaternion(0.0, 0.0, 0.0, 0.0)
        val I = Quaternion(0.0, 1.0, 0.0, 0.0)
        val J = Quaternion(0.0, 0.0, 1.0, 0.0)
        val K = Quaternion(0.0, 0.0, 0.0, 1.0)
    }
    
    operator fun plus(other: Quaternion): Quaternion {
        return Quaternion(a + other.a, b + other.b, c + other.c, d + other.d)
    }
    
    operator fun times(other: Quaternion): Quaternion {
        return Quaternion(
            a * other.a - b * other.b - c * other.c - d * other.d, 
            a * other.b + b * other.a + c * other.d - d * other.c,
            a * other.c - b * other.d + c * other.a + d * other.b,
            a * other.d + b * other.c - c * other.b + d * other.a
        )
    }

    fun coefficients(): List<Double> = listOf(a, b, c, d)

    fun conjugate(): Quaternion = Quaternion(a, -b, -c, -d)

// used https://kotlinlang.org/docs/control-flow.html#when-expression to help me with the when statement
    override fun toString(): String {
        fun components(num: Double, letter: String): String {
            return when {
                num == -1.0 -> "-$letter" 
                num == 0.0 -> ""
                num == 1.0 -> "+$letter"
                num > 0 -> "+$num$letter"
                else -> "$num$letter"
            }
        }
        
    var result = ""
    if (a != 0.0) {
        result = a.toString()
    }

    var bComponent = components(b, "i")
    var cComponent = components(c, "j")
    var dComponent = components(d, "k")

    result += bComponent + cComponent + dComponent
  
    return if (result.isEmpty()) "0" else result.replace("+-", "-").trimStart('+')
    }
}
    

sealed interface BinarySearchTree {
    fun size(): Int
    fun contains(value: String): Boolean
    fun insert(value: String): BinarySearchTree

    object Empty : BinarySearchTree {
        override fun size(): Int = 0
        override fun contains(value: String): Boolean = false
        override fun insert(value: String): BinarySearchTree = Node(value, Empty, Empty)
        override fun toString(): String = "()"
    }

    data class Node(private val value: String, private val left: BinarySearchTree, private val right: BinarySearchTree) : BinarySearchTree {
        override fun size(): Int = 1 + left.size() + right.size()
        override fun contains(value: String): Boolean = when {
            value < this.value -> left.contains(value)
            value > this.value -> right.contains(value)
            else -> true 
        }

        override fun insert(value: String): BinarySearchTree = when {
            value < this.value -> Node(this.value, left.insert(value), right)
            value > this.value -> Node(this.value, left, right.insert(value))
            else -> this
        }

        override fun toString(): String {
            var leftString = left.toString()
            var rightString = right.toString()
            return "($leftString$value$rightString)".replace("()","")
        }
    } 
    
}  
