-- |
-- Module      : Jeopardy.Graphics
-- Description : Rendering functionality for the Jeopardy game
-- Copyright   : (c) Jonatan H Sundqvist, 2015
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental|stable
-- Portability : POSIX (not sure)
-- 

-- Created July 7 2015

-- TODO | - 'App' type with configurations, event listeners, etc.
--        - 

-- SPEC | -
--        -



module Jeopardy.Graphics where



---------------------------------------------------------------------------------------------------
-- We'll need these
---------------------------------------------------------------------------------------------------
import qualified Graphics.Rendering.Cairo as Cairo --

import Control.Monad (when, forM_) --
import Data.Complex

import qualified Southpaw.Picasso.Palette as Palette --

import Jeopardy.Core --



---------------------------------------------------------------------------------------------------
-- Types
---------------------------------------------------------------------------------------------------
type Point = Complex Double



---------------------------------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------------------------------
π = pi
τ = 2*π



---------------------------------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------------------------------
-- Game specific rendering ------------------------------------------------------------------------
-- |
renderGame :: Game -> Cairo.Render ()
renderGame game = do
	--
	let (dx, padx) = (42, 5)
	mapM_ (\ (n, cat) -> renderCategory ((50+n*(dx+padx)*2):+50) (dx:+dx) 4 cat) . zip [1..] $ _board game


-- |
renderAnswerTile :: Point -> Double -> String -> Cairo.Render ()
renderAnswerTile (cx:+cy) radius answer = do
	Cairo.arc cx cy radius 0 τ
	Palette.choose Palette.blue
	Cairo.fill

	Cairo.arc cx cy (radius*0.86) 0 τ
	Palette.choose Palette.cadetblue
	Cairo.fill

	Palette.choose Palette.black
	Cairo.setFontSize 18
	renderCentredText (cx:+cy) answer


-- |
renderCategoryHeading :: Point -> Point -> String -> Cairo.Render ()
renderCategoryHeading (cx:+cy) (dx:+dy) title = do
	Cairo.rectangle (cx-dx) (cy-dy) (dx*2) (dy*2)
	Palette.choose Palette.blue
	Cairo.fill

	Cairo.rectangle (cx-(dx*0.86)) (cy-(dy*0.86)) (dx*2*0.86) (dy*2*0.86)
	Palette.choose Palette.cadetblue
	Cairo.fill

	Palette.choose Palette.black
	Cairo.setFontSize 18
	renderCentredText (cx:+cy) title


-- |
-- TODO: Add layout option parameters
renderCategory :: Point -> Point -> Double -> Category -> Cairo.Render ()
renderCategory (cx:+cy) (dx:+dy) pady (Category { _questions=q, _title=t }) = do
	renderCategoryHeading (cx:+cy) (dx:+(dy*0.8)) t
	mapM_ (\ (n, q) -> renderAnswerTile (cx:+(cy+n*(dy+pady)*2)) dx . show $ _value q) . zip [1..] $ q


-- General rendering utilities --------------------------------------------------------------------
-- |
-- TODO: General anchor (?)
renderCentredText :: Point -> String -> Cairo.Render ()
renderCentredText (cx:+cy) text = do
	extents <- Cairo.textExtents text
	let (w, h) = (Cairo.textExtentsWidth extents, Cairo.textExtentsHeight extents)
	Cairo.moveTo (cx-w/2) (cy+h/2)
	Cairo.showText text


-- |
renderCircle :: Double -> Point -> Cairo.Render ()
renderCircle radius (cx:+cy) = Cairo.arc cx cy radius 0 τ


---------------------------------------------------------------------------------------------------
