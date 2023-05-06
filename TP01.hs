-- Nombre de Grupo: GrupoTN1
-- Integrante 1: Nombre Apellido, email, LU
-- Integrante 2: Nombre Apellido, email, LU
-- Integrante 3: Nombre Apellido, email, LU
-- Integrante 4: Nombre Apellido, email, LU

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas

usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id 

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us

-- Ejercicios

-- 1.
-- Toma una red social y devuelve una lista con los nombres de todos los usuarios.
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios red = listaNombres (usuarios red)
  where
    listaNombres :: [Usuario] -> [String]
    listaNombres [] = []
    listaNombres (u:us) = nombre:(listaNombres us)
      where nombre = nombreDeUsuario u

-- 2.
-- Toma una red social y un usuario y devuelve una lista con los usuarios (id, nombre) de todos sus amigos, sin repetir.
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe red u = listaAmigos (relaciones red) u
  where
    listaAmigos :: [Relacion] -> Usuario -> [Usuario]
    listaAmigos [] _ = []
    listaAmigos (r:rs) u
      | fst r == u = (snd r):(listaAmigos rs u)
      | snd r == u = (fst r):(listaAmigos rs u)
      | otherwise = listaAmigos rs u

-- 3.
-- Toma una red social y un usuario y devuelve la cantidad de amigos que tiene, es decir, la longitud de su lista de amigos.
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red u = longitud (amigosDe red u)

-- Toma una lista y devuelve su cantidad de elementos
longitud :: [t] -> Int
longitud [] = 0
longitud (_:xt) = 1 + longitud xt

-- 4.
-- Toma una red social y devuelve al usuario (o a alguno de los usuarios) con la máxima cantidad de amigos.
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos red = usuarioEnMasRelaciones (usuarios red) (relaciones red)
  where
    usuarioEnMasRelaciones :: [Usuario] -> [Relacion] -> Usuario
    usuarioEnMasRelaciones (u:[]) _ = u
    usuarioEnMasRelaciones (u0:u1:us) rs
      | cantAmigos u0 >= cantAmigos u1 = usuarioEnMasRelaciones (u0:us) rs
      | otherwise = usuarioEnMasRelaciones (u1:us) rs
        where cantAmigos = cantidadDeAmigos ([], rs, [])

-- 5.
-- Toma una red social y devuelve True si existe algún usuario con más de 1000000 amigos o False en caso contrario.
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = cantidadDeAmigos red (usuarioConMasAmigos red) > 1000000

-- 6.
-- Toma una red social y un usuario y devuelve una lista con todas las publicaciones del usuario, sin repetir.
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe red u = listaPublicaciones (publicaciones red) u
  where
    listaPublicaciones :: [Publicacion] -> Usuario -> [Publicacion]
    listaPublicaciones [] _ = []
    listaPublicaciones (p:ps) u
      | usuarioDePublicacion p == u = p:(listaPublicaciones ps u)
      | otherwise = listaPublicaciones ps u

-- 7.
-- Toma una red social y un usuario y devuelve una lista con todas las publicaciones que le gustaron.
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red u = listaPublicacionesQueLeGustanA (publicaciones red) u
  where
    listaPublicacionesQueLeGustanA :: [Publicacion] -> Usuario -> [Publicacion]
    listaPublicacionesQueLeGustanA [] _ = []
    listaPublicacionesQueLeGustanA (p:ps) u
      | pertenece u (likesDePublicacion p) = p:(listaPublicacionesQueLeGustanA ps u)
      | otherwise = listaPublicacionesQueLeGustanA ps u

-- Toma una lista y un elemento, devuelve True si el elemento pertenece a la lista o False en caso contrario.
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece e (x:xs) = x == e || pertenece e xs

-- 8.
-- Toma una red social y dos usuarios, devuelve True si tienen el mismo set de publicaciones que les gustaron.
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red u1 u2 = iguales likesU1 likesU2
  where 
    likesU1 = publicacionesQueLeGustanA red u1
    likesU2 = publicacionesQueLeGustanA red u2

-- Toma dos listas y devuelve True si tienen el mismo set, False en caso contrario.
iguales :: (Eq t) => [t] -> [t] -> Bool
iguales x y = incluido x y && incluido y x

-- Toma dos listas y devuelve True si todos los elementos de la primera pertenecen al set de la segunda, False en caso contrario.
incluido :: (Eq t) => [t] -> [t] -> Bool
incluido [] _ = True
incluido (x:xs) y = pertenece x y && incluido xs y

