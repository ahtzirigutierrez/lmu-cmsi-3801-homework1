# Homework Template for CMSI 3801

Welcome!

## Description
Author: Ahtziri Gutierrez


**Homework 1 (Scripting)**: Lua, Python, JavaScript

- Q1 (first then lower case): This functions takes in string 'a' and predicate 'p' as input and returns the first string of a that satisfies p in lowercase letters. If there's no element matching this, then it returns nil for Lua, undefined for JavaScript, or None for Python
- Q2 (powers generator): This function is a power generator that calculates successive powers of base b going up to a given limit
- Q3 (say): This function passes in multiple strings and then returns them separated by a single space
- Q4 (meaningful line count): This function accepts a file name and returns the number of lines from the file that aren't empty, made up of whitespace, or whose first character is a '#'
- Q5 (Quaternion): This problem, taking the form of a JavaScript or Python class, or a table in Lua, constructs, adds, multiplies, obtains coefficents, computers the conjugate, supports equality, and produces a string. 

**Homework 2 (Enterprise)**: Java, Kotlin, Swift

- Q1 (first then lower case): This function takes in either a list for Java/Kotlin or an array for Swift with strings 'a' and predicate 'p,' returning the lowercased version of the first element of a that satisfies p.
- Q2 (say): This function takes in strings and adds them to a chain, returning the accumulated string when 'phrase' is used. 
- Q3 (meaningful line count): This function accepts a filename and returns the number of lines that are not empty, made up of whitespace, or contain a '#' first character. For Java and Kotlin, IOException was used and for Swift, a Result object was returned. 
- Q4 (Quaternion): This problem, using either a Java record, Kotlin data class, or Swift struct, contructed, added, multiplied, returned a coefficients array, returned the conjugate, and produced a string representation. 
- Q5 (binary search tree): This problem used a sealed class/interface for Java and Kotlin, and an indirect enum for Swift. It supported an element count, insertion, and lookup of nodes. 

**Homework 3 (Theory)**: TypeScript, OCaml, Haskell

- Q1 (first then lower case): This function takes in either a list (OCaml and Haskell) or an array (TypeScript) a, a predicate p, and a function f, returning the first element of a that satisfies p.
- Q2 (power generator): This function implements an infinite sequence of powers of base b. 
- Q3 (meaningful line count): This function returns the number of text lines from a text file that are neither empty, made up of whitespace, or whose first character is #. 
- Q4 (binary search tree): This function produces a tree supporting insertion, lookup, count, inorder traversal, and string description (TypeScript and Haskell only).


**Homework 4 (Systems)**: C, C++, Rust
- All three languages implemented the Stack data stucture. 

- **Homework 5 (Concurrency)**: Go


## The Test Suites

The test files are included in the repo already. They are available for YOU! They will help you not only learn the languages and concepts covered in this course, but to help you with professional practice. You should get accustomed to writing code to make tests pass. As you grow in your profession, you will get used to writing your tests early.

The test suites are run like so (assuming you have a Unix-like shell, modify as necessary if you have Windows):

### Lua

```
lua exercises_test.lua
```

### Python

```
python3 exercises_test.py
```

### JavaScript

```
npm test
```

### Java

```
javac *.java && java ExercisesTest
```

### Kotlin

```
kotlinc *.kt -include-runtime -d test.jar && java -jar test.jar
```

### Swift

```
swiftc -o main exercises.swift main.swift && ./main
```

### TypeScript

```
npm test
```

### OCaml

```
ocamlc exercises.ml exercises_test.ml && ./a.out
```

### Haskell

```
ghc ExercisesTest.hs && ./ExercisesTest
```

### C

```
gcc string_stack.c string_stack_test.c && ./a.out
```

### C++

```
g++ -std=c++20 stack_test.cpp && ./a.out
```

### Rust

```
cargo test
```

### Go

```
go run restaurant.go
```

## Grading Notes

Your grade is a reflection not only of your ability to write code to pass existing tests, but also of your ability to construct software in a professional setting. Therefore, the following will contribute rather heavily to your score:

- **Following all submission instructions**! Pay attention to every requirement such as replacing the contents of this readme file and including the names of all participants of any group work.
- **Keeping a pristine GitHub repository**. Do not push any file that does not belong (including but not limited to that silly `DS_Store`). Make sure all generated executables, intermediate files, third-party libraries, etc. are not committed. Your repo contents should be limited to your solution files, tests, configuration files, and `.gitignore` files.
- **Adherence to naming and formatting conventions for the language you are writing in**. Inconsistent indentation, for example, has no place in professional or student software. Neither does end-of-line whitespace, huge chunks of contiguous blank lines, and other types of messy coding practices that show friends, family, colleagues, and potential employers that you don’t care about your work.
- (As always) The **readability and maintainability** of your code.
