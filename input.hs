-- Simple.hs

-- Function to calculate the factorial of a non-negative integer
factorial :: Integer -> Integer
factorial n
    | n == 0 = 1
    | otherwise = n * factorial (n - 1)

-- Main function to demonstrate the factorial function
main :: IO ()
main = do
    putStrLn "Enter a non-negative integer:"
    input <- getLine
    let n = read input :: Integer
    if n >= 0
        then putStrLn $ "Factorial of " ++ show n ++ " is: " ++ show (factorial n)
        else putStrLn "Please enter a non-negative integer."
