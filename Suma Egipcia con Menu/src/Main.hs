module Menu where


menu::IO()

menu = 
        do
          putStrLn "1- Realizar suma egipcia"
          putStrLn "2- Leer un archivo"
          putStrLn "3- Salir del menu"
          putStrLn "Dame una opcion"
          opcion <- getLine
          
          if (opcion == "1")
               then do
                   putStrLn "Dame una fraccion de este modo:"
                   putStrLn "Numerador/Denominador"
                   fracdada <- getLine
                   putStrLn "Dame el nombre que le pondras al archivo:"
                   nombreArchivo <- getLine
                   print ("Me diste la fraccion: " ++ fracdada)
                   writeFile nombreArchivo (foldr (++) [] (map (++" ") (sumaEgip (transFrac fracdada))))
                   print ("La fraccion egipcia es: " ++ show (sumaEgip (transFrac fracdada)))
                   print ("Se creo el archivo " ++ nombreArchivo)
                   menu
                    
          else if (opcion == "2")
                 then do
                      putStrLn "Archivo que quieres leer:"
                      nombreArchivo <- getLine
                      leer <- readFile nombreArchivo
                      putStrLn "El contenido del archio es:"
                      print (leer)
                      menu
      
          else if (opcion =="3")
                then return()
          else
              menu
      
--tipo frac
data Fraccion  =  Fraccion Int Char Int 
                  deriving (Show)

numerador :: Fraccion -> Int
numerador ( Fraccion n _ _ ) = n

denominador :: Fraccion -> Int
denominador ( Fraccion _ _ d ) = d

--transforma a cadena
tranCad :: Fraccion -> [Char]
tranCad (Fraccion n '/' d) = (show n) ++ ['/'] ++ (show d)

--transformacion a fraccion
transFrac :: [Char] -> Fraccion 
transFrac cadena = Fraccion (read (head listaNumeros)) '/' (read (last listaNumeros))
    where 
    listaNumeros = sepFrac cadena
        

sepFrac :: [Char] -> [[Char]]
sepFrac [] = []
sepFrac cadena = numero:( sepFrac (drop 1 restoCadFrac) )
    where
    (numero, restoCadFrac) = span (/= '/') cadena


--minimo comun mltiplo y minimo comun divisor para reducir las fracciones que podrian salir
mcm :: Int -> Int -> Int
mcm a b = div (a*b) (mcd a b)

mcd :: Int -> Int -> Int
mcd a 0 = a
mcd a b = mcd b (mod a b)
                 
                                                                           
restaEgip :: Fraccion -> Fraccion
restaEgip frac = restaFraccion frac (nuevaFrac frac)

--division con los numeros invertidos de la original
nuevaFrac :: Fraccion -> Fraccion
nuevaFrac frac = Fraccion 1 '/' ((div (denominador frac) (numerador frac)) + 1)
                       
--resta de la fraccion original y el resultado de la invertida                                 
restaFraccion :: Fraccion -> Fraccion -> Fraccion
restaFraccion frac1 frac2 = Fraccion (((div (mcm d1 d2) d1) * n1 ) - ((div (mcm d1 d2) d2) * n2 )) '/' (mcm d1 d2)
                                    where 
                                    n1 = numerador frac1
                                    d1 = denominador frac1
                                    n2 = numerador frac2
                                    d2 = denominador frac2
    
--funcion que resive la fraccion 
sumaEgip :: Fraccion -> [[Char]]                               
sumaEgip (Fraccion 1 '/' d) = [( tranCad (Fraccion 1 '/' d) )]
sumaEgip frac = [(tranCad (nuevaFrac frac))] ++ sumaEgip (restaEgip frac) 

