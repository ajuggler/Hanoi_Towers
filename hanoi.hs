-- This program solves the Hanoi Towers' problem assuming three towers

-- USAGE:
-- 'hanoi n' solves the problem where the initial tower has n discs
-- 'mapM_ print $ hanoi n' prints the solution on the console
-- 'length $ hanoi n' is the number of steps plus one (initial condition)
-- (Mathematically, it is known that 'length $ hanoi n' gives 2^n)

-- The crux of the solution is based on defining a non-standard ordering of
-- the towers; see last auxiliary function

import Data.List

hanoi :: Int -> [[[Int]]]
hanoi n = reverse $ hanoiList [[[1..n],[],[]]]


-- Auxiliary functions --


-- Recursively construct list of configurations

hanoiList :: [[[Int]]] -> [[[Int]]]
hanoiList ([[],[],tw] : twss) = [[],[],tw] : twss
hanoiList twss                = hanoiList (newtws : twss)
  where
    newtws = hanoiStep (length twss) $ head twss

-- Best move depending on parity of move number

hanoiStep :: Int -> [[Int]] -> [[Int]]
hanoiStep n [xs,ys,zs] = newtws
  where
    tws = [xs, ys, zs]
    newtws
      | odd n     = moveSmall
      | otherwise = moveNonSmall

    moveSmall :: [[Int]]
    moveSmall = move n ((n + dir) `mod` 3) tws
      where
        h   = sum $ map length tws
        dir = (-1) ^ (h `mod` 2)
        n   = head . sortTws $ tws

    moveNonSmall :: [[Int]]
    moveNonSmall = move p1 p2 tws
      where
        [p1,p2] = tail . sortTws $ tws

-- Move from tower p1 to tower p2

move :: Int -> Int -> [[Int]] -> [[Int]]
move p1 p2 [xs,ys,zs] = map obj [0, 1, 2]
  where
    tws    = [xs,ys,zs]
    newTw1 = tail (tws!!p1)
    newTw2 = head (tws!!p1) : (tws!!p2)
    newTw3 = tws!!(3 - p1 - p2)
    obj i
      | i == p1   = newTw1
      | i == p2   = newTw2
      | otherwise = newTw3

-- Sorting towers according to a non-standard ordering

sortTws :: [[Int]] -> [Int]
sortTws [xs, ys, zs] = map fst $ sortBy orderBySnd $ [(0,h1),(1,h2),(2,h3)]
  where
    tws = [xs,ys,zs]
    [h1,h2,h3] = map (\l -> if null l then 0 else head l) tws

    orderBySnd :: (a,Int) -> (b,Int) -> Ordering
    orderBySnd (_,0) (_,0) = EQ
    orderBySnd (_,0) (_,_) = GT
    orderBySnd (_,_) (_,0) = LT
    orderBySnd (_,x) (_,y) = compare x y
    
