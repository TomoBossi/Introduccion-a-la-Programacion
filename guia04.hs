-- 1.
fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

-- 2.
-- Es posible que la especificación esté mal, tendría más sentido que la resolución sea sólo parteEnteraAux sin el parche de su wrapper.
parteEntera :: Float -> Integer
parteEntera x | x < 0 && x > -1 = -1 + parteEnteraAux x
              | otherwise = parteEnteraAux x
    where parteEnteraAux :: Float -> Integer
          parteEnteraAux x | x <= -1 = -1 + parteEntera (x+1)
                           | x >=  1 =  1 + parteEntera (x-1)
                           | otherwise = 0

-- 3.
esDivisible :: Integer -> Integer -> Bool
esDivisible _ 0 = False
esDivisible 0 _ = True
esDivisible n d = n > 0 && esDivisible (n-d) d

-- 4.
sumaImpares :: Integer -> Integer
sumaImpares 0 = 0
sumaImpares n = n*2-1 + sumaImpares (n-1)

-- 5.
medioFact :: Integer -> Integer
medioFact 0 = 1
medioFact 1 = 1
medioFact n = n * medioFact (n-2)

-- 6.
sumaDigitos :: Integer -> Integer
sumaDigitos 0 = 0
sumaDigitos 1 = 1
sumaDigitos n = mod n 10 + sumaDigitos (div n 10)

-- 7.
todosDigitosIguales :: Integer -> Bool
todosDigitosIguales n | n < 10 = True
                      | otherwise = mod n 10 == mod (div n 10) 10 && todosDigitosIguales (div n 10)

-- 8.
-- El dígito i=1 es el de las unidades.
iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito n 1 = mod n 10
iesimoDigito n i = iesimoDigito (div n 10) (i-1)

cantDigitos :: Integer -> Integer
cantDigitos n | n < 10 = 1
              | otherwise = 1 + cantDigitos (div n 10)

-- 9.
esCapicua :: Integer -> Bool
esCapicua n | n < 10 = True
            | otherwise = digitoUnidades == digitoIzquierda && esCapicua nSinBordes
    where digitoUnidades = mod n 10
          digitoIzquierda = div n (10^(cantDigitos n - 1))
          nSinBordes = div (n - 10^(cantDigitos n - 1) * digitoIzquierda) 10

-- 10.a.
-- Integer.
f1 :: Integer -> Integer
f1 0 = 1
f1 n = 2^n + f1 (n-1)

-- 10.b.
-- Real.
f2 :: Integer -> Float -> Float
f2 1 q = q
f2 n q = q^n + f2 (n-1) q

-- 10.c.
-- Real.
f3 :: Integer -> Float -> Float
f3 0 _ = 0
f3 1 q = q^2 + q
f3 n q = q^(2*n) + q^(2*n - 1) + f3 (n-1) q

-- 10.d.
-- Real.
f4 :: Integer -> Float -> Float
f4 0 _ = 0
f4 n q = f4Hasta2n n n q
    where f4Hasta2n :: Integer -> Integer -> Float -> Float
          f4Hasta2n n m q | m == 2*n = q^m
                          | otherwise = q^m + f4Hasta2n n (m+1) q

-- 11.
fac :: Integer -> Integer
fac 0 = 1
fac n = n * fac (n-1)

eAprox :: Integer -> Float
eAprox 0 = 1
eAprox n = 1.0/(fromIntegral (fac n)) + eAprox (n-1)
e :: Float
e = eAprox 10

-- 12.
raizDe2Aprox :: Integer -> Float
raizDe2Aprox n = sucesion n - 1
    where sucesion :: Integer -> Float
          sucesion 1 = 2.0
          sucesion n = 2.0 + 1.0/(sucesion (n-1))

-- 13.
f :: Integer -> Integer -> Integer
f 1 m = m -- se rompe con sumaInterna 1 m
f n m = sumaInterna n m + f (n-1) m
    where sumaInterna :: Integer -> Integer -> Integer
          sumaInterna n 1 = n
          sumaInterna n m = n^m + sumaInterna n (m-1)

