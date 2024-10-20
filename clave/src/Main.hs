{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Main (main) where

import System.IO (readFile)
import Data.Time (getCurrentTime)
import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import System.Random
import System.Random.Shuffle (shuffle')
import Text.Read (readMaybe)

import Data.List.Split

data Lyric = Lyric {
      idLyric :: Int
    , verse :: String
    , song  :: String
    }deriving(Show, Generic)

instance ToJSON Lyric
instance FromJSON Lyric

parseLyrics :: String -> [Lyric]
parseLyrics fileContents = do
  [id', verse', song'] <- splitOn "|" <$> lines fileContents
  Just id'' <- return (readMaybe id')
  return (Lyric {idLyric = id'', verse = verse', song = song'})

main :: IO ()

main = do
  putStrLn "Starting Server..."
  allLyrics <- (parseLyrics <$> readFile "src/teste.txt")
  scotty 3000 $ do
    get "/listLyrics" $ do
      rng <- newStdGen
      json (shuffle' allLyrics (length allLyrics) rng)