from typing import List, Tuple, Any

# 1.
def quienGana(j1: str, j2: str) -> str:
  res: str
  combGanadora: List[Tuple[str, str]] = [
    ("Piedra", "Tijera"), 
    ("Tijera", "Papel"), 
    ("Papel", "Piedra"),
  ]
  if pertenece(combGanadora, (j1, j2)):
    res = "Jugador1"
  elif pertenece(combGanadora, (j2, j1)):
    res = "Jugador2"
  else:
    res = "Empate"
  return res

def quienGanaAnillo(j1: str, j2: str) -> str:
  res: str = "Empate"
  orden = ["Piedra", "Tijera", "Papel"]
  ######### Piedra -> Tijera -> Papel -> Piedra -> ... donde ->: "mata"
  id_j1, id_j2 = indiceDe(j1, orden), indiceDe(j2, orden)
  if id_j1 == (id_j2 - 1)%len(orden):
    res = "Jugador1"
  elif id_j2 == (id_j1 - 1)%len(orden):
    res = "Jugador2"
  return res

def indiceDe(e: Any, l: List[Any]):
  i: int = 0
  while l[i] != e and i <= len(l):
    i += 1
  return i

def pertenece(s: List[Any], e: Any) -> bool:
  res: bool = False
  i: int = 0
  while i < len(s):
    if s[i] == e:
      res = True
    i += 1
  return res

# 2.
def fibonacciNoRecursivo(n: int) -> int:
  res: int
  f0: int = 0
  f1: int = 1
  if n == 0:
    res = f0
  elif n == 1:
    res = f1
  else:
    while n > 1:
      res = f0 + f1
      f0 = f1
      f1 = res
      n -= 1
  return res

# 3.
# Observación: Creo que la especificación actual está mal. Asumo que devuelve largo de meseta máximo absoluto.
# problema mesetaMasLarga (in l: seq⟨Z⟩) : Z {
#   requiere: {True}
#   asegura: {hayMesetaDeLong(l, result) ∧ ¬hayMesetaDeLong(l, result + 1)}
# }
def mesetaMasLarga(l: List[int]) -> int:
  maxAbs: int = 1
  if l == []:
    maxAbs = 0
  maxLocal: int = 1
  i: int = 1
  while i < len(l):
    if l[i] == l[i-1]:
      maxLocal += 1
      if maxLocal > maxAbs:
        maxAbs = maxLocal
    else:
      maxLocal = 1
    i += 1
  return maxAbs

# 4.
# Observación: Error en la especificación, se especifica tipo de salida Z cuando claramente es Bool.
def filasParecidas(matriz: List[List[int]]) -> bool:
  res: bool = True
  if not (matriz == [] or len(matriz) == 1 or matriz[0] == []):
    n: int = matriz[1][0] - matriz[0][0]
    for c in range(len(matriz[0])):
      resColumna: bool = True
      for f in range(1, len(matriz)):
        resColumna = resColumna and matriz[f][c] == matriz[f-1][c] + n
      res = res and resColumna
  return res

# 5.
def sePuedeLlegar(origen: str, destino: str, vuelos: List[Tuple[str, str]]) -> int:
  res: int = 0
  while origen != destino and res <= len(vuelos) + 1:
    origen = destinoDeOrigen(origen, vuelos)
    res += 1
  if not res or res > len(vuelos):
    res = -1
  return res

def destinoDeOrigen(origen: str, vuelos: List[Tuple[str, str]]) -> str:
  res: str = ""
  for vuelo in vuelos:
    if vuelo[0] == origen:
      res = vuelo[1]
  return res
