-- 1.1.
longitud :: [t] -> Integer
longitud [] = 0
longitud (_:xt) = 1 + longitud xt

-- 1.2.
ultimo :: [t] -> t
ultimo (xh:[]) = xh
ultimo (_:xt) = ultimo xt

-- 1.3.
principio :: [t] -> [t]
principio (_:[]) = []
principio (xh:xt) = xh:principio xt

-- 1.4.
reverso :: [t] -> [t]
reverso [] = []
reverso xt = (ultimo xt):(reverso (principio xt))

-- 2.1.
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece e (xh:xt) = xh == e || pertenece e xt

-- 2.2.
todosIguales :: (Eq t) => [t] -> Bool
todosIguales (xh:[]) = True
todosIguales (xh:xt) = xh == head xt && todosIguales xt

-- 2.3.
todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos (xh:[]) = True
todosDistintos (xh:xt) = not (pertenece xh xt) && todosDistintos xt

-- 2.4.
hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos xt = not (todosDistintos xt)

-- 2.5.
quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar e (xh:xt) 
  | e == xh = xt
  | otherwise = xh:(quitar e xt)

-- 2.6.
quitarTodos :: (Eq t ) => t -> [t] -> [t]
quitarTodos e xt 
  | pertenece e xt = quitarTodos e (quitar e xt)
  | otherwise = xt

-- 2.7.
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos (xh:xt) = xh:(eliminarRepetidos (quitarTodos xh xt))

-- 2.8.
mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos [] [] = True
mismosElementos [] _ = False
mismosElementos (xh:xt) y = pertenece xh y && mismosElementos xt_xh y_xh
  where
    xt_xh = quitarTodos xh xt
    y_xh = quitarTodos xh y

-- 2.9.
capicua :: (Eq t) => [t] -> Bool
capicua x = x == reverso x

-- 3.1.
sumatoria :: (Num t) => [t] -> t -- signatura generalizada
sumatoria [] = 0
sumatoria (xh:xt) = xh + sumatoria xt

-- 3.2.
productoria :: (Num t) => [t] -> t -- signatura generalizada
productoria [] = 1
productoria (xh:xt) = xh * productoria xt

-- 3.3.
maximo :: [Integer] -> Integer
maximo (xh:[]) = xh
maximo (xh:xt)
  | xh >= head xt = maximo (xh:(tail xt))
  | otherwise = maximo xt

-- 3.4.
sumarN :: Integer -> [Integer] -> [Integer]
sumarN _ [] = []
sumarN n (xh:xt) = (xh + n):(sumarN n xt)

-- 3.5.
sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero x = sumarN (head x) x

-- 3.6.
sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo x = sumarN (ultimo x) x

-- 3.7.
pares :: [Integer] -> [Integer]
pares [] = []
pares (xh:xt)
  | mod xh 2 == 0 = xh:(pares xt)
  | otherwise = pares xt

-- 3.8.
multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN _ [] = []
multiplosDeN n (xh:xt)
  | mod xh n == 0 = xh:(multiplosDeN n xt)
  | otherwise = multiplosDeN n xt

-- 3.9.
ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar x = minx:(ordenar (quitar minx x))
  where
    minx = minimo x

minimo :: [Integer] -> Integer
minimo (xh:[]) = xh
minimo (xh:xt)
  | xh <= head xt = minimo (xh:(tail xt))
  | otherwise = minimo xt

-- 4.1.
sacarBlancosRepetidos :: [Char] -> [Char]
sacarBlancosRepetidos [] = []
sacarBlancosRepetidos (' ':' ':xt) = sacarBlancosRepetidos (' ':xt)
sacarBlancosRepetidos (xh:xt) = xh:(sacarBlancosRepetidos xt)

-- 4.2.
{--
contarPalabras :: [Char] -> Integer
contarPalabras x = longitud (palabras x)
--}
contarPalabras :: [Char] -> Integer
contarPalabras x = contarBlancos (sacarBlancosExtra x) + 1
  where
    contarBlancos :: [Char] -> Integer
    contarBlancos [] = 0
    contarBlancos (xh:xt) = beta (xh == ' ') + contarBlancos xt

beta :: Bool -> Integer
beta True = 1
beta False = 0

sacarBlancosExtra :: [Char] -> [Char]
sacarBlancosExtra x = sacarBlancosExtremos (sacarBlancosRepetidos x)
  where
    sacarBlancosExtremos :: [Char] -> [Char]
    sacarBlancosExtremos [] = []
    sacarBlancosExtremos (' ':xt) = sacarBlancosExtremos xt
    sacarBlancosExtremos x
      | ultimo x == ' ' = principio x
      | otherwise = x

