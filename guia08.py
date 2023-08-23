import numpy as np
import random

# 1.1.
def pertenece(s: list[int], e: int) -> bool:
    return e in s

def pertenece2(s: list[int], e: int) -> bool:
    res: bool = False
    i: int = 0
    while i < len(s):
        if s[i] == e:
            res = True
        i += 1
    return res

def pertenece3(s: list[int], e: int) -> bool:
    i: int = len(s)
    while i > 0:
        if s[i-1] != e:
            s.pop(i-1)
        i -= 1
    return len(s) != 0

# 1.2.
def divideATodos(s: list[int], e: int) -> bool:
    res: bool = True
    i: int = 0
    while i < len(s):
        if s[i]%e != 0:
            res = False
        i += 1
    return res

# 1.3.
def sumaTotal(s: list[int]) -> int:
    res: int = 0
    i: int = 0
    while i < len(s):
        res += s[i]
        i += 1
    return res

# 1.4.
def ordenados(s: list[int]) -> bool:
    res: bool = True
    i: int = 0
    while i < len(s) - 1:
        if s[i] > s[i+1]:
            res = False
        i += 1
    return res

# 1.5.
def hayPalabraLarga(s: list[str]) -> bool:
    res: bool = False
    i: int = 0
    while i < len(s):
        if len(s[i]) > 7:
            res = True
        i += 1
    return res

# 1.6.
def invertir(s: list) -> list:
    res: list = []
    i: int = len(s)
    while i > 0:
        res.append(s[i-1])
        i -= 1
    return res

def esPalindroma(s: str) -> bool:
    return list(s) == invertir(s)

# 1.7.
def passwordSeguro(s: str):
    larga: bool = len(s) > 8
    corta: bool = len(s) < 5
    minus: bool = False
    mayus: bool = False
    num: bool = False

    i: int = 0
    while i < len(s):
        if "a" <= s[i] <= "z":
            minus = True
        elif "A" <= s[i] <= "Z":
            mayus = True
        elif "0" <= s[i] <= "9":
            num = True
        i += 1
    res: str = "AMARILLA"
    if larga and minus and mayus and num:
        res = "VERDE"
    elif corta:
        res = "ROJA"
    return res

# 1.8.
def saldoNeto(historial: list[tuple]) -> float:
    res: float = 0
    i: int = 0
    while i < len(historial):
        tipo: str
        monto: float
        tipo, monto = historial[i]
        res += monto - 2*monto*(tipo == "R")
        i += 1
    return res

# 1.9.
def tiene3vocalesDistintas(s: str) -> bool:
    vocales: list[str] = ["a", "e", "i", "o", "u"]
    vocalesVistas: list[str] = []
    i: int = 0
    while i < len(s):
        if pertenece(vocales, s[i]) and not pertenece(vocalesVistas, s[i]):
            vocalesVistas.append(s[i])
        i += 1
    return len(vocalesVistas) >= 3

# 2.1.
def nulificarIndicesParesInPlace(s: list) -> list:
    i: int = 0
    while i < len(s):
        if i%2 == 0:
            s[i] = 0
        i += 1
    return s

# 2.2.
def nulificarIndicesPares(s: list) -> list:
    res: list = []
    i: int = 0
    while i < len(s):
        res.append(s[i])
        if i%2 == 0:
            res[i] = 0
        i += 1
    return res

# 2.3.
def devocalizar(s: str) -> str:
    vocales: list[str] = ["a", "e", "i", "o", "u"]
    res: str = ""
    i: int = 0
    while i < len(s):
        if not pertenece(vocales, s[i]):
            res += s[i]
        i += 1
    return res

# 2.4.
def reemplazaVocales(s: str) -> str:
    vocales: list[str] = ["a", "e", "i", "o", "u"]
    res: str = ""
    i: int = 0
    while i < len(s):
        if not pertenece(vocales, s[i]):
            res += s[i]
        else:
            res += "_"
        i += 1
    return res

# 2.5.
def daVueltaStr(s: str) -> str:
    return "".join(invertir(list(s)))

