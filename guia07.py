from math import sqrt, ceil

# 1.1.
def raizDe2() -> float:
    return round(sqrt(2), 4)

# 1.2.
def imprimir_hola() -> None:
    print("hola")

# 1.3.
def imprimir_un_verso() -> None:
    print("Nothing he's got he really needs\nTwentyfirst century schizoid man")

# 1.4-7.
def factorial(n: int) -> int:
    if n: return n*factorial(n-1)
    return 1

# 2.1.
def imprimir_saludo(nombre: str) -> None:
    print("Hola " + nombre)

# 2.2.
def raiz_cuadrada_de(n: float) -> float:
    return sqrt(n)

# 2.3.
def imprimir_dos_veces(estribillo: str) -> None:
    print((estribillo*2)[:-1])

# 2.4.
def es_multiplo_de(n: int, m: int) -> bool:
    return n%m == 0

# 2.5.
def es_par(n: int) -> bool:
    return es_multiplo_de(n, 2)

# 2.6.
def cantidad_de_pizzas(comensales: int, min_cant_de_porciones: int) -> int:
    return ceil(min_cant_de_porciones*comensales/8)

# 3.1.
def alguno_es_0(n1: int, n2: int) -> bool:
    return n1==0 or n2==0

# 3.2.
def ambos_son_0(n1: int, n2: int) -> bool:
    return n1==0 and n2==0

# 3.3.
def es_nombre_largo(nombre: str) -> bool:
    return len(nombre)>=3 and  len(nombre)<=8

# 3.4.
def es_bisiesto(año: int) -> bool:
    return es_multiplo_de(año, 400) or (es_multiplo_de(año, 4) and not es_multiplo_de(año, 100))

# 4.1.
def peso_pino(altura_cm: float) -> float:
    peso_kg = 3*min(altura_cm, 300) + 2*max(altura_cm - 300, 0)
    return peso_kg

# 4.2.
def es_peso_util(peso_kg: float) -> bool:
    return peso_kg>=400 and  peso_kg<=1000

# 4.3-4.
def sirve_pino(altura_cm: float) -> bool:
    return es_peso_util(peso_pino(altura_cm))

# 5.1.
# problema duplicar_si_par(in n: Z): Z {
#   requiere: {True}
#   asegura: {(es_par(n) -> res = n*2) ^ (¬es_par(n) -> res = n)}
# }

# predicado es_par(n: Z) {n%2 == 0}
def duplicar_si_par(n: int) -> int:
    return n*(1 + 1*es_par(n))

# 5.2.
# problema siguiente_si_impar(in n:Z): Z {
#   requiere: {True}
#   asegura: {(es_par(n) -> res = n) ^ (¬es_par(n) -> res = n+1)}
# }
def siguiente_si_impar(n: int) -> int:
    return n + 1*(not es_par(n))

# 5.3.
# problema duplica_si_mult3_triplica_si_mult9(in n:Z): Z {
#   requiere: {True}
#   asegura: {es_multiplo_de(n, 9) -> res = 3*n}
#   asegura: {(¬es_multiplo_de(n, 9) ^ es_multiplo_de(n, 3)) -> res = 2*n}
#   asegura: {(¬es_multiplo_de(n, 9) ^ ¬es_multiplo_de(n, 3)) -> res = n}
# }

# predicado es_multiplo_de(n: Z, m: Z) {n%m == 0}
def duplica_si_mult3_triplica_si_mult9(n: int):
    return n*(1 + 2*es_multiplo_de(n, 9) + 1*(es_multiplo_de(n, 3) and not es_multiplo_de(n, 9)))

# 5.4.
# problema alerta_largo(in nombre: [char]): null {
#   requiere: {True}
#   asegura: {|nombre| >= 5 -> imprime "Tu nombre tiene muchas letras!"}
#   asegura: {|nombre| < 5 -> imprime "Tu nombre tiene menos de 5 caracteres"}
# }
def alerta_largo(nombre: str) -> None:
    mensaje = (len(nombre)>=5)*"Tu nombre tiene muchas letras!"
    mensaje += (len(nombre)<5)*"Tu nombre tiene menos de 5 caracteres"
    print(mensaje)

# 5.5.
# problema alerta_status_laboral(in sexo: char, in edad: Z): null {
#   requiere: {sexo = 'M' v sexo = 'F'}
#   asegura: {trabaja(sexo, edad) -> imprime "Te toca trabajar"}
#   asegura: {¬trabaja(sexo, edad) -> imprime "Andá de vacaciones"}
# }

# predicado trabaja(sexo: char, edad: Z) {
#   edad >= 18 ^ ((sexo = 'M' ^ edad < 65) v (sexo = 'F' ^ edad < 60))
# }
def alerta_status_laboral(sexo: str, edad: int) -> None:
    trabaja = edad >= 18 and ((sexo == "M" and edad < 65) or (sexo == "F" and edad < 60))
    mensaje = trabaja*"Te toca trabajar"
    mensaje += trabaja*"Andá de vacaciones"
    print(mensaje)

