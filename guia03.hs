-- Todos los conectores lógicos usados en especificación pueden asumirse con semántica de cortocircuito, por ej. ^ equivale a ^L aunque no esté explicito.

-- 1.a.
f :: Integer -> Integer
f 1 = 8
f 4 = 131
f 16 = 16

-- 1.b.
g :: Integer -> Integer
g 8 = 16
g 16 = 4
g 131 = 1

-- 1.c.
h :: Integer -> Integer
h 8 = f (g (8))
h 16 = f (g (16))
h 131 = f (g (131))

k :: Integer -> Integer
k 1 = g (f (1))
k 4 = g (f (4))
k 16 = g (f (16))

-- 2.a.
{-
problema absoluto(k:Z):Z {
    requiere: {True}
    asegura: {res = signo(k)*k}
}
problema signo(r:R):Z {
    requiere: {True}
    asegura: {(r >= 0 => res =  1)}
    asegura: {(r <  0 => res = -1)}
}
-}
absoluto :: Integer -> Integer
absoluto k | k >= 0 = k
           | otherwise = -k

-- 2.b.
{-
problema maximoabsoluto(k1:Z, k2:Z):Z {
    requiere: {True}
    asegura: {(res =  absoluto(k1)) v (res =  absoluto(k2))}
    asegura: {(res >= absoluto(k1)) ^ (res >= absoluto(k2))}
}
-}
maximoabsoluto :: Integer -> Integer -> Integer
maximoabsoluto k1 k2 | absoluto(k1) >= absoluto(k2) = absoluto(k1)
                     | otherwise = absoluto(k2)

-- 2.c.
{-
problema maximo3(k1:Z, k2:Z, k3:Z):Z {
    requiere: {True}
    asegura: {(res =  k1) v (res =  k2) v (res =  k3)}
    asegura: {(res >= k1) ^ (res >= k2) ^ (res >= k3)}
}
-}
maximo3 :: Integer -> Integer -> Integer -> Integer
maximo3 k1 k2 k3 | k1 >= k2 && k1 >= k3 = k1
                 | k2 >= k1 && k2 >= k3 = k2
                 | otherwise = k3

-- 2.d.
{-
problema algunoEs0(q1:Q, q2:Q):B {
    requiere: {True}
    asegura: {res = (q1 = 0 v q2 = 0)}
}
-}
algunoEs0 :: Float -> Float -> Bool
algunoEs0 q1 q2 = q1 == 0 || q2 == 0
{-
algunoEs0 :: Float -> Float -> Bool
algunoEs0 _ 0 = True
algunoEs0 0 _ = True
algunoEs0 _ _ = False
-}

-- 2.e.
{-
problema ambosSon0(q1:Q, q2:Q):B {
    requiere: {True}
    asegura: {res = (q1 = 0 ^ q2 = 0)}
}
-}
ambosSon0 :: Float -> Float -> Bool
ambosSon0 q1 q2 = q1 == 0 && q2 == 0
{-
ambosSon0 :: Float -> Float -> Bool
ambosSon0 0 0 = True
ambosSon0 _ _ = False
-}

-- 2.f.
{-
problema mismoIntervalo(r1:R, r2:R):B {
    requiere: {True}
    asegura: {res = menoresQue3(r1, r2) v entre3y7(r1, r2) v mayoresQue7(r1,r2)}
}
pred menoresQue3(r1:R, r2:R) {
    (r1 <= 3) ^ (r2 <= 3)
}
pred entre3y7(r1:R, r2:R) {
    (7 >= r1 > 3) ^ (7 >= r2 > 3)
}
pred mayoresQue7(r1:R, r2:R) {
    (r1 > 7) ^ (r2 > 7)
}
-}
mismoIntervalo :: Float -> Float -> Bool
mismoIntervalo r1 r2 | r1 <= 3 && r2 <= 3 = True
                     | r1 > 3 && r1 <= 7 && r2 > 3 && r2 <= 7 = True
                     | r1 > 7 && r2 > 7 = True
                     | otherwise = False

-- 2.g.
{-
problema sumaDistintos(k1:Z, k2:Z, k3:Z):Z {
    requiere: {True}
    asegura: {res = k1 + k2*beta(k2 != k1) + k3*beta(k3 != k1 ^ k3 != k2)} -- Recursión
}
problema beta(b:Bool):Z {
    requiere: {True}
    asegura: {(b = True => res = 1) ^ (b = False => res = 0)}
}
-}
beta :: Bool -> Integer
beta True = 1
beta False = 0

