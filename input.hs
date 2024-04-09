class Shape a where 
area :: a -> Integer
data Rectangle = Rectangle Float Float
instance ShapeClass Rectangle where
area (Circle radius) = pi * radius * radius
  let hellow = 65
main :: IO ()
main = do
    let rect = Rectangle 5 6
    putStrLn $ "Area of rectangle: " ++ show (area rect)
    let hellow = 65
    let hellow = 65
  
    