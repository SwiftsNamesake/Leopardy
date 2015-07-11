-- |
-- Module      : Tiler.hs
-- Description : 
-- Copyright   : (c) Jonatan H Sundqvist, 2015
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental|stable
-- Portability : POSIX (not sure)
-- 

-- Created July 9 2015

-- TODO | - 
--        - 

-- SPEC | -
--        -



module Tiler (renderPathWithJoints) where 



---------------------------------------------------------------------------------------------------
-- We'll need these
---------------------------------------------------------------------------------------------------
import Control.Monad (mapM_, forM_)
import Data.Complex

import qualified Graphics.Rendering.Cairo as Cairo

import qualified Southpaw.Picasso.Palette as Palette
import Southpaw.Utilities.Utilities (pairwise)



---------------------------------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------------------------------
π = pi
τ = 2*π



---------------------------------------------------------------------------------------------------
-- Types
---------------------------------------------------------------------------------------------------
type Path = [Complex Double]



---------------------------------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------------------------------
renderPathWithJoints :: Palette.Colour -> Palette.Colour -> Double -> Double -> Path -> Cairo.Render ()
renderPathWithJoints line joint radius thickness path = do
	
	-- Render the lines
	Cairo.setLineWidth thickness
	forM_ (pairwise $ path ++ [head path]) $ \ (fr, to) -> do
		Palette.choose line
		Cairo.moveTo (realPart fr) (imagPart fr)
		Cairo.lineTo (realPart to) (imagPart to)
		Cairo.stroke

	-- Render the 'joints'
	forM_ path $ \ (x:+y) -> do
		Palette.choose joint
		Cairo.arc x y radius 0 τ
		Cairo.fill