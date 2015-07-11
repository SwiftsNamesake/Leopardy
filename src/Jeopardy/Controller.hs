-- |
-- Module      : Jeopardy.Controller
-- Description : MVC for our game
-- Copyright   : (c) Jonatan H Sundqvist, year
-- License     : MIT
-- Maintainer  : Jonatan H Sundqvist
-- Stability   : experimental|stable
-- Portability : POSIX (not sure)
-- 

-- Created date year

-- TODO | - 
--        - 

-- SPEC | -
--        -



module Jeopardy.Controller where



---------------------------------------------------------------------------------------------------
-- We'll need these
---------------------------------------------------------------------------------------------------
import Graphics.UI.Gtk                   --
import Graphics.Rendering.Cairo (liftIO, fill) --

import Data.IORef   --
import Data.Complex --
import Data.Maybe (listToMaybe, maybe)
import Data.List (findIndex)

import Text.Printf

import qualified Southpaw.Picasso.Palette as Palette
import qualified Southpaw.Interactive.Application as App

import Jeopardy.Graphics -- TODO: Better name
import Jeopardy.Core     -- TODO: Better name
import Jeopardy.Curator  --
import Tiler             --



---------------------------------------------------------------------------------------------------
-- Types
---------------------------------------------------------------------------------------------------
-- |
-- TODO: Input state (?)
-- data App      = App { _window :: Window, _canvas :: DrawingArea, _size :: (Int, Int), _state :: IORef AppState } --
data AppState = AppState { _game :: Game, _selected :: Maybe Int, _path :: [Complex Double] }                    --



---------------------------------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------------------------------
fps = 30 :: Int



---------------------------------------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------------------------------------
-- Events -----------------------------------------------------------------------------------------
-- |
-- ondelete :: IO Bool
ondelete = do
    -- TODO: Uhmmm... what?
    liftIO $ do
	    mainQuit
	    putStrLn "Goodbye!"
	    return False


-- |
onmousemotion stateref = do
	(mx, my) <- eventCoordinates
	liftIO $ do
		let cursor = mx:+my --
		let radius = 18     --
		appstate@(AppState { _path=path }) <- readIORef stateref
		writeIORef stateref $ appstate { _selected=findIndex (within radius cursor) path } 
	return False
	where within r p = (< r) . realPart . abs . subtract p


-- |
ondraw appstate = do
	-- 
	renderGame $ _game appstate
	-- Testing an unrelated tiling function
	renderPathWithJoints Palette.chartreuse Palette.darkviolet 18 5 $ _path appstate
	assuming (_selected appstate) $ \ sel -> do
		renderCircle 22 $ _path appstate !! sel
		Palette.choose Palette.limegreen
		fill

		renderCircle 22 $ _path appstate !! opposite sel
		Palette.choose Palette.limegreen
		fill
	where assuming (Just a) f = f a
	      assuming  _       _ = return ()
	      opposite n          = (n + 3) `mod` (length $ _path appstate)

-- |
onanimate :: DrawingArea -> IORef AppState -> IO Bool
onanimate canvas stateref = do
    widgetQueueDraw canvas
    return True


---------------------------------------------------------------------------------------------------
-- |
createApp :: IO (App.App)
createApp = App.createWindowWithCanvas 650 650 $ AppState { _game=createGame,
		                                                    _selected=Nothing,
		                                                    _path=[ (200:+200)+(70:+0)*(cos θ:+sin θ) | θ <- [0, τ/6..(τ*5/6)] ] }


---------------------------------------------------------------------------------------------------
-- |
-- TODO: Rename, move (?)
mainGTK :: IO ()
mainGTK = do
	(App.App { App._window=window, App._canvas=canvas, App._size=size, App._state=stateref }) <- createApp

	timeoutAdd (onanimate canvas stateref) (1000 `div` fps) >> return ()

	-- Events
	canvas `on` draw $ (liftIO $ readIORef stateref) >>= ondraw
	canvas `on` motionNotifyEvent $ onmousemotion stateref

	-- canvas `on` buttonPressEvent   $ onbuttonpress worldref
	-- canvas `on` buttonReleaseEvent $ onbuttonreleased worldref

	-- window `on` configureEvent $ onresize window worldref
	window `on` deleteEvent	$ ondelete
	-- window `on` keyPressEvent  $ onkeypress worldref

	mainGUI