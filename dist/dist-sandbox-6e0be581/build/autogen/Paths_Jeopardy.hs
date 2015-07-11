module Paths_Jeopardy (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Jonatan\\Desktop\\Haskell\\projects\\Jeopardy\\.cabal-sandbox\\bin"
libdir     = "C:\\Users\\Jonatan\\Desktop\\Haskell\\projects\\Jeopardy\\.cabal-sandbox\\x86_64-windows-ghc-7.8.3\\Jeopardy-0.1.0.0"
datadir    = "C:\\Users\\Jonatan\\Desktop\\Haskell\\projects\\Jeopardy\\.cabal-sandbox\\x86_64-windows-ghc-7.8.3\\Jeopardy-0.1.0.0"
libexecdir = "C:\\Users\\Jonatan\\Desktop\\Haskell\\projects\\Jeopardy\\.cabal-sandbox\\Jeopardy-0.1.0.0"
sysconfdir = "C:\\Users\\Jonatan\\Desktop\\Haskell\\projects\\Jeopardy\\.cabal-sandbox\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Jeopardy_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Jeopardy_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Jeopardy_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Jeopardy_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Jeopardy_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)