# Hanoi_Towers
 An instructive solution to the Tower of Hanoi problem

## Description

Coding a solution to the classical [*Tower of Hanoi problem*](https://en.wikipedia.org/wiki/Tower_of_Hanoi) is a standard exercise for students learning a new programming language.
Here we offer a solution written in Haskell.

Its main *pedagogcal value* is illustrating how a **non-standard ordering** can be the basis for a concise solution.

## Usage

The initial configuration is the list `[[1..n], [], []]` where each sublist represents a rod, each integer represents the diameter of a disk on the rod, and the position of each integer within the sublist represents the position of the corresponding disk (left is top).  Only the case of three rods is considered.

1. Solution to the problem with n disks on the first rod

      hanoi n
      
2.  Print nicely the soluton to the console

      mapM_ print $ hanoi n
      
3.  Number of steps in the optimal solution.

      length $ hanoi n
      
Mathematically, it is known that `(length $ hanoi n) == 2^n`.