-- 9.
-- Toma una red social y un usuario, devuelve True si el usuario tiene publicaciones y si existe algún otro usuario que le dio like a todas ellas, False en caso contrario.
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel red u
  | publicacionesDeUsuario == [] = False
  | otherwise = existeAlgunSeguidorFiel u (listaDeLikes publicacionesDeUsuario)
    where 
      publicacionesDeUsuario = publicacionesDe red u
      -- Toma un usuario autor de publicaciones (al menos una) y la lista de listas de usuarios que les dieron like a cada una de ellas, devuelve True si existe algún otro usuario (no el autor) que le dio like a todas ellas, False en caso contrario.
      existeAlgunSeguidorFiel :: Usuario -> [[Usuario]]  -> Bool
      existeAlgunSeguidorFiel u (l:[]) = l /= [] && l /= [u]
      existeAlgunSeguidorFiel u (l0:l1:ls) = existeAlgunSeguidorFiel u ((interseccion l0 l1):ls)

-- Toma una lista de publicaciones y devuelve la lista de listas de usuarios que les dieron like a cada una de ellas.
listaDeLikes :: [Publicacion] -> [[Usuario]]
listaDeLikes [] = []
listaDeLikes (p:ps) = (likesDePublicacion p):(listaDeLikes ps)

-- Toma dos listas y devuelve la intersección de sus sets.
interseccion :: (Eq t) => [t] -> [t] -> [t]
interseccion [] _ = []
interseccion (x:xs) y
  | pertenece x y = x:(interseccion xs y)
  | otherwise = interseccion xs y

-- 10.
-- Toma una red social y dos usuarios u1, u2 y devuelve True si los usuarios están relacionados directa o indirectamente.
-- Dos usuarios se relacionan directamente si participan de una relación de la red social ((u1, u2) o (u2, u1)), o indirectamente si existe alguna serie de relaciones que los vinculan.
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red u1 u2 = existeCadena red (amigosDe red u1) u2
  where
    existeCadena :: RedSocial -> [Usuario] -> Usuario -> Bool
    existeCadena _ [] _ = False
    existeCadena red (u0:us) u
      | pertenece u (u0:us) = True
      | otherwise = existeCadena (rmUsuario red u0) (amigosDe red u0) u || existeCadena red us u

-- Toma una red social y un usuario y remueve al usuario de la red.
-- Remover al usuario implica remover al usuario en sí mismo pero también a todas sus relaciones, publicaciones, y likes a publicaciones ajenas.
rmUsuario :: RedSocial -> Usuario -> RedSocial
rmUsuario (us, rs, ps) u = (rmUsuarioUs us u, rmUsuarioRs rs u, rmUsuarioPs ps u)
  where
    rmUsuarioUs :: [Usuario] -> Usuario -> [Usuario]
    rmUsuarioUs [] _ = []
    rmUsuarioUs (u0:us) u
      | u == u0 = us
      | otherwise = u0:(rmUsuarioUs us u)
    rmUsuarioRs :: [Relacion] -> Usuario -> [Relacion]
    rmUsuarioRs [] _ = []
    rmUsuarioRs (r:rs) u
      | fst r == u || snd r == u = rmUsuarioRs rs u
      | otherwise = r:(rmUsuarioRs rs u)
    rmUsuarioPs :: [Publicacion] -> Usuario -> [Publicacion]
    rmUsuarioPs [] _ = []
    rmUsuarioPs ((uAutor, pub, uLikes):ps) u
      | u == uAutor = rmUsuarioPs ps u
      | pertenece u uLikes = (uAutor, pub, rmUsuarioUs uLikes u):(rmUsuarioPs ps u)

