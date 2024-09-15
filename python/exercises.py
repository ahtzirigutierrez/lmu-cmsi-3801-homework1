from dataclasses import dataclass
from collections.abc import Callable


def change(amount: int) -> dict[int, int]:
    if not isinstance(amount, int):
        raise TypeError('Amount must be an integer')
    if amount < 0:
        raise ValueError('Amount cannot be negative')
    counts, remaining = {}, amount
    for denomination in (25, 10, 5, 1):
        counts[denomination], remaining = divmod(remaining, denomination)
    return counts


# Write your first then lower case function here
def first_then_lower_case(strings, predicate, /):
    for string in strings:
        if predicate(string):
            return string.lower()
    return None


# Write your powers generator here
def powers_generator(base: int, limit: int):
    power = 1
    while power <= limit:
        yield power
        power = power * base
        
g = powers_generator(base=2, limit=7)
next(g)  
next(g)  
next(g)  
try:
    next(g)
except StopIteration:
    print("No more values")


# Write your say function here
def say(word = None):
    string = []
    def chain(next = None):
        if next is not None:
            string.append(next)
            return chain
        return ' '.join(string)
        
    if word is None:
        return chain()
    
    string.append(word)
    return chain


# Write your line count function here
# NOT empty, entirely whitepace, or whose first char is #

def meaningful_line_count(fileName = None):
    if fileName is not None:
        with open(fileName, 'r') as file:
            count = 0
            for line in file:
                if line.strip() and not line.strip().startswith('#'):
                    count = count + 1
        return count
    else:
        print("No such file")
        return FileNotFoundError
    
    
# Write your Quaternion class here
@dataclass(frozen=True)
class Quaternion:
    a: float
    b: float
    c: float
    d: float 

    @property
    def conjugate(self) -> str:
        return Quaternion(self.a, (-1*self.b), (-1*self.c), (-1*self.d))
        #return None
    
    @property
    def coefficients(self):
        return (self.a, self.b, self.c, self.d)

    def __add__(self, q: "Quaternion"): # -> 'Quaternion':
        return Quaternion( 
            self.a + q.a,
            self.b + q.b,
            self.c + q.c,
            self.d + q.d,
        )
    
    def __mul__(self, q: "Quaternion"): # -> "Quaternion":

        a = self.a * q.a - self.b * q.b - self.c * q.c - self.d * q.d
        b = self.a * q.b + self.b * q.a + self.c * q.d - self.d * q.c
        c = self.a * q.c - self.b * q.d + self.c * q.a + self.d * q.b
        d = self.a * q.d + self.b * q.c - self.c * q.b + self.d * q.a

        return Quaternion(a, b, c, d)
    
    def __eq__(self, q: "Quaternion") -> bool:
        return (self.a, self.b, self.c, self.d) == (q.a, q.b, q.c, q.d)

    def __str__(self) -> str:
        string = ""
        if self.a != 0:
            string += f'{self.a}'

        if self.b != 0:
            if self.b == 1:
                if string == "":
                    string += "i"
                else:
                    string += "+i" 
            elif self.b == -1:
                string += "-i"
            elif self.b > 1:
                string += "+" + f'{self.b}i'
            else:
                string += f"{self.b}i"

        if self.c != 0:
            if self.c == 1:
                if string == "":
                    string += "j"
                else:
                    string += "+j" 
            elif self.c == -1:
                string += "-j"
            elif self.c > 1:
                string += "+" + f'{self.c}j'
            else:
                string += f"{self.c}j"

        if self.d != 0:
            if self.d == 1:
                if string == "":
                    string += "k"
                else:
                    string += "+k" 
            elif self.d == -1:
                string += "-k"
            elif self.d > 1:
                string += "+" + f'{self.d}k'
            else:
                string += f"{self.d}k"
        return string or "0"

    