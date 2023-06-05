import csv
import random
from queue import LifoQueue as Pila, Queue as Cola

# 1.1.
def contarLineas(nombre_archivo: str) -> int:
    with open(nombre_archivo, "r") as f:
        res: list[str] = f.readlines()
    return len(res)

# 1.2.
def existePalabra(palabra: str, nombre_archivo: str) -> bool:
    res: bool = False
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    for linea in lineas:
        palabras: list[str] = "".join(x for x in linea if x.isalpha() or x == " ").split(" ")
        for palabraEnTexto in palabras:
            res = res or palabra.lower() == palabraEnTexto.lower()
    return res

# 1.3.
def cantidadApariciones(nombre_archivo: str, palabra: str) -> int: 
    res: int = 0
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    for linea in lineas:
        palabras: list[str] = "".join(x for x in linea if x.isalpha() or x == " ").split(" ")
        for palabraEnTexto in palabras:
            if palabra.lower() == palabraEnTexto.lower():
                res += 1
    return res

# 2.
def clonarSinComentarios(nombre_archivo: str) -> None:
    sinComentarios: list[str] = []
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    for linea in lineas:
        esComentario: bool = False
        primerCaracter: bool = False
        i: int = 0
        while i < len(linea) and not esComentario and not primerCaracter:
            if linea[i] == "#":
                esComentario = True
                primerCaracter = True
            elif linea[i] != " ":
                primerCaracter = True
            i += 1
        if not esComentario:
            sinComentarios.append(linea)
    with open("guia10_salida2.txt", "w") as f:
        f.writelines(sinComentarios)

# 3.
def invertirOrdenLineas(nombre_archivo: str) -> None:
    invertidas: list[str] = []
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()

    if len(lineas) > 1:
        lineas[0] = lineas[0][:-1]
    if lineas[-1][-2:] != "\n":
        lineas[-1] = lineas[-1] + "\n"

    for linea in lineas:
        invertidas.insert(0, linea)
    with open("reverso.txt", "w") as f:
        f.writelines(invertidas)

# 4.
def agregarFraseFinal(nombre_archivo: str, frase: str) -> None:
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    if lineas[-1][-2:] != "\n":
        lineas[-1] = lineas[-1] + "\n"
    lineas[-1] = lineas[-1] + frase
    with open(nombre_archivo, "w") as f:
        f.writelines(lineas)

# 5.
def agregarFraseInicio(nombre_archivo: str, frase: str) -> None:
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    if frase[-2:] != "\n":
        frase += "\n"
    lineas = [frase] + lineas
    with open(nombre_archivo, "w") as f:
        f.writelines(lineas)

# 6.
def parsearPalabrasLegibles(nombre_archivo: str) -> list[str]:
    legibles: list[str] = []
    with open(nombre_archivo, "rb") as f:
        texto: str = f.read()
    texto = texto.decode('ascii')
    i: int = 0
    while i < len(texto):
        j: int = 0
        palabra: str = ""
        caracterInvalido: bool = False
        while j < len(texto) - i and not caracterInvalido:
            if texto[i+j].isalpha() or texto[i+j] in [0,1,2,3,4,5,6,7,8,9," ","_"]:
                palabra = palabra + texto[i+j]
            else:
                caracterInvalido = True
                if len(palabra) >= 5:
                    legibles.append(palabra)
            j += 1
        i += j
    return legibles

# 7.
def promedioEstudiante(lu : str) -> float:
    n: int = 0
    suma: int = 0
    with open("notas.csv", "r") as f:
        datos = csv.reader(f)
        for dato in datos:
            if dato[0] == lu:
                n += 1
                suma += float(dato[-1])
    return suma/n

# 8.
def generarNrosAlAzar(n: int, desde: int, hasta: int) -> list[int]:
    return random.sample(list(range(desde, hasta+1)), n)

# 9.
def generarPilaAlAzar(n: int, desde: int, hasta: int) -> Pila:
    p: Pila = Pila()
    numeros: list[int] = generarNrosAlAzar(n, desde, hasta)
    for num in numeros:
        p.put(num)
    return p

# 10.
def cantidadElementos(p: Pila) -> int:
    n: int = 0
    while not p.empty():
        p.get()
        n += 1
    return n

# 11.
def buscarElMaximo(p: Pila[int]) -> int:
    maximo: int = p.get()
    while not p.empty():
        valor = p.get()
        if valor > maximo:
            maximo = valor
    return maximo

# 12.
def estaBienBalanceada(s: str) -> bool:
    balance: int = 0
    i: int = 0
    while i < len(s) and balance >= 0:
        char = s[i]
        if char == "(":
            balance += 1
        elif char == ")":
            balance -= 1
        i += 1
    return balance == 0

# 13.
def generarColaAlAzar(n: int, desde: int, hasta: int) -> Cola:
    c: Cola = Cola()
    numeros: list[int] = generarNrosAlAzar(n, desde, hasta)
    for num in numeros:
        c.put(num)
    return c

# 14. Idéntica a la función para pilas, 10.
def cantidadElementos(c: Cola) -> int: # 
    n: int = 0
    while not c.empty():
        c.get()
        n += 1
    return n