-- Creación de redes sociales para testing
-- Usuarios
u1 :: Usuario
u1 = (42, "Pedro")
u2 :: Usuario
u2 = (27, "Robert")
u3 :: Usuario
u3 = (68, "xXx_Yung_Baby_xXx")
u4 :: Usuario
u4 = (38, "Squeener")
us1 :: [Usuario]
us1 = [u1, u2, u3, u4]
-- Relaciones
r1 :: Relacion
r1 = (u1, u2)
r2 :: Relacion
r2 = (u2, u3)
r3 :: Relacion
r3 = (u1, u3)
r4 :: Relacion
r4 = (u3, u4)
rs1 :: [Relacion]
rs1 = [r1, r2, r3]
rs2 :: [Relacion]
rs2 = [r1, r2]
rs3 :: [Relacion]
rs3 = [r1, r2, r4]
-- Publicaciones
p1 :: Publicacion
p1 = (u1, "Who up rn", [u2, u3, u4])
p2 :: Publicacion
p2 = (u1, "I need this fr fr on god on god", [u4])
p3 :: Publicacion
p3 = (u4, "Omg me", [u4])
p4 :: Publicacion
p4 = (u2, "me: also me:", [u1, u2, u3, u4])
ps1 :: [Publicacion]
ps1 = [p1, p2, p3, p4]
-- Redes
red1 :: RedSocial
red1 = (us1, rs1, ps1)
red2 :: RedSocial
red2 = (us1, rs2, ps1)
red3 = (us1, rs3, ps1)

-- Para tests de la cátedra
usuario1 = (1, "Juan")
usuario2 = (2, "Natalia")
usuario3 = (3, "Pedro")
usuario4 = (4, "Mariela")
usuario5 = (5, "Natalia")
relacion1_2 = (usuario1, usuario2)
relacion1_3 = (usuario1, usuario3)
relacion1_4 = (usuario4, usuario1)
relacion2_3 = (usuario3, usuario2)
relacion2_4 = (usuario2, usuario4)
relacion3_4 = (usuario4, usuario3)
publicacion1_1 = (usuario1, "Este es mi primer post", [usuario2, usuario4])
publicacion1_2 = (usuario1, "Este es mi segundo post", [usuario4])
publicacion1_3 = (usuario1, "Este es mi tercer post", [usuario2, usuario5])
publicacion1_4 = (usuario1, "Este es mi cuarto post", [])
publicacion1_5 = (usuario1, "Este es como mi quinto post", [usuario5])
publicacion2_1 = (usuario2, "Hello World", [usuario4])
publicacion2_2 = (usuario2, "Good Bye World", [usuario1, usuario4])
publicacion3_1 = (usuario3, "Lorem Ipsum", [])
publicacion3_2 = (usuario3, "dolor sit amet", [usuario2])
publicacion3_3 = (usuario3, "consectetur adipiscing elit", [usuario2, usuario5])
publicacion4_1 = (usuario4, "I am Alice. Not", [usuario1, usuario2])
publicacion4_2 = (usuario4, "I am Bob", [])
publicacion4_3 = (usuario4, "Just kidding, i am Mariela", [usuario1, usuario3])
usuariosA = [usuario1, usuario2, usuario3, usuario4]
relacionesA = [relacion1_2, relacion1_4, relacion2_3, relacion2_4, relacion3_4]
publicacionesA = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]
redA = (usuariosA, relacionesA, publicacionesA)
usuariosB = [usuario1, usuario2, usuario3, usuario5]
relacionesB = [relacion1_2, relacion2_3]
publicacionesB = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redB = (usuariosB, relacionesB, publicacionesB)

-- Roberto Carlos
uRC :: Usuario
uRC = (1, "Roberto Carlos")
-- Cantidad de amigos para ser Roberto Carlos
nAmigosMinimo :: Integer
nAmigosMinimo = 100
-- Auxiliar para testear estaRobertoCarlos
-- Toma una red vacía y un natural n y genera una red con n usuarios, 0 publicaciones, y n-1 relaciones en las cuales está sin falta implicado el usuario (1, "Roberto Carlos").
redParasocial :: RedSocial -> Integer -> RedSocial
redParasocial (us, rs, ps) 1 = (uRC:us, rs, ps)
redParasocial (us, rs, ps) n = redParasocial (fanRC:us, relacionRC:rs, ps) (n-1)
  where
    fanRC = (n, "Fan n°1 de R.C.")
    relacionRC = (fanRC, uRC)
redRC1 :: RedSocial
redRC1 = redParasocial ([], [], []) (nAmigosMinimo + 1) -- nAmigosMinimo amigos
redRC2 :: RedSocial
redRC2 = redParasocial ([], [], []) (nAmigosMinimo) -- nAmigosMinimo - 1 amigos
-- Auxiliar para testear estaRobertoCarlos
-- Identica a estaRobertoCarlos, pero para una cantidad de amigos mínima arbitrariamente menor de manera de poder ser testeada.
estaRobertoCarlosTest :: RedSocial -> Bool
estaRobertoCarlosTest red = cantidadDeAmigos red (usuarioConMasAmigos red) > (fromIntegral (nAmigosMinimo - 1))
-- Auxiliar para impresión en testing
assert :: Bool -> String
assert True = "PASS"
assert False = "FAIL"
-- Auxiliar para impresión en testing (función concatenadora de listas)
cc :: [t] -> [t] -> [t]
cc [] y = y
cc (xh:xt) y = xh:(cc xt y)

