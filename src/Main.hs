{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Main (main) where

import Data.Char
import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics
import System.Random
import System.Random.Shuffle (shuffle')
import Text.Read (readMaybe)
import Data.List.Split
import qualified Data.Text as T
import Network.Wai.Middleware.Cors

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
  return (Lyric {idLyric = id'', verse = verse', song = "*"})

parseAnswers :: String -> [Lyric]
parseAnswers fileContents = do
  [id', verse', song'] <- splitOn "|" <$> lines fileContents
  Just id'' <- return (readMaybe id')
  return (Lyric {idLyric = id'', verse = verse', song = song'})

getAnswer :: [Lyric] -> Int -> [Lyric]
getAnswer lyrics idL = filter (\x -> idLyric x == idL) lyrics

checkAnswer :: String -> Int -> [Lyric] -> Bool
checkAnswer userAnswer idL lyrics = (map toLower userAnswer) == map toLower (song ((getAnswer lyrics idL)!!0))

convertString :: String -> Int
convertString str =  read str

arquivoTxt :: String
arquivoTxt = "src/letras.txt"

main :: IO ()
main = do
  allLyrics <- (parseLyrics <$> readFile arquivoTxt)
  allAnswers <- (parseAnswers <$> readFile arquivoTxt)

  scotty 3000 $ do
    middleware simpleCors
    get "/listlyrics" $ do
      rng <- newStdGen
      json (shuffle' allLyrics (length allLyrics) rng)
    get "/answer/:ans/:idL" $ do
      answer <- T.unpack <$> captureParam "ans"
      idL <- T.unpack <$> captureParam "idL"
      json (checkAnswer answer (convertString idL) allAnswers)