# 15. Idéntica a la función para pilas, 11.
def buscarElMaximo(c: Cola[int]) -> int:
    maximo: int = c.get()
    while not c.empty():
        valor = c.get()
        if valor > maximo:
            maximo = valor
    return maximo

# 16.
def armarSecuenciaDeBingo() -> Cola[int]:
    return generarColaAlAzar(100, 0, 99)

def incluida(l1: list, l2: list) -> bool:
    return all([x in l2 for x in l1])

def jugarCartonDeBingo(carton: list[int], bolillero: Cola[int]) -> int:
    extraidas: list[int] = []
    n = 0
    while not incluida(carton, extraidas):
        extraidas.append(bolillero.get())
        n += 1
    return n

# 17.
def listToQueue(l: list) -> Cola:
    c: Cola = Cola()
    for elem in l:
        c.put(elem)
    return c

def nPacientesUrgentes(c: Cola[(int, str, str)]) -> int:
    n: int = 0
    while not c.empty():
        if c.get()[0] <= 3:
            n += 1
    return n

# 18.
def agruparPorLongitud(nombre_archivo: str) -> dict:
    res: dict = {}
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    for i, linea in enumerate(lineas):
        if lineas[i][:-1] == "\n":
            lineas[i] = lineas[i][:-1]
        palabras: list[str] = filter(lambda p: p != "", "".join(x for x in linea if x.isalpha() or x == " ").split(" "))
        for palabra in palabras:
            if len(palabra) in res.keys():
                res[len(palabra)] += 1
            else:
                res[len(palabra)] = 1
    return res

# 19.
def promediosEstudiantes(nombre_archivo: str) -> dict:
    res: dict = {}
    contador: dict = {}
    with open(nombre_archivo, "r") as f:
        datos = csv.reader(f)
        next(datos)
        for dato in datos:
            if dato[0] in res.keys():
                res[dato[0]] += float(dato[-1])
                contador[dato[0]] += 1
            else:
                res[dato[0]] = float(dato[-1])
                contador[dato[0]] = 1
    for lu in res.keys():
        res[lu] /= contador[lu]
    return res

# 20.
def contarRepeticiones(nombre_archivo: str) -> dict:
    res: dict = {}
    with open(nombre_archivo, "r") as f:
        lineas: list[str] = f.readlines()
    for i, linea in enumerate(lineas):
        if lineas[i][:-1] == "\n":
            lineas[i] = lineas[i][:-1]
        palabras: list[str] = filter(lambda p: p != "", "".join(x for x in linea if x.isalpha() or x == " ").split(" "))
        for palabra in palabras:
            if palabra in res.keys():
                res[palabra] += 1
            else:
                res[palabra] = 1
    return res

def laPalabraMasFrecuente(nombre_archivo: str) -> str:
    repeticiones: dict = contarRepeticiones(nombre_archivo)
    maximo: int = 0
    maximo_palabra: str = ""
    for palabra in repeticiones.keys():
        if repeticiones[palabra] > maximo:
            maximo = repeticiones[palabra]
            maximo_palabra = palabra
    return maximo_palabra

if __name__ == "__main__":
    import os
    os.chdir(os.path.dirname(__file__))

    print(contarLineas("guia10.txt"))
    print(existePalabra("linea", "guia10.txt"))
    print(cantidadApariciones("guia10.txt", "comentario"))
    clonarSinComentarios("guia10.txt")
    invertirOrdenLineas("guia10.txt")
    # agregarFraseFinal("guia10.txt", "Testing \nnextlining...")
    # agregarFraseInicio("guia10.txt", "Testing \nnextlining...")
    print(parsearPalabrasLegibles("guia10.txt"))
    csv_string = "LU, materia, fecha, nota\n50/17, biologia, 01102021, 5\n50/17, fisica, 49575234, 8.6\n20/18, subnautica, 3495, 1\n56/25, terraria, 345875, 3\n50/17, CS50, 84757, 10\n56/25, Keke, 345875, 5.5"
    with open("notas.csv", "w") as f:
        f.write(csv_string)
    print(promedioEstudiante("50/17"))
    print(generarNrosAlAzar(10, 5, 35))
    print(cantidadElementos(generarPilaAlAzar(10, 5, 35)))
    print(cantidadElementos(generarPilaAlAzar(10, 5, 35)))
    print(buscarElMaximo(generarPilaAlAzar(10, 5, 35)))
    print(estaBienBalanceada("1 + ( 2 x 3 - ( 20 / 5 ) )"),
          estaBienBalanceada("1 + ) 2 x 3 ( ( )"))
    print(jugarCartonDeBingo([20,54,56,32,4,5,8,12,25,34,67,72], armarSecuenciaDeBingo()))
    print(nPacientesUrgentes(listToQueue([(1,"a","b"), (4,"c","d"), (3, "e", "f")])))
    print(agruparPorLongitud("guia10.txt"))
    print(promediosEstudiantes("notas.csv"))
    print(laPalabraMasFrecuente("guia10.txt"))