-- Programa principal
main :: IO()
main = do
  -- nombresDeUsuarios
  print (cc "Test 01.01. " (assert ([snd u1, snd u2, snd u3, snd u4] == nombresDeUsuarios red1)))
  -- amigosDe
  print (cc "Test 02.01. " (assert ([u2, u3] == amigosDe red1 u1)))
  print (cc "Test 02.02. " (assert ([] == amigosDe red1 u4)))
  -- longitud
  print (cc "Test 03.01. " (assert (0 == longitud [])))
  print (cc "Test 03.02. " (assert (3 == longitud [1,2,3])))
  -- cantidadDeAmigos
  print (cc "Test 03.03. " (assert (0 == (cantidadDeAmigos red1 u4))))
  print (cc "Test 03.04. " (assert (2 == (cantidadDeAmigos red1 u1))))
  -- usuarioConMasAmigos
  print (cc "Test 04.01. " (assert (u1 == usuarioConMasAmigos red1)))
  print (cc "Test 04.02. " (assert (u2 == usuarioConMasAmigos red2)))
  -- estaRobertoCarlos
  print (cc "Test 05.01. " (assert (False == estaRobertoCarlos red1)))
  print (cc "Test 05.02. " (assert (False == estaRobertoCarlos red2)))
  print (cc "Test 05.03. " (assert (True == estaRobertoCarlosTest redRC1)))
  print (cc "Test 05.04. " (assert (False == estaRobertoCarlosTest redRC2)))
  -- publicacionesDe
  print (cc "Test 06.01. " (assert ([p1, p2] == publicacionesDe red1 u1)))
  print (cc "Test 06.02. " (assert ([p3] == publicacionesDe red1 u4)))
  -- publicacionesQueLeGustanA
  print (cc "Test 07.01. " (assert (ps1 == publicacionesQueLeGustanA red1 u4)))
  print (cc "Test 07.02. " (assert ([p4] == publicacionesQueLeGustanA red1 u1)))
  -- lesGustanLasMismasPublicaciones
  print (cc "Test 08.01. " (assert (True == lesGustanLasMismasPublicaciones red1 u2 u3)))
  print (cc "Test 08.02. " (assert (False == lesGustanLasMismasPublicaciones red1 u1 u3)))
  -- tieneUnSeguidorFiel
  print (cc "Test 09.01. " (assert (True == tieneUnSeguidorFiel red1 u1)))
  print (cc "Test 09.02. " (assert (False == tieneUnSeguidorFiel red1 u4)))
  -- existeSecuenciaDeAmigos
  print (cc "Test 10.01. " (assert (False == existeSecuenciaDeAmigos red2 u1 u4)))
  print (cc "Test 10.02. " (assert (True == existeSecuenciaDeAmigos red3 u1 u4)))
  -- Cátedra
  print (cc "Test CA.01. " (assert (["Juan","Natalia","Pedro","Mariela"] == (nombresDeUsuarios redA))))
  print (cc "Test CA.02. " (assert ([usuario2, usuario4] == (amigosDe redA usuario1))))
  print (cc "Test CA.03. " (assert (2 == (cantidadDeAmigos redA usuario1))))
  print (cc "Test CA.04. " (assert ((usuarioConMasAmigos redA == usuario2) || (usuarioConMasAmigos redA == usuario4))))
  print (cc "Test CA.05. " (assert (False == (estaRobertoCarlos redA))))
  print (cc "Test CA.06. " (assert ([publicacion2_1, publicacion2_2] == (publicacionesDe redA usuario2))))
  print (cc "Test CA.07. " (assert ([publicacion2_2, publicacion4_1] == (publicacionesQueLeGustanA redA usuario1))))
  print (cc "Test CA.08. " (assert (True == (lesGustanLasMismasPublicaciones redB usuario1 usuario3))))
  print (cc "Test CA.09. " (assert (True == (tieneUnSeguidorFiel redA usuario1))))
  print (cc "Test CA.10. " (assert (True == (existeSecuenciaDeAmigos redA usuario1 usuario3))))
