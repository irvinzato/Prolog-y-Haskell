module Main where



main::IO()
main = undefined


-- Funcion NewtonRaphson
f x = x^2 + x - 6 
f' x = 2*x + 1

newtonR n = if f n < 0.00001
                then n
                else newtonR (n - f n / f' n)
                


-- Funcion separar palabras
palabras1 :: String -> [String]
palabras1 cadena = words(cadena)

--palabras2 :: String -> [String]
--palabras2 cadena = palabras2(splitAt (" ", cadena))



-- Funcion guardar un tipo de fraccion
fraccion :: Int -> Int -> (Int,Int)
fraccion numerador denominador = if denominador == 0
                                    then error "La fraccion no se puede dividir por 0"
                                    else if numerador == 0
                                        then (0,0)
                                        else(numerador,denominador)
                  
                                    

-- Operaciones para fracciones definidas

--Suma de fracciones
sumaFraccion :: (Int,Int) -> (Int,Int) -> (Int,Int)
sumaFraccion (a,b) (c,d) = if b == 0 || d == 0
                            then error "Alguno de tus denominadores son 0"
                            else if b == d
                                   then (a+c,b)
                                   else (a*d + c*b, b*d)
                                   

--Resta de fracciones                                   
restaFraccion :: (Int,Int) -> (Int,Int) -> (Int,Int)
restaFraccion (a,b) (c,d) = if b == 0 || d == 0
                            then error "Alguno de tus denominadores es 0"
                            else if b == d
                                   then (a-c,b)
                                   else (a*d - c*b, b*d)


--Multiplicacion de fracciones
multFraccion :: (Int,Int) -> (Int,Int) -> (Int,Int) 
multFraccion (a,b) (c,d) = if b == 0 || d ==0
                            then error "Alguno de tus denomiadores es 0"
                            else (a*c , b*d)                                  


--Division de fracciones
divFraccion :: (Int,Int) -> (Int,Int) -> (Int,Int)
divFraccion (a,b) (c,d) = if b == 0 || c == 0
                            then error "La division queda con denominador igual a 0"
                            else (a*d , b*c)
                            
             
                            
--Metodo MergeSort 
divide :: [Int] -> ([Int],[Int])
divide [] = ([],[])
divide [x] = ([x],[])
divide (x:y:xs) = ((x:ys),(y:zs))
        where (ys, zs) = divide xs
        
merge :: [Int] -> [Int] -> [Int]
merge xs [] = xs
merge [] xs = xs
merge (x:xs) (y:ys) | x < y = x:(merge xs (y:ys))
                    | otherwise = y:(merge (x:xs) ys)
                    
msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort xs = merge (msort ys) (msort zs)
           where (ys, zs) = divide xs