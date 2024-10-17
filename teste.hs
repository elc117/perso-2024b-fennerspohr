{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
import GHC.Generics

import Text.Read (readMaybe)

data Person = Person {
      name :: String
    , age  :: Int
    } deriving (Generic, Show)




parsePeople :: String -> [Person]
parsePeople fileContents = do
  [name', age'] <- Prelude.words <$> Prelude.lines fileContents
  Just age'' <- return (readMaybe age')
  return (Person {name = name', age = age''})
main :: IO ()
main = do
    people <- parsePeople <$> readFile "teste.txt"
    putStrLn $ show(people)
    putStrLn $ show(name( people!!0))
    return ()