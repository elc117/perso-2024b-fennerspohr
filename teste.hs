{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
import GHC.Generics
import Data.List.Split
import Data.List
import Text.Read (readMaybe)
import System.Random
import System.Random.Shuffle (shuffle')

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)

data Lyric = Lyric {
      id :: Int
    , verse :: String
    , song  :: String
    } deriving (Generic, Show)

parseLyrics :: String -> [Lyric]
parseLyrics fileContents = do
  [id', verse', song'] <- splitOn "|" <$> lines fileContents
  Just id'' <- return (readMaybe id')
  return (Lyric {Main.id = id'', verse = verse', song = song'})

randomizeLyrics :: [Lyric] -> StdGen -> [Lyric]
randomizeLyrics lyrics rng = shuffle' lyrics (length lyrics) rng

--saveRandom :: [Lyric] -> [Lyric]

seedGenerator :: IO()
seedGenerator = do
  lyrics <- parseLyrics <$> readFile "teste.txt"
  rng <- newStdGen
  print $ randomizeLyrics lyrics rng
  print $ lyrics



main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev

  -- Define your routes and handlers here
  get "/hello" $ do
    text (parseLyrics <$> readFile "teste.txt")
--    getRandomId lyrics
--    getRandomId lyrics

--    getRandomId lyrics
--    seedGenerator lyrics
--    putStrLn $ show(lyrics)
    --putStrLn $ show(verse( lyrics!!0))
    return ()