# 3.1.
def construirListaEstudiantes() -> list[str]:
    res: list = []
    prompt: str = ""
    while prompt != "listo":
        prompt = input("Escribí el nombre del próximo estudiante, o \"listo\" para terminar\n")
        if prompt != "listo":
            res.append(prompt)
    return res

# 3.2.
# Observación: La especificación informal no explicita necesidad de trackear el saldo neto.
def operarCuenta() -> list[tuple]:
    res: list = []
    prompt: str = ""
    while prompt != "X":
        prompt = input("Escribí C para cargar créditos, D para retirarlos, o X para salir\n").upper()
        if prompt == "C" or prompt == "D":
            operacion: str = "cargar"*(prompt == "C") + "retirar"*(prompt == "D")
            cantidad: float = abs(float(input("Escribí el monto que querés " + operacion + "\n")))
            res.append((prompt, cantidad))
    return res

# 3.3.
def tirarCarta() -> int:
    carta: int = random.randint(1, 12)
    while pertenece([8, 9], carta):
        carta = random.randint(1, 12)
    return carta

def valorCarta(carta: int) -> float:
    res: float = carta
    if carta >= 10:
      res = 0.5
    return res

def sieteMedio() -> list[int]:
    carta: int = tirarCarta()
    res: list = [carta]
    suma: float = valorCarta(carta)
    prompt: str = ""
    while prompt != "X":
        prompt = input("Escribí C para sacar otra carta o X para plantarte\n").upper()
        if prompt == "C":
            carta = tirarCarta()
            suma += valorCarta(carta)
            res.append(carta)
    if suma >= 7.5:
        print("Perdiste, sumaste", suma)
    else:
        print("Sumaste", suma)
    return res

# 4.1.
def vaciarListaInPlace(s: list) -> list:
    n_elem = len(s)
    for _ in range(n_elem):
        s.pop(0)

def perteneceACadaUno(s: list[list[int]], e: int, res: list[bool]) -> None:
    vaciarListaInPlace(res) # Me es raro tener que hacer esto
    i: int = 0
    while i < len(s):
        res.append(pertenece(s[i], e))
        i += 1
    return res

# 4.2.
def esMatriz(s: list[list[int]]) -> bool:
    n_col = len(s[0])
    res: bool = len(s) > 0 and n_col > 0
    i: int = 0
    while i < len(s):
        res = res and len(s[i]) == n_col
        i += 1
    return res

# 4.3.
def filasOrdenadas(m: list[list[int]], res: list[bool]) -> None:
    vaciarListaInPlace(res) # Me es raro tener que hacer esto
    i: int = 0
    while i < len(s):
        res.append(ordenados(s[i]))
        i += 1
    return res

# 4.4.
# Observación: asumo p entero, error de la guía pedir float.
def matrixProd(m1: list[list[float]], m2: list[list[float]]) -> list[list[float]]:
    res: list[list[float]] = []
    for i in range(len(m1)):
        res.append([])
        for j in range(len(m1[0])):
            suma = 0
            for n in range(len(m1)):
                suma += m1[i][n]*m2[n][j]
            res[i].append(suma)
    return res

def randMatrixPowered(d: int, p: int) -> list[list[float]]:
    m: list[list[float]] = np.random.random((d, d))
    res: list[list[float]] = m
    for _ in range(p-1):
        res = matrixProd(res, m)
    return res


if __name__ == "__main__":
    print(pertenece([1,2,3], 2), pertenece([1,2,3], 4))
    print(pertenece2([1,2,3], 2), pertenece2([1,2,3], 4))
    print(pertenece3([1,2,3], 2), pertenece3([1,2,3], 4))
    print(ordenados([1,2,3]), ordenados([1,3,2]))
    print(esPalindroma("menem"))
    print(passwordSeguro("poggy9abaB"))
    print(saldoNeto([("I", 2000), ("R", 20),("R", 1000),("I", 300)]))
    print(tiene3vocalesDistintas("aeuD"), tiene3vocalesDistintas("aeDT"))
    print(reemplazaVocales("holaPoggy"))

    res = [False]
    perteneceACadaUno([[1,2,3],[1,2,3]], 2, res)
    print(res) # [True, True]

    print(randMatrixPowered(5, 4))