sumaDistintos :: Integer -> Integer -> Integer -> Integer
sumaDistintos k1 k2 k3 = k1 + k2*beta (k2 /= k1) + k3*beta (k3 /= k1 && k3 /= k2)


-- 2.h.
{-
problema esMultiploDe(n:Z, m:Z):B {
    requiere: {True}
    asegura: {res = (∃k:Z)(m*k = n)}
}
-}
esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe n m = mod n m == 0

-- 2.i.
{-
problema digitoUnidades(n:N):N {
    requiere: {True}
    asegura: {n = 10*(n//10) + res} -- //: division entera, n//10 = div n 10
}
-}
digitoUnidades :: Integer -> Integer
digitoUnidades n = mod n 10 

-- 2.j.
{-
problema digitoDecenas(n:N):N {
    requiere: {True}
    asegura: {n = 100*(n//100) + res*10 + digitoUnidades(n)} -- Recursión
}
-}
digitoDecenas :: Integer -> Integer
digitoDecenas n = div (mod n 100 - mod n 10) 10 

-- 3. -- a*b múltiplo de a*a
estanRelacionados :: Integer -> Integer -> Bool
estanRelacionados a b = esMultiploDe (a*a) (a*b)

-- 4.a.
{-
problema prodInt(a:RxR, b:RxR):R {
    requiere: {True}
    asegura: {res = a_0*b_0 + a_1*b_1} -- _: sub, a_0 = a sub 0 (a en índice 0)
}
-}
prodInt :: (Float, Float) -> (Float, Float) -> Float
prodInt (a0, a1) (b0, b1) = a0*b0 + a1*b1

-- 4.b.
{-
problema todoMenor(a:RxR, b:RxR):B {
    requiere: {True}
    asegura: {res = (a_0 < b_0 ^ a_1 < b_1)}
}
-}
todoMenor :: (Float, Float) -> (Float, Float) -> Bool
todoMenor (a0, a1) (b0, b1) = a0 < b0 && a1 < b1

-- 4.c.
{-
problema distanciaPuntos(a:RxR, b:RxR):R {
    requiere: {True}
    asegura: {res = sqrt((a_0 - b_0)**2 + (a_1 - b_1)**2)}
}
-}
distanciaPuntos :: (Float, Float) -> (Float, Float) -> Float
distanciaPuntos (a0, a1) (b0, b1) = sqrt ((a0 - b0)**2 + (a1 - b1)**2)

-- 4.d.
{-
problema sumaTerna(t:ZxZxZ):Z {
    requiere: {True}
    asegura: {res = t_0 + t_1 + t_2}
}
-}
sumaTerna :: (Integer, Integer, Integer) -> Integer
sumaTerna (t0, t1, t2) = t0 + t1 + t2

-- 4.e.
{-
problema sumarSoloMultiplos(t:ZxZxZ, n:N):Z {
    requiere: {True}
    asegura: {res = t_0*beta(esMultiploDe(t_0, n)) + 
                    t_1*beta(esMultiploDe(t_1, n)) +
                    t_2*beta(esMultiploDe(t_2, n))}
}
-}
sumarSoloMultiplos :: (Integer, Integer, Integer) -> Integer -> Integer
sumarSoloMultiplos (t0, t1, t2) n = t0*betaMul t0 n + t1*betaMul t1 n + t2*betaMul t2 n
                                    where betaMul :: Integer -> Integer -> Integer
                                          betaMul k n = beta (esMultiploDe k n)

-- 4.f.
{-
problema posPrimerPar(t:ZxZxZ):Z {
    requiere: {True}
    asegura: {res = 4 v esMultiploDe(t_res, 2)} -- ... v t_res mod 2 = 0
    asegura: {res < 3 => ¬(∃i:Z)((0 <= i < res) ^ esMultiploDe(t_i, 2))}
}
-}
posPrimerPar :: (Integer, Integer, Integer) -> Integer
posPrimerPar (t0, t1, t2) | esMultiploDe t0 2 = 0
                          | esMultiploDe t1 2 = 1
                          | esMultiploDe t2 2 = 2
                          | otherwise = 4

-- 4.g.
{-
problema crearPar(a:t1, b:t2):t1xt2 {
    requiere: {True}
    asegura: {res = (a, b)}
}
-}
crearPar :: t1 -> t2 -> (t1, t2)
crearPar a b = (a, b)

-- 4.h.
{-
problema invertir(t:t1xt2):t2xt1 {
    requiere: {True}
    asegura: {res = (t_1, t_0)}
}
-}
invertir :: (t1, t2) -> (t2, t1)
invertir (a, b) = (b, a)

-- 5.
todosMenores :: (Integer, Integer, Integer) -> Bool
todosMenores (n1, n2, n3) = f(n1) > g(n1) && f(n2) > g(n2) && f(n3) > g(n3)
    where f :: Integer -> Integer
          f n | n <= 7 = n*n
              | otherwise = 2*n - 1
          g :: Integer -> Integer
          g n | esPar n = div n 2
              | otherwise = 3*n + 1
                where esPar n = esMultiploDe n 2 

-- 6.
bisiesto :: Integer -> Bool
bisiesto a = esMultiploDe a 4 && (not (esMultiploDe a 100) || esMultiploDe a 400)

-- 7.
distanciaManhattan:: (Float, Float, Float) -> (Float, Float, Float) -> Float
distanciaManhattan (a0, a1, a2) (b0, b1, b2) = abs (a0 - b0) + abs (a1 - b1) + abs (a2 - b2)

-- 8.
comparar :: Integer -> Integer -> Integer
comparar a b | sumaUltimosDosDigitos a < sumaUltimosDosDigitos b = 1
             | sumaUltimosDosDigitos a > sumaUltimosDosDigitos b = -1
             | otherwise = 0
               where sumaUltimosDosDigitos :: Integer -> Integer
                     sumaUltimosDosDigitos a = digitoUnidades a + digitoDecenas a

-- 9.a.
{-
Devuelve 1 si n vale 0, devuelve 0 en cualquier otro caso
problema esCero(n:R):R {
    requiere: {True}
    asegura: {res = beta(n = 0)}
}
-}

-- 9.b.
{-
Devuelve 15 si n vale 1, -15 si n vale -1. Se indefine para otros valores de n
problema multUnidadPorQuince(n:R):R {
    requiere: {n = 1 v n = -1}
    asegura: {res = n*15}
}
-}

-- 9.c.
{-
Devuelve 7 si n <= 9, 5 si n > 9 (por el orden de lectura de las condiciones)
problema f3(n:R):R { -- la función es tan ridícula que no puedo nombrarla 
    requiere: {True}
    asegura: {res = 7 - 2*beta(n > 9)}
}
-}

-- 9.d.
{-
Calcula el promedio entre dos valores dados por separado
problema promedio(x:R, y:R):R {
    requiere: {True}
    asegura: {res = (x + y)/2}
}
-}

-- 9.e.
{-
Calcula el promedio entre dos valores dados como dupla
problema promedioDupla(d:RxR):R {
    requiere: {True}
    asegura: {res = (d_0 + d_1)/2}
}
-}

-- 9.f.
{-
Toma un float a y un int b y devuelve si al truncar a (quitarle los decimales) se cumple a == b
problema truncadosIguales(a:R, b:Z):B {
    requiere: {True}
    asegura: {res = (abs(a - b) < 1) ^ (a > b)}
}
-}

main :: IO ()
main = do
    print ("1.", h 8, h 16, h 131, k 1, k 4, k 16)
    print ("2.c.", maximo3 5 8 7)
    print ("2.d.", algunoEs0 0.5 0.1)
    print ("2.e.", ambosSon0 0 0)
    print ("2.g.", sumaDistintos 5 4 5)
    print ("2.h.", esMultiploDe 5 (-10))
    print ("2.i.", digitoUnidades 56)
    print ("2.j.", digitoDecenas 65)
    print ("3.", estanRelacionados 6 2, estanRelacionados 7 3)
    print ("4.c.", distanciaPuntos (1,1) (0,0))
    print ("4.e.", sumarSoloMultiplos (10,-8,-5) 2, sumarSoloMultiplos (66,21,4) 5, sumarSoloMultiplos (-30,2,12) 3)
    print ("4.g.", crearPar 5 True)
    print ("4.h.", invertir (5, True))
    print ("6.", bisiesto 1901, bisiesto 1900, bisiesto 1904, bisiesto 2000)
    print ("7.", distanciaManhattan (2, 3, 4) (7, 3, 8), distanciaManhattan ((-1), 0, (-8.5)) (3.3, 4, (-4)))
    print ("8.", comparar 45 312, comparar 2312 7, comparar 45 172)
