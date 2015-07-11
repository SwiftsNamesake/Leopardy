-- |
-- Module      : Jeopardy.Core
-- Description : Implements the logic and core data types for our Jeopardy game
-- Copyright   : (c) Jonatan H Sundqvist, 2015
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental|stable
-- Portability : POSIX (not sure)
-- 

-- Created July 7 2015

-- TODO | - Loading boards from file
--        - Enforce board size, question values (?)
--        - Implement transitions (as state machine?)

-- SPEC | -
--        -



{-# LANGUAGE TemplateHaskell #-}



module Jeopardy.Core where



---------------------------------------------------------------------------------------------------
-- We'll need these
---------------------------------------------------------------------------------------------------
-- import Control.Lens
import Control.Monad.State (State, execState, get)



---------------------------------------------------------------------------------------------------
-- Types
---------------------------------------------------------------------------------------------------
data Question = Question { _answer :: String, _question  :: String,    _value :: Int, _double :: Bool } --
data Category = Category { _title  :: String, _questions :: [Question]                                } --
data Player   = Player   { _name   :: String, _score     :: Int                                       } --

data Game     = Game { _players :: [Player], _board :: [Category] } --


-- makeLenses ''Question
-- makeLenses ''Category
-- makeLenses ''Player
-- makeLenses ''Game



---------------------------------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------------------------------
-- |
createGame :: Game
createGame = Game { _players=[Player { _name="Sneezy", _score=0 },
                              Player { _name="Grumpy", _score=0 },
                              Player { _name="Snooty", _score=0 },
                              Player { _name="Groggy", _score=0 }],

                    _board=[Category { _title="Dwarves", _questions=[Question { _answer="The seventh dwarf.",   _question="Who is Snotty?",   _value=100, _double=False },
                                                                     Question { _answer="The largest country.", _question="What is Russia?",  _value=200, _double=False },
                                                                     Question { _answer="The warmest planet.",  _question="What is Mercury?", _value=300, _double=False }] },

                            Category { _title="Sherlock", _questions=[Question { _answer="Moriarty's nemesis.", _question="Who is Sherlock Holmes?", _value=100, _double=False },
                                                                      Question { _answer="Mycroft's brother.",  _question="Who is Sherlock Holmes?", _value=200, _double=False },
                                                                      Question { _answer="Watson's friend.",    _question="Who is Sherlock Holmes?", _value=300, _double=False }] },

                            Category { _title="", _questions=[] },
                            Category { _title="", _questions=[] },
                            Category { _title="", _questions=[] },
                            Category { _title="", _questions=[] }] }