-- 4.3.
palabraMasLarga :: [Char] -> [Char]
palabraMasLarga x = masLarga (palabras x)
  where
    masLarga :: [[Char]] -> [Char]
    masLarga [] = []
    masLarga (xh:[]) = xh
    masLarga (xh:xm:xt) 
      | longitud xh >= longitud xm = masLarga (xh:xt)
      | otherwise = masLarga (xm:xt)

-- 4.4.
palabras :: [Char] -> [[Char]]
palabras [] = []
palabras x = primera:siguientes
  where
    primera = primeraPalabra x
    siguientes = palabras (saltarPrimeraPalabra x)

primeraPalabra :: [Char] -> [Char]
primeraPalabra [] = []
primeraPalabra (xh:' ':xt)
  | xh == ' ' = primeraPalabra xt
  | otherwise = [xh]
primeraPalabra (' ':xt) = primeraPalabra xt
primeraPalabra (xh:xt) = xh:(primeraPalabra xt)

saltarPrimeraPalabra :: [Char] -> [Char]
saltarPrimeraPalabra [] = []
saltarPrimeraPalabra (xh:' ':xt)
  | xh == ' ' = saltarPrimeraPalabra xt
  | otherwise = xt
saltarPrimeraPalabra (xh:xt) = saltarPrimeraPalabra xt

-- 4.5.
aplanar :: [[Char]] -> [Char]
aplanar [] = []
aplanar (xh:xt) = xh `cc` (aplanar xt)

cc :: [t] -> [t] -> [t] -- `cc` == ++
cc [] y = y
cc (xh:xt) y = xh:(cc xt y)

-- 4.6.
aplanarConBlancos :: [[Char]] -> [Char]
aplanarConBlancos [] = []
aplanarConBlancos (xh:[]) = xh
aplanarConBlancos (xh:xt) = xh `cc` [' '] `cc` (aplanarConBlancos xt)

-- 4.7.
aplanarConNBlancos :: [[Char]] -> Integer -> [Char]
aplanarConNBlancos [] _ = []
aplanarConNBlancos (xh:[]) _ = xh
aplanarConNBlancos (xh:xt) n = xh `cc` (nBlancos n) `cc` (aplanarConNBlancos xt n)
  where 
    nBlancos :: Integer -> [Char]
    nBlancos 0 = []
    nBlancos n = ' ':(nBlancos (n-1))

-- 5.1.
nat2bin :: Integer -> [Integer]
nat2bin 1 = [1]
nat2bin n = nat2bin (div n 2) `cc` [mod n 2]

-- 5.2.
bin2nat :: [Integer] -> Integer
bin2nat [] = 0
bin2nat (1:xt) = 2^(longitud xt) + bin2nat xt
bin2nat (0:xt) = bin2nat xt

-- 5.3.
nat2hex :: Integer -> [Char]
nat2hex n
  | n < 16 = [decimalDigit2Hex n]
  | otherwise = nat2hex (div n 16) `cc` [decimalDigit2Hex (mod n 16)]

decimalDigit2Hex :: Integer -> Char
decimalDigit2Hex n
    | n == 00 = '0'
    | n == 01 = '1'
    | n == 02 = '2'
    | n == 03 = '3'
    | n == 04 = '4'
    | n == 05 = '5'
    | n == 06 = '6'
    | n == 07 = '7'
    | n == 08 = '8'
    | n == 09 = '9'
    | n == 10 = 'A'
    | n == 11 = 'B'
    | n == 12 = 'C'
    | n == 13 = 'D'
    | n == 14 = 'E'
    | n == 15 = 'F'

-- 5.4.
sumaAcumulada :: (Num t) => [t] -> [t]
sumaAcumulada [] = []
sumaAcumulada x = sumaAcumulada (principio x) `cc` [sumatoria x]

-- 5.5.
descomponerEnPrimos :: [Integer] -> [[Integer]]
descomponerEnPrimos [] = []
descomponerEnPrimos (xh:xt) = (descomponer xh):(descomponerEnPrimos xt)
  where
    descomponer :: Integer -> [Integer]
    descomponer n = descomponerDesde n 2
      where
        descomponerDesde :: Integer -> Integer -> [Integer]
        descomponerDesde n m 
          | abs n == 1 = []
          | mod n m == 0 = m:descomponerDesde (div n m) m
          | otherwise = descomponerDesde n (m+1)

