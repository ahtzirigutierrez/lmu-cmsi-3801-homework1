import { open } from "node:fs/promises"

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(strings, predicate){
  for (let i = 0; i < strings.length; i++){
    if (predicate(strings[i])) {
      return strings[i].toLowerCase()
    }
  }
  return undefined
}

// Write your powers generator here
export function* powersGenerator({ofBase, upTo}) {
  let power = 1
  while (power <= upTo) {
    yield power
    power = power * ofBase
  }
}
const g = powersGenerator({ofBase: 2, upTo: 7})
g.next()
g.next()
g.next()
g.next()


// Write your say function here
export function say(word = undefined) {
  const str = [] 

  function chain(next = undefined){
    if(next !== undefined){
      str.push(next)
      return chain 
    }
    return str.join(" ") 
  }

  if (word === undefined) { 
    return ""
  }
  str.push(word)
  return chain

} 
 
// Write your line count function here/* 
// used https://www.geeksforgeeks.org/node-js-filehandle-readlines-method/ to help me read the file
export async function meaningfulLineCount(filename) {
  try {
    let data = await open(filename, "r")
    let count = 0
    for await (const line of data.readLines()){
      let trimmedLine = line.trim()
      if(trimmedLine.length > 0 && !trimmedLine.startsWith("#")){
        count += 1
      }
    }
    return count
  }
  catch (error) {
    return Promise.reject(error)
  }
}
   
 
// Write your Quaternion class here
export class Quaternion{
  constructor(a, b, c, d){
    this.a = a
    this.b = b
    this.c = c
    this.d = d
    Object.freeze(this);
  }

  get coefficients(){
    return [this.a, this.b, this.c, this.d]
  }

  get conjugate(){
    return new Quaternion(this.a, -this.b, -this.c, -this.d)
  }


  plus(q) {
    return new Quaternion(
      this.a + q.a, 
      this.b + q.b,
      this.c + q.c,
      this.d + q.d
    )
  }

  times(q){
    return new Quaternion(
      this.a * q.a - this.b * q.b - this.c * q.c - this.d * q.d,
      this.a * q.b + this.b * q.a + this.c * q.d - this.d * q.c,
      this.a * q.c - this.b * q.d + this.c * q.a + this.d * q.b,
      this.a * q.d + this.b * q.c - this.c * q.b + this.d * q.a
      
    )
  }

  equals(q){
    return this.a === q.a && this.b === q.b && this.c === q.c && this.d === q.d
  }

  toString() {
    let str = ""
    if (this.a !== 0) {
      str += `${this.a}`
    }

    if(this.b !== 0){
      if(this.b === 1){
        if(str === "") {
          str += "i"
        }
        else {
          str += "+i"
        }
      }
      else if (this.b === -1) {
        str += "-i"
      }
      else if(this.b > 1) {
        str += `+${this.b}i`
      }
      else{
        str += `${this.b}i`
      }
    }

    if (this.c !== 0) {
      if (this.c === 1) {
          if (str === "") {
              str += "j"
          } else {
              str += "+j"
          }
      } else if (this.c === -1) {
        str += "-j"
      } else if (this.c > 1) {
        str += `+${this.c}j`
      } else {
        str += `${this.c}j`  
      }
    }

  if (this.d !== 0) {
      if (this.d === 1) {
          if (str === "") {
              str += "k"
          } else {
              str += "+k"
          }
      } else if (this.d === -1) {
          str += "-k";
      } else if (this.d > 1) {
          str += `+${this.d}k`
      } else {
          str += `${this.d}k`
      }
    }
    return str || "0" 
  }
}