# 6-7.1.
def uno_a_diez_while() -> None:
    i = 1
    while i <= 10:
        print(i)
        i += 1

def uno_a_diez_for() -> None:
    for i in range(1, 11, 1):
        print(i)

# 6-7.2.
def diez_a_cuarenta_pares_while() -> None:
    i = 10
    while i <= 40:
        print(i)
        i += 2

def diez_a_cuarenta_pares_for() -> None:
    for i in range(10, 41, 2):
        print(i)

# 6-7.3.
def eco10_while() -> None:
    i = 1
    while i <= 10:
        print("eco")
        i += 1

def eco10_for() -> None:
    for i in range(1, 11, 1):
        print("eco")

# 6-7.4.
def despegue_while(n: int) -> None:
    while n > 0:
        print(n)
        n -= 1
    print("Despegue")

def despegue_for(n: int) -> None:
    for i in range(n, 0, -1):
        print(i)
    print("Despegue")

# 6-7.5.
def monitoreo_viaje_while(partida: int, llegada: int) -> None:
    partida -= 1     
    while partida >= llegada:
        print(f"Viajo un ano al pasado, estamos en el ano: {partida}")
        partida -= 1    

def monitoreo_viaje_for(partida: int, llegada: int) -> None:
    for i in range(partida-1, llegada-1, -1):
        print(f"Viajo un ano al pasado, estamos en el ano: {i}")

# 6-7.6.
def monitoreo_viaje_aristoteles_while(partida: int, llegada: int = -384) -> None:
    partida -= 20     
    while partida >= llegada:
        print(f"Viajo 20 años al pasado, estamos en el año: {partida}")
        partida -= 20    

def monitoreo_viaje_aristoteles_for(partida: int, llegada: int= -384) -> None:
    for i in range(partida-1, llegada-1, -20):
        print(f"Viajo 20 años al pasado, estamos en el año: {i}")

# 8.1.
# Ejecución simbólica de x=5 ; y=7

x = 5
# Estado A
# Vale x == 5
y = 7
# Estado B
# Vale x == x@A ^ y == 7

# 8.2.
# Ejecución simbólica de x=5 ; y=7 ; z=x+y

x = 5
# Estado A
# Vale x == 5
y = 7
# Estado B
# Vale x == x@A ^ y == 7
z = x + y
# Estado C
# Vale x == x@B ^ y == y@B ^ z == x@B + y@B

# 8.3.
# Ejecución simbólica de x=5 ; x="hora"

x = 5
# Estado A
# Vale x == 5
x = "hora"
# Estado B
# Vale x == "hora"

# 8.4.
# Ejecución simbólica de x=True ; y=False ; res=x and y

x = True
# Estado A
# Vale x == True
y = False
# Estado B
# Vale x == x@A ^ y == False
res = x and y
# Estado C
# Vale x == x@B ^ y == y@B ^ res == x@B ^ y@B

# 8.5.
# Ejecución simbólica de x=False ; res=not(x)

x = False
# Estado A
# Vale x == False
res = not x
# Estado B
# Vale res == ¬x@A

# 9.3.
def rt(x: int, g: int) -> int:
    # Estado A
    g = g + 1
    # Estado B
    # Vale g == g@A + 1 
    return x + g

g: int = 0
# Estado A
# Vale g == 0
def ro(x: int) -> int:
    # Estado B 
    # Vale g == g@A
    global g
    g = g + 1
    # Estado C
    # Vale g == g@B + 1 
    return x + g

# 9.1.
# 2, 3, 4

# 9.2.
# 2, 2, 2

# 9.4.
# problema sumar_e_incrementar(in x: Z, in g: Z): Z {
#   requiere: {True}
#   asegura: {res = x + g + 1}
# }

# No tengo forma de hacer especificación formal para ro con lo que sé.
# En lenguaje natural puedo decir que devuelve la suma x + g + 1,
# donde g es una variable global que debe haber sido inicializada 
# previamente al llamado de la función en un scope de mayor alcance.
# La función modifica el valor de g incrementandoló en 1 en cada llamado.

if __name__ == "__main__":
    print(raizDe2())
    imprimir_hola()
    imprimir_un_verso()
    print(factorial(5))
    imprimir_saludo("Tomo")
    print(raiz_cuadrada_de(4.2))
    imprimir_dos_veces("Nothing he's got he really needs\nTwentyfirst century schizoid man\n")
    print(es_multiplo_de(10, 5), es_multiplo_de(10, 6))
    print(cantidad_de_pizzas(4,5))
    print(duplicar_si_par(2), duplicar_si_par(3))
    print(duplica_si_mult3_triplica_si_mult9(5), duplica_si_mult3_triplica_si_mult9(24), duplica_si_mult3_triplica_si_mult9(27))
    despegue_for(5)
    monitoreo_viaje_while(20, 17)
    monitoreo_viaje_aristoteles_while(2023)
    print(ro(1), ro(1), ro(1))
    print(rt(1,0), rt(1,0), rt(1,0))
