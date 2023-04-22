-- 1
sumaMenosQueMax :: (Int, Int, Int) -> Bool
sumaMenosQueMax (t0, t1, t2) = maximo > minimo + intermedio
  where 
    maximo = max_terna (t0, t1, t2)
    minimo = min_terna (t0, t1, t2)
    intermedio = medio_terna (t0, t1, t2)

max_terna :: (Int, Int, Int) -> Int
max_terna (t0, t1, t2) | t0 >= t1 && t0 >= t2 = t0
                       | t1 >= t0 && t1 >= t2 = t1
                       | otherwise = t2

min_terna :: (Int, Int, Int) -> Int
min_terna (t0, t1, t2) | t0 <= t1 && t0 <= t2 = t0
                       | t1 <= t0 && t1 <= t2 = t1
                       | otherwise = t2

medio_terna :: (Int, Int, Int) -> Int
medio_terna (t0, t1, t2) | t0 <= t1 && t0 >= t2 = t0
                         | t0 >= t1 && t0 <= t2 = t0
                         | t1 <= t0 && t1 >= t2 = t1
                         | t1 >= t0 && t1 <= t2 = t1
                         | otherwise = t2

-- 2
sumaDigitos :: Int -> Int
sumaDigitos 0 = 0
sumaDigitos n = digitoUnidad + sumaDigitos digitosRestantes
  where
    digitoUnidad = mod n 10
    digitosRestantes = div n 10

-- 3
prod :: Integer -> Integer
prod 0 = 1
prod n = ((2*n)^2 + 2*(2*n)) * ((2*n-1)^2 + 2*(2*n-1)) * prod (n-1)

-- 4
sumaPrimerosNImpares :: Integer -> Integer
sumaPrimerosNImpares 0 = 0
sumaPrimerosNImpares n = 2*(2*n-1)+2 + sumaPrimerosNImpares (n-1)

-- 5
combinacionesMenoresOiguales :: Integer -> Integer
combinacionesMenoresOiguales n = iteradorContador n n n
  where
    iteradorContador :: Integer -> Integer -> Integer -> Integer
    iteradorContador _ 0 _ = 0
    iteradorContador n i j = iteracionInterna n i j + iteradorContador n (i-1) j
      where
        iteracionInterna :: Integer -> Integer -> Integer -> Integer
        iteracionInterna _ 1 1 = 1
        iteracionInterna n i 1 = beta (i <= n)
        iteracionInterna n i j = beta (i*j <= n) + iteracionInterna n i (j-1)

beta :: Bool -> Integer
beta True = 1
beta False = 0
