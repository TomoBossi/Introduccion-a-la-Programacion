import Solucion
import Test.HUnit

main = runTestTT testSuites

testSuites =
  test
    [ testSuiteNombresDeUsuarios,
      testSuiteAmigosDe,
      testSuiteCantidadDeAmigos,
      testSuiteUsuarioConMasAmigos,
      testSuiteEstaRobertoCarlos,
      testSuitePublicacionesDe,
      testSuitePublicacionesQueLeGustanA,
      testSuiteLesGustanLasMismasPublicaciones,
      testSuiteTieneUnSeguidorFiel,
      testSuiteExisteSecuenciaDeAmigos
    ]

expectAny actual expected = elem actual expected ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)

expectSet actual expected = mismosElementos actual expected ~? ("expected the set: " ++ show expected ++ "\n but got: " ++ show actual)

-- Usuarios
usuario1 = (42, "Pedro")
usuario2 = (27, "Robert")
usuario3 = (68, "xXx_Yung_Baby_xXx")
usuario4 = (38, "Squeener")
usuario5 = (99, "Eve")
usuario6 = (101, "Alice")
usuarios1 = [usuario1, usuario2, usuario3, usuario4, usuario5, usuario6]

-- Relaciones
relacion1 = (usuario1, usuario2)
relacion2 = (usuario2, usuario3)
relacion3 = (usuario1, usuario3)
relacion4 = (usuario3, usuario4)
relaciones1 = [relacion1, relacion2, relacion3]
relaciones2 = [relacion1, relacion2]
relaciones3 = [relacion1, relacion2, relacion4]

-- Publicaciones
publicacion1 = (usuario1, "Who up rn", [usuario2, usuario3, usuario4])
publicacion2 = (usuario1, "I need this fr fr on god on god", [usuario4])
publicacion3 = (usuario4, "Omg me", [usuario4])
publicacion4 = (usuario2, "me: also me:", [usuario1, usuario2, usuario3, usuario4])
publicacion5 = (usuario4, "Omg me (I'm back from my hiatus)", [])
publicacion6 = (usuario6, "yvgrenyyl zr", [])
publicaciones1 = [publicacion1, publicacion2, publicacion3, publicacion4, publicacion5]

-- Redes
red1 = (usuarios1, relaciones1, publicaciones1)
red2 = (usuarios1, relaciones2, publicaciones1)
red3 = (usuarios1, relaciones3, publicaciones1)
redVacia = ([], [], [])
redConUnUsuario = ([usuario1], [], [])
redSinAmistadesYPublicaciones = (usuarios1, [], [])

-- Roberto Carlos
usuarioRC = (1, "Roberto Carlos")

-- Cantidad de amigos para ser Roberto Carlos
nAmigosMinimo = 100

-- Auxiliar para testear estaRobertoCarlos
-- Toma una red vacía y un natural n y genera una red con n usuarios,
-- 0 publicaciones, y n-1 relaciones en las cuales está
-- sin falta implicado el usuario (1, "Roberto Carlos").
redParasocial :: RedSocial -> Integer -> RedSocial
redParasocial (us, rs, ps) 1 = (usuarioRC : us, rs, ps)
redParasocial (us, rs, ps) n = redParasocial (fanRC : us, relacionRC : rs, ps) (n - 1)
  where
    fanRC = (n, "Fan n°1 de R.C.")
    relacionRC = (fanRC, usuarioRC)

redRC1 = redParasocial ([], [], []) (nAmigosMinimo + 1) -- nAmigosMinimo amigos
redRC2 = redParasocial ([], [], []) (nAmigosMinimo) -- nAmigosMinimo - 1 amigos

-- Auxiliar para testear estaRobertoCarlos
-- Identica a estaRobertoCarlos, pero para una cantidad de amigos mínima
-- arbitrariamente menor de manera de poder ser testeada.
estaRobertoCarlosTest :: RedSocial -> Bool
estaRobertoCarlosTest red = cantidadDeAmigos red (usuarioConMasAmigos red) > (fromIntegral (nAmigosMinimo - 1))

-- Conjuntos de casos de prueba
testSuiteNombresDeUsuarios =
  test
    [ "Caso 1: Red sin usuarios" ~: nombresDeUsuarios redVacia ~?= [],
      "Caso 2: Red con usuarios" ~: expectSet (nombresDeUsuarios red1) [snd usuario1, snd usuario2, snd usuario3, snd usuario4, snd usuario5, snd usuario6]
    ]

testSuiteAmigosDe =
  test
    [ "Caso 1: Sin amigos" ~: (amigosDe red1 usuario4) ~?= [],
      "Caso 2: Tiene amigos" ~: expectSet (amigosDe red1 usuario1) [usuario2, usuario3]
    ]

