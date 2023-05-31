"""
1.1.
                               result = y
                              ^          \ 
                             / True       v
result: int = 0 -> if (x < y)              return result
                             \ False      ^
                              v          /
                               result = x

1.2.
test1 cubre lineas L1, L2, L4, L5
test2 cubre lineas L1, L2, L3, L5

1.3.
test1 cubre branch L2-False
test2 cubre branch L2-True

1.4.
Cobertura del test suite en sentencias: 5/5, 100%
Cobertura del test suite en branches: 2/2, 100%
La afirmación es verdadera.

2.1.
                               result = x
                              ^          \ 
                             / True       v
result: int = 0 -> if (x < y)              return result
                             \ False      ^
                              v          /
                               result = x

2.2.
Si, test1 cubre lineas L1, L2, L3 y L5, test2 cubre lineas L1, L2, L4 y L5.

2.3.
Si, test1 cubre branch L2-True y test2 cubre branch L2-False.

2.4.
No, se obtendrían los outputs esperados para todos los tests.

2.5.
test3: yMenor
- Entrada: x = 1, y = 0
- Salida esperada: 0

3.1.
result: int = 0 -> result += x -> result += y -> return result

3.2.
Debido a la ausencia de ramificaciones y a la imposibilidad 
de generar valores indefinidos, se requiere de un único test
para lograr una cobertura de sentencias del 100%.
test1: sumarPositivoConPositivo
- Entrada: x = 1, y = 2
- Salida esperada: 3

4.1.
result: int = 0 -> result += x -> result += y -> return result

4.2.
test1: restarPositivoAPositivo
- Entrada: x = 2, y = 1
- Salida esperada: 1

4.3.
Si, test1 devolvería 3 con salida esperada: 1.

5.1.
                             result = -1 ------------
                            ^                        \ 
                           / True                     v
result: int = 0 -> if (x<0)              result = 1 -> return result 
                           \ False      ^             ^
                            v          / True        /
                             if (x > 0)             /
                                       \ False     /
                                        \_________/
                                          (x == 0)

5.2.
test1: valorPositivo
- Entrada: x = 2
- Salida esperada: 1
test2: valorNegativo
- Entrada: x = -2
- Salida esperada: -1
test3: valorNulo
- Entrada: x = 0
- Salida esperada: 0

5.3.
Si, cubre 3/3 branches.

6.1.
                                 result = -x
                                ^           \ 
                               / True        v
result: float = 0 -> if (x < 0)               return result
                               \ False       ^
                                v___________/

6.2.
test1: valorPositivo
- Entrada: x = 1.5
- Salida esperada: 1.5
test2: valorNegativo
- Entrada: x = -1.5
- Salida esperada: 1.5

6.3.
test1, test2

6.4.
test2

6.5.
Los test suites de los puntos 6.2. y 6.3. detectan el error 
gracias a test1. El test suite 6.4 no detecta el error, pero 
no se lo puede modificar de manera tal que simultaneamente
detecte al error, cubra todas las sentencias y no cubra todas
las branches. Si el test suite cubre todas las sentencias
entonces necesariamente cubre la rama L2-True, por lo tanto
no puede haber otro test en el suite que cubra la rama L2-False,
que sería un test que detectaría el error para todo input x > 0.

7.1.
            return -x
           ^
          / True
if (x < 0)
          \ False
           v
            return +x

7.2.
test1: valorPositivo
- Entrada: x = 1.5
- Salida esperada: 1.5
test2: valorNegativo
- Entrada: x = -1.5
- Salida esperada: 1.5

8.1.
                                                         return result
                                                        ^
                                                       / False
result: int = 0 -> count: int = 0 -> while (count < 10)
                                      ^                \ True
                                       \                v
                                        \                result += x -> count += 1
                                         \                                        \ 
                                          \_______________________________________/

8.2.
test1: mult5Por10
- Entrada: x = 5
- Salida esperada: 50

9.1.
                                                  sumando = -1 -> abs_y = -y                                                              return result
                                                 ^                          \                                                            ^
                                                / True                       v                                                          / False
sumando: int = 0 -> abs_y: int = 0 -> if (y < 0)                              result: int = x -> count: int = 0 -> while (count < abs_y)
                                                \ False                      ^                                      ^                   \ True
                                                 v                          /                                        \                   v
                                                  sumando = +1 -> abs_y = +y                                          \                   result += sumando -> count += 1
                                                                                                                       \                                                 \ 
                                                                                                                        \________________________________________________/
                                                                                                                      
9.2.
test1: sumar0
- Entrada: x = 5, y = 0
- Salida esperada: 5
test2: sumarNegativo
- Entrada: x = 3, y = -2
- Salida esperada: 1

9.3.
test1, test2

10.1.
                            AssertionError
                           ^
                          / False
assert (x >= 0 and y >= 0)                                  return x
                          \ True                           ^
                           v                              / False
                            tmp: int = 0 -> while (y != 0)
                                             ^            \ True
                                              \            v
                                               \            tmp = x % y -> x = y -> y = tmp
                                                \                                          \ 
                                                 \_________________________________________/

10.2.
test1: existeMcdMayorQue1
- Entrada: x = 60, y = 80
- Salida esperada: 20
test2: noCumpleRequiere
- Entrada: x = -1, y = 80
- Salida esperada: Error (asumiendo que la condición en L1 
  efectivamente era parte del requiere de la especificación)

11.1.
                                 return 4
                                ^
                               / True
if (a <= 0 or b <= 0 or c <= 0)                                                    return 4
                               \ False                                            ^
                                v                                                / True
                                 if (not (a + b > c and a + c > b and b + c > a))                          return 1
                                                                                 \ False                  ^
                                                                                  v                      / True
                                                                                   if (a == b and b == c)                                   return 2
                                                                                                         \ False                           ^
                                                                                                          v                               / True
                                                                                                           if (a == b or b == c or a == c)
                                                                                                                                          \ 
                                                                                                                                           v
                                                                                                                                            return 3

11.2.
test1: inválidoLadoNegativo
- Entrada: a = -1, b = 1, c = 3
- Salida esperada: 4
test2: inválidoGeometríaImposible
- Entrada: a = 1, b = 1, c = 3
- Salida esperada: 4
test3: equilatero
- Entrada: a = 2, b = 2, c = 2
- Salida esperada: 1
test4: isosceles
- Entrada: a = 2, b = 2, c = 1.5
- Salida esperada: 2
test5: escaleno
- Entrada: a = 2, b = 3, c = 4
- Salida esperada: 3

12.1. 
                                        return -1
                                       ^
                                      / True
abs_y: int = fabs(y) -> if (abs_y < 0)                                                      return result
                                      \ False                                              ^
                                       v                                                  / False
                                        result: int = 0 -> i: int = 0 -> while (i < abs_y)
                                                                          ^               \ True
                                                                           \               v 
                                                                            \               result += x -> i += 1
                                                                             \                                   \ 
                                                                              \__________________________________/

12.2.
La linea L3 y la branch L2-True no pueden ser cubiertas ya que 
es imposible que se cumpla abs_y < 0 asumiendo el correcto 
funcionamiento de fabs().

12.3.
test1: multiplicaciónPor0
- Entrada: x = 5, y = 0
- Salida esperada: 0
test2: multiplicaciónDePositivoPorNegativo
- Entrafa x = 5, y = -3
- Salida esperada: 15

13.1. 
                              return None
                             ^
                            / False
INIT: i = 0 -> COND: i < |s| 
                ^           \ True
                 \           v
                  \           s[i] = 0 -> INCR: i += 1
                   \                                  \ 
                    \_________________________________/

13.2.
test1: seqNoVacía
- Entrada: s = [1,2,3]
- Salida esperada: None, s modificada in-place a [0, 0, 0]

13.3.
El test test1 cubre todas las lineas y branches.

14.1.
                                                      return result <-------------------_
                                                     ^                                   \ 
                                                    / False                               \ 
result: bool = False -> INIT: i = 0 -> COND: i < |s|                  result = True -> break 
                                        ^           \ True           ^
                                         \           v              / True
                                          \           if (s[i] == e)
                                           \                        \ False
                                            \                        v
                                             \                        INCR: i += 1
                                              \                                   \ 
                                               \__________________________________/

14.2.
test1: pertenece
- Entrada: s = [1,2,3], e = 2
- Salida esperada: True

14.3.
test1 cubre todas las branches excepto L2(COND)-False,
por lo tanto un test suite que cubra todas las branches
podría consistir de test1 y test2, siendo este último:
test2: noPertenece
- Entrada: s = [1,2,3], e = 4
- Salida esperada: False

15.1.
                                                 return result
  cantidadDePrimos(n: int) -> int               ^                                                         
                                               / False                                                     
result: int = 0 -> INIT: i = 2 -> COND: i < n+1                                              result += 1    
                                   ^           \ True                                       ^           \    
                                    \           v                                          / True        \    
                                     \           inc: bool = esPrimo(i) -> if (inc == True)               \    
                                      \                                                    \ False        /    
                                       \                                                    v            v    
                                        \                                                    INCR: i += 1
                                         \                                                               \ 
                                          \______________________________________________________________/

                                                   return result
  esPrimo(x: int) -> bool                         ^
                                                 / False
result: bool = True -> INIT: i = 2 -> COND: i < x                   result = False
                                       ^         \ True            ^              \ 
                                        \         v               / True          |
                                         \         if (x % i == 0)                /  
                                          \                       \ False        /
                                           \                       v            v 
                                            \                       INCR: i += 1
                                             \                                  \ 
                                              \_________________________________/

15.2.
test1: menoresQue10 (cantidadDePrimos())
- Entrada: n = 10
- Salida esperada: 4

15.3.
test1 cubre todas las sentencias y branches de ambas funciones.

16.1.
                                                                                                    return result <--------------------------------------------------------------------------------------------------------_
  esSubsecuencia(s: [int], r: [int]) -> bool                                                       ^                                                                                                                        \  
                                                                                                  / False                                                                                                                    \ 
result: bool = False -> ultimoIndice: int = |s| - |r| -> INIT: i = 0 -> COND: i < ultimoIndice + 1                                                                                                       result = True -> break
                                                                         ^                        \ True                                                                                                ^
                                                                          \                        v                                                                                                   / True
                                                                           \                        subseq: [int] = subsecuencia(s, i, |r|) -> sonIguales: bool = iguales(subseq, r) -> if (sonIguales)
                                                                            \                                                                                                                          \ False
                                                                             \                                                                                                                          v
                                                                              \                                                                                                                          INCR: i += 1
                                                                               \                                                                                                                                     \ 
                                                                                \____________________________________________________________________________________________________________________________________/

                                                                                       return rv
  subsecuencia(s: [int], desde: int, longitud: int) -> [int]                          ^
                                                                                     / False
rv: [int] = [] -> hasta: int = desde + longitud -> INIT: i = desde -> COND: i < hasta
                                                                       ^             \ True
                                                                        \             v
                                                                         \             elem = s[i] -> rv.append(elem) -> INCR: i += 1
                                                                          \                                                          \ 
                                                                           \_________________________________________________________/

                                        result = False -> return result <-----------------------------------_
  iguales(a: [int], b: [int]) -> bool  ^                              ^                                      \ 
                                      / False                         |                                       \   
result: bool = True -> if (|a| == |b|)                                /                                        \ 
                                      \ True                         /                                          \  
                                       v                            / False                                     / 
                                        INIT: i = 0 -> COND: i < |a|                     result = False -> break
                                                        ^           \ True              ^
                                                         \           v                 / True
                                                          \           if (a[i] != b[i]) 
                                                           \                           \ False
                                                            \                           v
                                                             \                           INCR: i += 1
                                                              \                                      \ 
                                                               \_____________________________________/

16.2.
test1: esSubseq (esSubsecuencia())
- Entrada s = [1,2,3,4,5], r = [2,3]
- Salida esperada: True

16.3.
test 1 no cubre L4(COND)-False ni L26-False
por lo tanto un test suite que cubra todas las branches
podría consistir de test1, test2 y test3, siendo estos último:
test2: noEsSubseq (esSubsecuencia()) (cubre L4(COND)-False)
- Entrada: s = [1,2,3,4,5], r = [6,7]
- Salida esperada: False
test3: distintaLongitud (iguales()) (cubre L26-False)
- Entrada: a = [1,2,3], b = [1,2,3,4]
- Salida esperada: False

# 17.1.
                                                           return n
                                                          ^
                                                         / False
n: int = 0 -> i: int = 0 -> f: int = 0 -> while (i < |s|)              n = f -----_
                                           ^             \ True       ^            \ 
                                            \             v          / True         \ 
                                             \             if (f > n)                \        f = 0 ------_
                                              \                      \ False         /       ^             \ 
                                               \                      v             v       / True          \   
                                                \                      if (s[i] == ';') ---|                 \ 
                                                 \                                          \ False          /
                                                  \                                          v              v
                                                   \                                          f += 1 -> i += 1
                                                    \                                                         \ 
                                                     \________________________________________________________/

# 17.2. 
Si existe un fragmento de longitud máxima f t.q. f > 0
y dicho fragmento se encuentra exactamente al final del
string input (sin siquiera un punto y coma al final),
el output de la función será n = f - 1 en vez del output
esperado, n = f. Esto se debe a que en cada ciclo
la actualización de n se da antes del incremento de f,
y por lo tanto n no es actualizado luego del último ciclo.
test1: existeFragmentoLargo
- Entrada: "Venus;Mercurio"
- Salida esperada: 8

# 17.3.
test1 cubre todas las sentencias y branches del programa.
"""

# Prueba 17.2.
def calcular_fragmento_mas_largo(s: str) -> int:
  n: int = 0
  i: int = 0
  f: int = 0
  while i < len(s):
    if f > n:
      n = f
    if s[i] == ';':
      f = 0
    else:
      f += 1
    i += 1
  return n

print(calcular_fragmento_mas_largo("Venus;Mercurio"))