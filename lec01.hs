-- Setup the module for the file 
module FirstLecture where

-- assigning variables
-- there are CONSTANTS
-- immutability!
x = 7

-- all types are capitalised
-- the A -> B notation means,
-- we take an input of type A, 
-- and return something of type B
square :: Int -> Int
square x = x * x

-- equivalent in typescript as:
-- type SquareFunc = (a: number) => number
-- const square: SquareFunc = a => a * a


-- this function can be called similar to other PLs via
-- square(x), OR
-- the haskell way is to just say `square x`
--

-- functions are left-associative
-- i.e., square 2 + 2, is parsed as (square 2) + 2, which results in 6
--

-- functions are first-class citizens
-- you can pass functions into functions

-- Is `square square 2 + 2` parseable?
-- No, because of left-associativity, the compiler attemps to evaluate
-- (square square) 2 + 2, which is not possible since square expects an Int as input
-- to correct this, add parenthesis: `square (square 2) + 2`, which outputs 18