testSuiteCantidadDeAmigos =
  test
    [ "Caso 1: Sin amigos" ~: (cantidadDeAmigos red1 usuario4) ~?= 0,
      "Caso 2: Único usuario en la red" ~: (cantidadDeAmigos redConUnUsuario usuario1) ~?= 0,
      "Caso 3: Con amigos" ~: (cantidadDeAmigos red1 usuario1) ~?= 2
    ]

testSuiteUsuarioConMasAmigos =
  test
    [ "Caso 1: Red sin amistades y publicaciones" ~: expectAny (usuarioConMasAmigos redSinAmistadesYPublicaciones) usuarios1,
      "Caso 2: Máximo" ~: expectAny (usuarioConMasAmigos red2) [usuario1, usuario2, usuario3],
      "Caso 3: Máximo absoluto" ~: (usuarioConMasAmigos red1) ~?= usuario1
    ]

testSuiteEstaRobertoCarlos =
  test
    [ "Caso 1: Red vacía" ~: (estaRobertoCarlosTest redVacia) ~?= False,
      "Caso 2: No hay más de un millón" ~: (estaRobertoCarlos red1) ~?= False,
      "Caso 3: No hay más de un millón (mock)" ~: (estaRobertoCarlosTest redRC2) ~?= False,
      "Caso 4: Hay más de un millón (mock)" ~: (estaRobertoCarlosTest redRC1) ~?= True
    ]

testSuitePublicacionesDe =
  test
    [ "Caso 1: Usuario no publicó" ~: (publicacionesDe redSinAmistadesYPublicaciones usuario1) ~?= [],
      "Caso 2: Usuario publicó" ~: expectSet (publicacionesDe red1 usuario4) [publicacion3, publicacion5]
    ]

testSuitePublicacionesQueLeGustanA =
  test
    [ "Caso 1: Usuario no dio likes" ~: (publicacionesQueLeGustanA red1 usuario5) ~?= [],
      "Caso 2: Usuario dio un único like" ~: expectSet (publicacionesQueLeGustanA red1 usuario1) [publicacion4],
      "Caso 3: Usuario dio múltiples likes" ~: expectSet (publicacionesQueLeGustanA red1 usuario4) [publicacion1, publicacion2, publicacion3, publicacion4]
    ]

testSuiteLesGustanLasMismasPublicaciones =
  test
    [ "Caso 1: Ambos usuarios no dieron likes" ~: (lesGustanLasMismasPublicaciones red1 usuario5 usuario6) ~?= True,
      "Caso 2: 1er usuario con likes, 2do usuario sin likes" ~: (lesGustanLasMismasPublicaciones red1 usuario1 usuario5) ~?= False,
      "Caso 3: 1er usuario sin likes, 2do usuario con likes" ~: (lesGustanLasMismasPublicaciones red1 usuario5 usuario1) ~?= False,
      "Caso 4: No comparten los mismos likes" ~: (lesGustanLasMismasPublicaciones red1 usuario1 usuario3) ~?= False,
      "Caso 5: Comparten exactamente los mismos likes" ~: (lesGustanLasMismasPublicaciones red1 usuario2 usuario3) ~?= True
    ]

testSuiteTieneUnSeguidorFiel =
  test
    [ "Caso 1: Usuario sin publicaciones" ~: (tieneUnSeguidorFiel red1 usuario5) ~?= False,
      "Caso 2: Único usuario en red" ~: (tieneUnSeguidorFiel redConUnUsuario usuario1) ~?= False,
      "Caso 3: Usuario no tiene likes en sus publicaciones" ~: (tieneUnSeguidorFiel red1 usuario6) ~?= False,
      "Caso 4: No existe seguidor fiel" ~: (tieneUnSeguidorFiel red1 usuario4) ~?= False,
      "Caso 5: Existe seguidor fiel" ~: (tieneUnSeguidorFiel red1 usuario1) ~?= True
    ]

testSuiteExisteSecuenciaDeAmigos =
  test
    [ "Caso 1: Ambos usuarios sin amigos" ~: (existeSecuenciaDeAmigos red1 usuario5 usuario6) ~?= False,
      "Caso 2: 1er usuario con amigos, 2do usuario sin amigos" ~: (existeSecuenciaDeAmigos red1 usuario1 usuario5) ~?= False,
      "Caso 3: 1er usuario sin amigos, 2do usuario con amigos" ~: (existeSecuenciaDeAmigos red1 usuario5 usuario1) ~?= False,
      "Caso 4: No existe secuencia" ~: (existeSecuenciaDeAmigos red2 usuario1 usuario4) ~?= False,
      "Caso 5: Existe secuencia" ~: (existeSecuenciaDeAmigos red3 usuario1 usuario4) ~?= True
    ]

