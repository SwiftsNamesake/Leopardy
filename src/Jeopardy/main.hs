-- |
-- Module      : Main
-- Description : Entry point for the Jeopardy game
-- Copyright   : (c) Jonatan H Sundqvist, 2015
-- License     : 2015
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental
-- Portability : POSIX (not sure)
-- 

-- Created June 3 2015

-- TODO | - Hierarchical module names (?)
--        - 

-- SPEC | -
--        -



module Main where



---------------------------------------------------------------------------------------------------
-- We'll need these
---------------------------------------------------------------------------------------------------
import Jeopardy.Controller --



---------------------------------------------------------------------------------------------------
-- Entry point
---------------------------------------------------------------------------------------------------
main :: IO ()
main = do
	mainGTK
	putStrLn "You've killed me! I'm fading away!"