-- 14.
sumaPotencias :: Integer -> Integer -> Integer -> Integer
sumaPotencias q 1 1 = q^2
sumaPotencias q 1 m = q^(1+m) + sumaPotencias q 1 (m-1)
sumaPotencias q n m = sumaInterna q n m + sumaPotencias q (n-1) m
    where sumaInterna :: Integer -> Integer -> Integer -> Integer
          sumaInterna q n 1 = q^(n+1)
          sumaInterna q n m = q^(n+m) + sumaInterna q n (m-1)

-- 15.
sumaRacionales :: Integer -> Integer -> Float
sumaRacionales 1 1 = 1.0
sumaRacionales 1 m = 1.0/(fromIntegral m) + sumaRacionales 1 (m-1)
sumaRacionales n m = sumaInterna n m + sumaRacionales (n-1) m
    where sumaInterna :: Integer -> Integer -> Float
          sumaInterna n 1 = fromIntegral n
          sumaInterna n m = (fromIntegral n)/(fromIntegral m) + sumaInterna n (m-1)

-- 16.a.
menorDivisor :: Integer -> Integer
menorDivisor n = menorDivisorDesde 2 n
    where menorDivisorDesde :: Integer -> Integer -> Integer
          menorDivisorDesde m n | m > n = n
                                | mod n m == 0 = m
                                | otherwise = menorDivisorDesde (m+1) n

-- 16.b.
esPrimo :: Integer -> Bool
esPrimo n = n > 1 && n == menorDivisor n

-- 16.c.
sonCoprimos :: Integer -> Integer -> Bool
sonCoprimos n1 n2 | n1 > n2 = mod n2 d1 /= 0 && sonCoprimos (div n1 d1) n2
                  | n1 < n2 = mod n1 d2 /= 0 && sonCoprimos n1 (div n2 d2)
                  | otherwise = n1 == 1 || n2 == 1
    where d1 = menorDivisor n1
          d2 = menorDivisor n2

-- 16.d.
-- El primo n = 1 es el primer primo
nEsimoPrimo :: Integer -> Integer
nEsimoPrimo n = nEsimoPrimoDesde 1 n
    where nEsimoPrimoDesde :: Integer -> Integer -> Integer
          nEsimoPrimoDesde m 0 = m - 1
          nEsimoPrimoDesde m n | esPrimo m = nEsimoPrimoDesde (m+1) (n-1)
                               | otherwise = nEsimoPrimoDesde (m+1) n

-- 17.
esFibonacci :: Integer -> Bool
esFibonacci n = esFibonacciAux n 0 1
    where esFibonacciAux :: Integer -> Integer -> Integer -> Bool
          esFibonacciAux n f2 f1 | f1 > n = False
                                 | f1 == n = True
                                 | otherwise = esFibonacciAux n f1 (f2 + f1)

-- 18.
mayorDigitoPar :: Integer -> Integer
mayorDigitoPar n = mayorDigitoParAux n (-1)
    where mayorDigitoParAux :: Integer -> Integer -> Integer
          mayorDigitoParAux 0 d = d
          mayorDigitoParAux n d | unidadPar && d < unidad = mayorDigitoParAux (div n 10) unidad
                                | otherwise = mayorDigitoParAux (div n 10) d
                                  where unidad = mod n 10
                                        unidadPar = mod unidad 2 == 0

-- 19.
esSumaInicialDePrimos :: Integer -> Bool
esSumaInicialDePrimos n = esSumaInicialDePrimosDesde n 2
    where esSumaInicialDePrimosDesde :: Integer -> Integer -> Bool
          esSumaInicialDePrimosDesde n p | n == 0 = True
                                         | n < 0 = False
                                         | esPrimo p = esSumaInicialDePrimosDesde (n-p) (p+1)
                                         | otherwise = esSumaInicialDePrimosDesde n (p+1)

