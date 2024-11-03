import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Optional;
import java.util.function.Predicate;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class Exercises {
    static Map<Integer, Long> change(long amount) {
        if (amount < 0) {
            throw new IllegalArgumentException("Amount cannot be negative");
        }
        var counts = new HashMap<Integer, Long>();
        for (var denomination : List.of(25, 10, 5, 1)) {
            counts.put(denomination, amount / denomination);
            amount %= denomination;
        }
        return counts;
    }

    public static Optional <String> firstThenLowerCase(List<String> strings, Predicate<String> predicate) {
        return strings.stream()
                .filter(predicate)
                .findFirst()
                .map(String::toLowerCase);
    }


    static record Sayer(String phrase){
        Sayer and(String word){
            return new Sayer(phrase + " " + word); 
        }
    }

    public static Sayer say(){
        return new Sayer("");
    }

    public static Sayer say(String word) {
        return new Sayer(word);  
    } 
  

    
    public static int meaningfulLineCount(String filename) throws IOException {
        try (var reader = new BufferedReader(new FileReader(filename))){
            return (int) reader.lines()
                    .filter(line -> !line.trim().isBlank() && !line.trim().startsWith("#"))
                    .count();
        }
    }

}


record Quaternion (double a, double b, double c, double d) {

    public final static Quaternion ZERO = new Quaternion(0, 0, 0, 0);
    public final static Quaternion I = new Quaternion(0, 1, 0, 0);
    public final static Quaternion J = new Quaternion(0, 0, 1, 0);
    public final static Quaternion K = new Quaternion(0, 0, 0, 1);

    public Quaternion {
        if(Double.isNaN(a) || Double.isNaN(b) || Double.isNaN(c) || Double.isNaN(d)) {
            throw new IllegalArgumentException("Coefficients cannot be NaN");
        }
    }

    Quaternion plus(Quaternion other) {
        return new Quaternion(a + other.a, b + other.b, c + other.c, d + other.d);
    }

    Quaternion times(Quaternion other) {
        return new Quaternion(
                a * other.a - b * other.b - c * other.c - d * other.d, 
                a * other.b + b * other.a + c * other.d - d * other.c, 
                a * other.c - b * other.d + c * other.a + d * other.b, 
                a * other.d + b * other.c - c * other.b + d * other.a);
    }

    public Quaternion conjugate() {
        return new Quaternion (a, -b, -c, -d);
    }

    public List<Double> coefficients() {
        return List.of(a, b, c, d);
    }

    @Override 
    public String toString() {
        String str = "";
        
        if (a != 0) {
            str += a;
        }
        
        if (b != 0) {
            str += (str.isEmpty() ? "" : (b > 0 ? "+" : "")) + (b == 1 ? "i" : (b == -1 ? "-i" : b + "i"));
        }
    
        if (c != 0) {
            str += (str.isEmpty() ? "" : (c > 0 ? "+" : "")) + (c == 1 ? "j" : (c == -1 ? "-j" : c + "j"));
        }
    
        if (d != 0) {
            str += (str.isEmpty() ? "" : (d > 0 ? "+" : "")) + (d == 1 ? "k" : (d == -1 ? "-k" : d + "k"));
        }
        
        return str.isEmpty() ? "0" : str.replace("+-", "-");
    }
}


sealed interface BinarySearchTree permits Empty, Node {
    int size();
    boolean contains(String value);
    BinarySearchTree insert(String value);
}

final record Empty() implements BinarySearchTree {
    @Override
    public int size() {
        return 0;
    }

    @Override
    public boolean contains(String value) {
        return false;
    }

    @Override
    public BinarySearchTree insert(String value) {
        return new Node(value, this, this);
    }

    @Override
    public String toString() {
        return "()";
    }
}

final class Node implements BinarySearchTree {
    private final String value;
    private final BinarySearchTree left;
    private final BinarySearchTree right;

    Node(String value, BinarySearchTree left, BinarySearchTree right) {
        this.value = value;
        this.left = left;
        this.right = right;
    }

    @Override
    public int size() {
        return 1 + left.size() + right.size();
    }

    @Override
    public boolean contains(String value) {
        return this.value.equals(value) || left.contains(value) || right.contains
        (value);
    }

    @Override
    public BinarySearchTree insert(String value) {
        if (value.compareTo(this.value) < 0) {
            return new Node(this.value, left.insert(value), right);
        } else {
            return new Node(this.value, left, right.insert(value));
        }
    }

    @Override
    public String toString() {
        String leftStr;
        String rightStr;
        if (left instanceof Empty()) {
            leftStr = "";
        } else{
            leftStr = left.toString();
        }

        if (right instanceof Empty()) {
            rightStr = "";
        } else{
            rightStr = right.toString();
        }

        return "(" + leftStr + value + rightStr + ")";
    }

}
