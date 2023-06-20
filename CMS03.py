from typing import List, Dict, Any, Union
from queue import Queue, LifoQueue

# 1.
def calcular_expresion(expr: str) -> float:
    res: float = .0
    pila: LifoQueue[float] = LifoQueue()
    parsed_expr: List[str] = expr.split(" ")
    operadores: Dict[str, function] = {
        "+": lambda x, y: x + y,
        "-": lambda x, y: x - y,
        "*": lambda x, y: x * y,
        "/": lambda x, y: x / y, }
    while parsed_expr:
        char: str = parsed_expr.pop(0)
        if char in operadores.keys():
            operando2: float = float(pila.get())
            operando1: float = float(pila.get())
            pila.put(operadores[char](operando1, operando2))
        else:
            pila.put(char)
    if not pila.empty():
        res = pila.get()
    return res

# 2.
def unir_diccionarios(a_unir: List[Dict[str, str]]) -> Dict[str, List[str]]:
    res: Dict[str, List[str]] = {}
    for diccionario in a_unir:
        for key in diccionario.keys():
            if key in res.keys():
                res[key].append(diccionario[key])
            else:
                res[key] = [diccionario[key]]
    return res

# 3.
def procesamiento_pedidos(pedidos: Queue[Dict[str, Union[int, str, Dict[str, int]]]],
                          stock_productos: Dict[str, int],
                          precios_productos: Dict[str, float]) -> List[Dict[str, Union[int, str, float, Dict[str, int]]]]:
    res: List[Dict[str, Union[int, str, float, Dict[str, int]]]] = []
    while not pedidos.empty():
        pedido: Dict[str, Union[int, str, Dict[str, int]]] = pedidos.get()
        pedido_procesado: Dict[str, Union[int, str, float, Dict[str, int]]] = procesar_pedido(pedido, stock_productos, precios_productos)
        res.append(pedido_procesado)
    return res

def procesar_pedido(pedido: Dict[str, Union[int, str, Dict[str, int]]],
                    stock_productos: Dict[str, int],
                    precios_productos: Dict[str, float]) -> Dict[str, Union[int, str, float, Dict[str, int]]]:
    id_: int = pedido["id"]
    cliente: str = pedido["cliente"]
    productos: Dict[str, int] = pedido["productos"]
    comprados: Dict[str, int] = {}
    estado: str = "completo"
    precio_total: float = 0
    cantidad: int = 0

    for producto in productos.keys():
        if productos[producto] > stock_productos[producto]:
            estado = "incompleto"
        cantidad = min(productos[producto], stock_productos[producto])
        stock_productos[producto] -= cantidad
        precio_total += cantidad * precios_productos[producto]
        comprados[producto] = cantidad

    return {"id": id_,
            "cliente": cliente,
            "productos": comprados,
            "precio_total": precio_total,
            "estado": estado}

# 4.
def avanzarFila(fila: Queue[int], min: int):
    current_min: int = 0
    espera_llegada: int = 0
    espera_caja1: int = 1
    espera_caja2: int = 3
    espera_caja3: int = 2
    periodo_llegada: int = 4
    periodo_caja1: int = 10
    periodo_caja2: int = 4
    periodo_caja3: int = 4
    duracion_caminata: int = 3
    caminando_a_cola: List[int] = []
    proximo: int = cantidadElementos(fila) + 1  # fila.qsize() + 1
    while current_min <= min:

        if not espera_llegada:
            fila.put(proximo)
            proximo += 1
        if caminando_a_cola and not caminando_a_cola[0][1]:
            fila.put(caminando_a_cola[0][0])
            caminando_a_cola.pop(0)

        if not fila.empty() and not espera_caja1:
            fila.get()
        if not fila.empty() and not espera_caja2:
            fila.get()
        if not fila.empty() and not espera_caja3:
            caminando_a_cola.append((fila.get(), duracion_caminata))

        espera_llegada -= 1
        espera_caja1 -= 1
        espera_caja2 -= 1
        espera_caja3 -= 1
        espera_llegada %= periodo_llegada
        espera_caja1 %= periodo_caja1
        espera_caja2 %= periodo_caja2
        espera_caja3 %= periodo_caja3
        for i in range(len(caminando_a_cola)):
            caminando_a_cola[i] = (
                caminando_a_cola[i][0], caminando_a_cola[i][1]-1)

        current_min += 1
    return fila

def cantidadElementos(c: Queue[Any]) -> int:
    n: int = 0
    temp: List[Any] = []
    while not c.empty():
        temp.append(c.get())
        n += 1
    for value in temp:
        c.put(value)
    return n