-- 20.
sumaDivisores :: Integer -> Integer
sumaDivisores n = sumaDivisoresDesde n n
    where sumaDivisoresDesde :: Integer -> Integer -> Integer
          sumaDivisoresDesde n 1 = 1
          sumaDivisoresDesde n d | esDivisible n d = d + sumaDivisoresDesde n (d-1)
                                 | otherwise = sumaDivisoresDesde n (d-1)

tomaValorMax :: Integer -> Integer -> Integer
tomaValorMax n1 n2 = tomaValorMaxAux n1 n2 n1
    where tomaValorMaxAux :: Integer -> Integer -> Integer -> Integer
          tomaValorMaxAux n1 n2 m | n1 > n2 = m
                                  | sumaDiv > sumaDivisores m = tomaValorMaxAux (n1+1) n2 n1
                                  | otherwise = tomaValorMaxAux (n1+1) n2 m
                                    where sumaDiv = sumaDivisores n1

-- 21.
beta :: Bool -> Integer
beta True = 1
beta False = 0

pitagoras :: Integer -> Integer -> Integer -> Integer
pitagoras 0 0 r = 1
pitagoras 0 m r = beta (m^2 <= r^2) + pitagoras 0 (m-1) r
pitagoras n m r = pitagoras (n-1) m r + iterInterna n m r
    where iterInterna :: Integer -> Integer -> Integer -> Integer
          iterInterna n 0 r = beta (n^2 <= r^2)
          iterInterna n m r = beta (n^2 + m^2 <= r^2) + iterInterna n (m-1) r

main :: IO ()
main = do
    print ("1.", fibonacci 6) -- fib(0) = 0, 1, 1, 2, 3, 5, 8 = fib(6)
    print ("2.", parteEntera 5.25, parteEntera (-1.2), parteEntera (-2), parteEntera (-0.5), parteEntera (0.5))
    print ("3.", esDivisible 5 2, esDivisible 15 3)
    print ("4.", sumaImpares 3)
    print ("5.", medioFact 10, medioFact 9, medioFact 0)
    print ("6.", sumaDigitos 243010)
    print ("7.", todosDigitosIguales 234, todosDigitosIguales 444, todosDigitosIguales 5)
    print ("8.", iesimoDigito 134 1, iesimoDigito 134 2, iesimoDigito 134 3)
    print ("9.", esCapicua 12344321, esCapicua 12344521, esCapicua 11)
    print ("10.b.", f2 3 2.0) -- 8 + 4 + 2 = 14
    print ("10.c.", f3 2 2.0) -- 16 + 8 + 4 + 2 = 30
    print ("10.d.", f4 2 2.0) -- 16 + 8 + 4 = 28
    print ("11.", e)
    print ("12.", raizDe2Aprox 1, raizDe2Aprox 2, raizDe2Aprox 3)
    print ("13.", f 3 3) -- 27 + 9 + 3 + 8 + 4 + 2 + 1 + 1 + 1 = 56
    print ("14.", sumaPotencias 2 2 2) -- 2^(2+2) + 2^(2+1) + 2^(1+2) + 2^(1+1) = 16 + 2*8 + 4 = 36
    print ("15.", sumaRacionales 2 2) -- 2/2 + 2/1 + 1/2 + 1/1 = 1 + 2 + 0.5 + 1 = 4.5
    print ("16.c.", sonCoprimos 8 9, sonCoprimos 10 15, sonCoprimos 2 1)
    print ("16.d.", nEsimoPrimo 3)
    print ("17.", esFibonacci 55, esFibonacci 54, esFibonacci 34)
    print ("18.", mayorDigitoPar 358962650742, mayorDigitoPar 1357)
    print ("19.", esSumaInicialDePrimos (2+3+5+7), esSumaInicialDePrimos (2+3+5+7 + 13))
    print ("20.", tomaValorMax 10 15)
    print ("21.", pitagoras 3 4 5, pitagoras 3 4 2)