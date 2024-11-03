import { open } from "node:fs/promises"
import { promises as fs } from 'fs'

export function change(amount: bigint): Map<bigint, bigint> {
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let counts: Map<bigint, bigint> = new Map()
  let remaining = amount
  for (const denomination of [25n, 10n, 5n, 1n]) {
    counts.set(denomination, remaining / denomination)
    remaining %= denomination
  }
  return counts
}

export function firstThenApply<T, U>(
  items: T[],
  predicate: (item: T) => boolean, 
  consumer: (item: T) => U
): U | undefined {
  const foundItem = items.find(predicate);
  return foundItem ? consumer(foundItem) : undefined;
}

export function* powersGenerator(base: bigint): Generator<bigint> {
  for (let power = 1n; ; power *= base) {
    yield power
  }
}

export async function meaningfulLineCount (filePath: string): Promise<number> {
  let count = 0;
  const fileContent = await fs.readFile(filePath, 'utf-8');
  const lines = fileContent.split('\n');

  for (const line of lines) {
    const trimmedLines = line.trim();
    if (trimmedLines && !trimmedLines.startsWith('#')) {
      count++;
    }
  }

  return count;
}

interface Sphere {
  kind: "Sphere"
  radius: number
}

interface Box {
  kind: "Box" 
  width: number
  length: number
  depth: number
}

export type Shape = Sphere | Box

export function surfaceArea(shape: Shape): number{
  switch (shape.kind){
    case "Sphere":
      return 4 * Math.PI * shape.radius ** 2
    case "Box":
      return 2 * (shape.width * shape.length + shape.width * shape.depth + shape.length * shape.depth)
  }
}

export function volume(shape: Shape): number { 
  switch (shape.kind){
    case "Sphere":
      return (4 / 3) * Math.PI * shape.radius ** 3
    case "Box":
      return shape.length * shape.width * shape.depth
  }
}


export interface BinarySearchTree<T> {
  size(): number
  insert(value: T): BinarySearchTree<T>
  contains(value: T): boolean
  inorder(): Iterable<T>
  toString(): string
}

export class Empty<T> implements BinarySearchTree<T> {
  size(): number {
    return 0
  }

  insert(value: T): BinarySearchTree<T> {
    return new Node(value, new Empty<T>(), new Empty<T>())
  }

  contains(value: T): boolean {
    return false
  }

  *inorder(): Iterable<T> {}

  toString(): string {
    return "()"
  }

}

class Node<T> implements BinarySearchTree<T> {
  constructor(private value: T, private left: BinarySearchTree<T>, private right: BinarySearchTree<T>) {}
  
  size(): number {
    return 1 + this.left.size() + this.right.size();
  }

  insert(value: T): BinarySearchTree<T> {
    if (value < this.value) {
      return new Node(this.value, this.left.insert(value), this.right);
    } else if (value > this.value) {
      return new Node(this.value, this.left, this.right.insert(value));
    }
    return this;
  }

  contains(value: T): boolean {
    if (value === this.value) {
      return true
    } 
    return value < this.value ? this.left.contains(value) : this.right.contains(value);
  }

  *inorder(): Iterable<T> {
    yield* this.left.inorder();
    yield this.value;
    yield* this.right.inorder();
  }

  toString(): string {
    const leftStr = this.left.toString();
    const rightStr = this.right.toString();
    return `(${leftStr}${this.value}${rightStr})`.replace(/\(\)/g, '');
  }
  
}
