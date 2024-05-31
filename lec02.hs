module SecondLecture where

--
-- MULTIPLE INPUT FUNCTIONS
--

-- These are parsed by order of right associativity
-- E.g: `f :: a -> b -> c` is equivalent to `f :: a -> (b -> c)`
-- Note that this is NOT equivalent to `g :: (a -> b) -> c`
-- The above function takes a function of type `a -> b` as input, returning a value of type `c`

-- Function application
-- For a function `f :: A -> B`, we can evaluate f at some x of type A, as `f x`
-- For a function `f :: A -> B -> C`, it would be (f x) y,
-- but function application is left-associative, so we can drop the parens: f x y
-- Note that `f x y` is different to `f (x y)`,
-- which attempts to apply x on the input y, and apply f on that result

-- Multiple inputs *could* be passed using n-tuples
myAdd :: (Int, Int) -> Int
myAdd (x, y) = x + y

-- But for haskell, it is better to allow for partial application
anotherAdd :: Int -> Int -> Int
anotherAdd x y = x + y

--
-- MULTIPLE OUTPUTS USING N-TUPLES
--

type Position2D = (Int, Int)
neighbours :: Position2D -> (Position2D, Position2D, Position2D, Position2D)
neighbours (x, y) = ((x - 1, y), (x, y - 1), (x + 1, y), (x, y + 1))

-- RECURSION
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- guards
fib :: Int -> Int
fib n
        | n == 0 = 0
        | n == 1 = 1
        | otherwise = fib (n - 1) + fib (n - 2)

--
-- LISTS
--

-- Iterative definition: A sequence of items, connected by a pointer from
-- the previous item to the next item. The last element does not point to anything (duh).
--
-- Recursive definition: An item, followed by a smaller list of items
-- The latter is especially powerful, as Haskell does not permit loops, but we can use
-- the concept of defining a larger object in terms of smaller objects.
--
-- In Haskell, we can define such recursive behaviour using (:) aka "cons":
-- ghci> :t (:)
-- (:) :: a -> [a] -> [a]
-- So, suppose we have a list l of objects of type A: l = [b, a_1, a_2, ..., a_n]
-- Using cons, we can "cons"truct l as follows:
-- l = b:[a_1, a_2, ..., a_n]
-- l = b:as, where as represents the (a_i)'s above
-- The common convention uses (x:xs)

sumList :: [Int] -> Int
sumList [] = 0
sumList (x : xs) = x + sumList xs

--
-- HOF
--

square :: Int -> Int
square x = x * x

powerFourNaive :: Int -> Int
powerFourNaive x = x * x * x * x

powerFourBetter :: Int -> Int
powerFourBetter x = square (square x)

-- Notice how we're applying square twice?
-- Can we make a function that applies itself twice?

applyTwiceInt :: (Int -> Int) -> Int -> Int
applyTwiceInt f x = f (f x)

-- This function only works on Int, can we go generic?
applyTwice :: (a -> a) -> a -> a
-- applyTwice f x = f (f x)
-- We can use function composition notation to rewrite the above binding
applyTwice f = f . f

-- Final result below:
powerFourBest :: Int -> Int
-- powerFourBest x = applyTwice square x
-- Note by left associativity, reduce the function definition to:
powerFourBest = applyTwice square

--
-- MAPS & ANONYMOUS FUNCTIONS
--

-- We would like to find the prefix sum of an [Int], and subtract 1 from each element from that
-- How would we go about implementing prefix sum on `Int`s?
prefixSumHelper :: Int -> [Int] -> [Int]
prefixSumHelper acc [] = []
prefixSumHelper acc (x : xs) = (x + acc) : prefixSumHelper (x + acc) xs

prefixSum :: [Int] -> [Int]
prefixSum = prefixSumHelper 0

subtractOne :: Int -> Int
subtractOne x = x - 1

answerFunc :: [Int] -> [Int]
answerFunc x = map subtractOne (prefixSum x)

{-
TODO:
Type-driven design

-}
