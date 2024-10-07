import Foundation

struct NegativeAmountError: Error {}
struct NoSuchFileError: Error {}

func change(_ amount: Int) -> Result<[Int:Int], NegativeAmountError> {
    if amount < 0 {
        return .failure(NegativeAmountError())
    }
    var (counts, remaining) = ([Int:Int](), amount)
    for denomination in [25, 10, 5, 1] {
        (counts[denomination], remaining) = 
            remaining.quotientAndRemainder(dividingBy: denomination)
    }
    return .success(counts)
}


// Write your first then lower case function here
func firstThenLowerCase(of strings: [String], satisfying predicate: (String) -> Bool) -> String? {
    return strings.first(where: predicate)?.lowercased()
}


// Write your say function here
struct Sayer {
    var phrase: String

    init(_ word: String) {
        phrase = word
    }

    func and(_ word: String) -> Sayer {
        return Sayer("\(phrase) \(word)")
    }

    var phraseValue: String {
        return phrase
    }
}

func say(_ word: String = "") -> Sayer {
    return Sayer(word)
}


func meaningfulLineCount(_ filename: String) async -> Result<Int, NoSuchFileError> {
    do {
        let content = try await Task { () -> String in
            let url = URL(fileURLWithPath: filename)
            return try String(contentsOf: url)
        }.value

        var count = 0;
        for line in content.split(separator: "\n") {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if !trimmedLine.isEmpty && !trimmedLine.hasPrefix("#") {
                count += 1
            }
        }
        return .success(count)
    }
    catch {
        return .failure(NoSuchFileError())
    }
}


// Write your Quaternion struct here
struct Quaternion: CustomStringConvertible, Equatable {
    let a, b, c, d: Double

    static let ZERO = Quaternion(a: 0, b: 0, c: 0, d: 0)
    static let I = Quaternion(a: 0, b: 1, c: 0, d: 0)
    static let J = Quaternion(a: 0, b: 0, c: 1, d: 0)
    static let K = Quaternion(a: 0, b: 0, c: 0, d: 1)

    init(a: Double = 0, b: Double = 0, c: Double = 0, d: Double = 0) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    var coefficients: [Double] {
        return [a, b, c, d]
    } 

    var conjugate: Quaternion {
        return Quaternion(a: a, b: -b, c: -c, d: -d)
    }

    static func +(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        return Quaternion(a: lhs.a + rhs.a, b: lhs.b + rhs.b, c: lhs.c + rhs.c, d: lhs.d + rhs.d)
    }

    static func *(lhs: Quaternion, rhs: Quaternion) -> Quaternion {
        let a = lhs.a * rhs.a - lhs.b * rhs.b - lhs.c * rhs.c - lhs.d * rhs.d
        let b = lhs.a * rhs.b + lhs.b * rhs.a + lhs.c * rhs.d - lhs.d * rhs.c
        let c = lhs.a * rhs.c - lhs.b * rhs.d + lhs.c * rhs.a + lhs.d * rhs.b
        let d = lhs.a * rhs.d + lhs.b * rhs.c - lhs.c * rhs.b + lhs.d * rhs.a
        return Quaternion(a: a, b: b, c: c, d: d)
    }

// used https://www.programiz.com/swift-programming/library/string/replacingoccurrences  to help with replacing characters 
    var description: String {
        var letters: [String] = []

        if a != 0 {
            letters.append("\(a)")
        }
        if b != 0 {
            letters.append(b == 1 ? "i" : (b == -1 ? "-i" : "\(b)i"))
        }
        if c != 0 {
            letters.append(c == 1 ? "j" : (c == -1 ? "-j" : "\(c)j"))
        }
        if d != 0 {
            letters.append(d == 1 ? "k" : (d == -1 ? "-k" : "\(d)k"))
        }

        return letters.isEmpty ? "0" : letters.joined(separator: "+").replacingOccurrences(of: "+-", with: "-")
    }
}


// Write your Binary Search Tree enum here
enum BinarySearchTree: CustomStringConvertible {
    case empty
    indirect case node(BinarySearchTree, String, BinarySearchTree)

    var size: Int {
        switch self {
        case .empty:
            return 0
        case let .node(left, _, right):
            return 1 + left.size + right.size
        }
    }

    func contains(_ value: String) -> Bool {
        switch self {
        case .empty:
            return false
        case let .node(left, v, right):
            if value < v {
                return left.contains(value)
            } else if value > v {
                return right.contains(value)
            } else {
                return true 
            }
        }
    }
    func insert(_ value: String) -> BinarySearchTree {
        switch self {
        case .empty:
            return .node(.empty, value, .empty)
        case let .node(left, v, right):
            if value < v {
                return .node(left.insert(value), v, right)
            } else if value > v {
                return .node(left, v, right.insert(value))
            } else {
                return self
            }
        }
    }

// using ternary statement: left/right sides check to see if description is not () - empty,
//if it is -> get actual value, otherwise -> defaults to "" empty string
    var description: String {
        switch self {
        case .empty:
            return "()"
        case let .node(left, value, right):
            let leftSide = left.description != "()" ? left.description : ""
            let rightSide = right.description != "()" ? right.description : ""
            return "(\(leftSide)\(value)\(rightSide))"
        }
    }
}