-- 6.1.
type Set a = [a]
vacio :: Set Integer
vacio = []

agregar :: Integer -> Set Integer -> Set Integer
agregar n [] = [n]
agregar n x 
  | pertenece n x = x
  | otherwise = (n:x)

incluido :: Set Integer -> Set Integer -> Bool
incluido [] _ = True
incluido (x:xs) c = pertenece x c && incluido xs c

iguales :: Set Integer -> Set Integer -> Bool
iguales c1 c2 = incluido c1 c2 && incluido c2 c1

agregarATodos :: Integer -> Set (Set Integer) -> Set (Set Integer)
agregarATodos _ [] = []
agregarATodos n (xh:xt) = (agregar n xh):(agregarATodos n xt)

-- 6.2.
partes :: Integer -> Set (Set Integer) -- conjunto {1, 2, ... , n}
partes 0 = [vacio]
partes n = agregarATodos n (partes (n-1)) `cc` partes (n-1)

-- 6.3.
productoCartesiano :: Set Integer -> Set Integer -> Set (Integer, Integer)
productoCartesiano [] y = []
productoCartesiano (xh:xt) y = emparejarConTodos xh y `cc` productoCartesiano xt y

emparejarConTodos :: Integer -> Set Integer -> Set (Integer, Integer)
emparejarConTodos n [] = []
emparejarConTodos n (xh:xt) = (n, xh):(emparejarConTodos n xt)

main :: IO ()
main = do
  print ("1.2.", ultimo [1,2,3,4,7])
  print ("1.3.", principio [1,2,3,4,7])
  print ("1.4.", reverso [1,2,3,4,7] == reverso (reverso [7,4,3,2,1]))
  print ("2.1.", pertenece 4 [1,2,3,4,7], pertenece 5 [1,2,3,4,7])
  print ("2.2.", todosIguales [1,1,1,2], todosIguales [1,1,1,1])
  print ("2.3.", todosDistintos [1,2,3,4,7], todosDistintos [1,2,3,3,7])
  print ("2.5.", quitar 2 [1,2,3,2,7])
  print ("2.6.", quitarTodos 2 [2,2,1,2,3,2,7,2,7,2,2], quitarTodos 2 [2,2,2])
  print ("2.7.", eliminarRepetidos [7,2,2,1,2,3,7,2,7,2,7])
  print ("2.8.", mismosElementos [1,2,3,4,5,5] [5,4,3,2,1,1])
  print ("2.9.", capicua [1,2,3,2,1], capicua [1,2,3,1,2])
  print ("3.3.", maximo [1,-2,6,3,2])
  print ("3.4.", sumarN 2 [1,-2,6,3,2])
  print ("3.5.", sumarElPrimero [1,-2,6,3,2])
  print ("3.7.", pares [1,2,3,5,8,2])
  print ("3.9.", ordenar [1,3,4,56,-3,2,-8,3,6])
  print ("4.1.", sacarBlancosRepetidos ['H', 'o'])
  print ("4.2.", contarPalabras [' ', ' ', ' ', ' ', 'H', 'o', ' ', ' ', 'T', 'o', 'm', ' ', 'L', 'a', ' ', ' ', 'C', 'o', 'l', 'a'])
  print ("4.3.", palabraMasLarga [' ', ' ', ' ', ' ', 'H', 'o', ' ', ' ', 'T', 'o', 'm', ' ', 'L', 'a', ' ', ' ', 'C', 'o', 'l', 'a'])
  print ("4.4.", longitud (head (palabras [' ', ' ', ' ', ' ', ' ', 'H', 'o', ' ', 'T', 'o', 'm', ' ', 'L', 'a', ' ', ' ', 'C', 'o', 'l', 'a'])))
  print ("4.5.", aplanar [['H', 'o'], ['l', 'a']])
  print ("4.6.", aplanarConBlancos [['H', 'o'], ['l', 'a']])
  print ("4.7.", aplanarConNBlancos [['H', 'o'], ['l', 'a']] 5)
  print ("5.1.", nat2bin 8, nat2bin 37)
  print ("5.2.", bin2nat [1, 0, 0, 0, 1])
  print ("5.3.", nat2hex 45, ['2', 'D']) -- se printea como "2D"
  print ("5.4.", sumaAcumulada [1,2,3,4])
  print ("5.5.", descomponerEnPrimos [2, 20, 6])
  print ("6.1.", agregarATodos 5 [[1,2,3], [4,5,6], [7,8,9]])
  print ("6.2.", partes 3)
  print ("6.3.", productoCartesiano [1, 2, 3] [3, 4])