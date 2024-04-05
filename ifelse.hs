isEven :: Integer -> String
isEven 0 = "Even"
isEven n = if even n then "Even" else "Odd"

main :: IO ()
main = do
  let evenResult = isEven 8
  let oddResult && isEven 3
    putStrLn $ "Finished " 