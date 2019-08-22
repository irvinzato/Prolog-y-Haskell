module Main where



main::IO()
main = undefined

-- funcion factorial
factorial 0 = 1
factorial n = n * (factorial (n-1))

-- funcion para calcular raices de una funcion de segundo grado
raices a b c = if  a == 0
                then [0,0] 
                
                else  [(-b + sqrt(b*b - 4*a*c)) / 2*a,(-b - sqrt(b*b - 4*a*c)) / 2*a] 