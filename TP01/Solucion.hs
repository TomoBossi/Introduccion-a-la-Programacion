module Solucion where

-- Nombre de Grupo: GrupoTN1
-- Integrante 1: Santiago Thomas Calandrino, santicalan@gmail.com, 725/17
-- Integrante 2: Tomás Bossi, tomasbossi97@gmail.com, 50/17

type Usuario = (Integer, String) -- (id, nombre)

type Relacion = (Usuario, Usuario) -- usuarios que se relacionan

type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)

type RedSocial = ([Usuario], [Relacion], [Publicacion])

type Id = Integer

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

-- Toma una red social 'red' y devuelve
-- una lista con los nombres de todos los usuarios en 'red', sin repetir.
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios red = listaNombres (usuarios red)
  where
    listaNombres :: [Usuario] -> [String]
    listaNombres [] = []
    listaNombres ((_, n) : us) = n : listaNombres us

-- Toma una red social 'red' y un usuario 'usuario' y devuelve
-- una lista con los usuarios (id, nombre) de todos sus amigos, sin repetir.
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe red usuario = listaAmigos (relaciones red) (idDeUsuario usuario)
  where
    listaAmigos :: [Relacion] -> Id -> [Usuario]
    listaAmigos [] _ = []
    listaAmigos ((u1, u2) : rs) id
      | idDeUsuario u1 == id = u2 : listaAmigos rs id
      | idDeUsuario u2 == id = u1 : listaAmigos rs id
      | otherwise = listaAmigos rs id

-- Toma una red social 'red' y un usuario 'usuario' y devuelve
-- la cantidad de amigos que tiene en la red.
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos red usuario = longitud (amigosDe red usuario)

-- Toma una lista y devuelve su cantidad de elementos.
longitud :: [t] -> Int
longitud [] = 0
longitud (_ : xt) = 1 + longitud xt

-- Devuelve el (entre posiblemente varios) usuario con mayor cantidad
-- de amigos en 'red'.
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos red = usuarioEnMasRelaciones (usuarios red) (relaciones red)
  where
    usuarioEnMasRelaciones :: [Usuario] -> [Relacion] -> Usuario
    usuarioEnMasRelaciones (u : []) _ = u
    usuarioEnMasRelaciones (u0 : u1 : us) rs
      | cantAmigos u0 >= cantAmigos u1 = usuarioEnMasRelaciones (u0 : us) rs
      | otherwise = usuarioEnMasRelaciones (u1 : us) rs
      where cantAmigos = cantidadDeAmigos ([], rs, [])

-- Decide si algún usuario tiene mas de un millón de amigos en 'red'.
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = cantidadDeAmigos red (usuarioConMasAmigos red) > 1000000

-- Lista todas las publicaciones de 'usuario' en 'red', sin repetir.
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe red usuario = filtrarPublicaciones (publicaciones red)
  where
    id = idDeUsuario usuario
    filtrarPublicaciones :: [Publicacion] -> [Publicacion]
    filtrarPublicaciones [] = []
    filtrarPublicaciones (p : ps)
      | idAutor == id = p : filtrarPublicaciones ps
      | otherwise = filtrarPublicaciones ps
      where ((idAutor, _), _, _) = p

-- Lista todas las publicaciones que 'usuario' le dio "me gusta" en 'red', sin repetir.
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red usuario = filtrarPublicaciones (publicaciones red)
  where
    filtrarPublicaciones :: [Publicacion] -> [Publicacion]
    filtrarPublicaciones [] = []
    filtrarPublicaciones (p : ps)
      | usuario `pertenece` likes = p : filtrarPublicaciones ps
      | otherwise = filtrarPublicaciones ps
      where (_, _, likes) = p

-- Toma una lista y un elemento 'e', devuelve True
-- si el elemento pertenece a la lista o False en caso contrario.
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece e (x : xs) = x == e || pertenece e xs

lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red u1 u2 = mismosElementos likesU1 likesU2
  where
    likesU1 = publicacionesQueLeGustanA red u1
    likesU2 = publicacionesQueLeGustanA red u2

-- Toma dos listas 'x' 'y', devuelve True si tienen el mismo set
-- y la misma cantidad de elementos, False en caso contrario.
mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos x y = (longitud x == longitud y) && incluido x y && incluido y x

-- Toma dos listas 'x' 'y', devuelve True si todos los elementos
-- de la primera pertenecen al set de la segunda,
-- False en caso contrario.
incluido :: (Eq t) => [t] -> [t] -> Bool
incluido [] _ = True
incluido (x : xs) y = pertenece x y && incluido xs y

-- Decide si existe un usuario en la red social 'red' que le haya dado "me gusta"
-- a todas las publicaciones de 'usuario'.
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel red usuario = publicacionesDeUsuario /= [] && existeAlgunSeguidorFiel (listaDeLikes publicacionesDeUsuario)
  where
    publicacionesDeUsuario = publicacionesDe red usuario
    -- Toma las listas de usuarios que le dieron like a cada una de las publicaciones de un usuario,
    -- decide si existe algún otro usuario que le dio like a todas ellas.
    existeAlgunSeguidorFiel :: [[Usuario]] -> Bool
    existeAlgunSeguidorFiel (l : []) = l /= [] && l /= [usuario]
    existeAlgunSeguidorFiel (l0 : l1 : ls) = existeAlgunSeguidorFiel ((interseccion l0 l1) : ls)

-- Toma una lista de publicaciones y devuelve
-- la lista de listas de usuarios que les dieron like a cada una de ellas.
listaDeLikes :: [Publicacion] -> [[Usuario]]
listaDeLikes [] = []
listaDeLikes (p : ps) = (likesDePublicacion p) : (listaDeLikes ps)

-- Toma dos listas y devuelve la intersección de sus sets.
interseccion :: (Eq t) => [t] -> [t] -> [t]
interseccion [] _ = []
interseccion (x : xs) y
  | pertenece x y = x : (interseccion xs y)
  | otherwise = interseccion xs y
  
-- Decide si dos usuarios son amigos de manera directa o indirecta en 'red'.
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red usuario1 usuario2 = existeSecuenciaSinVistos red usuario1 usuario2 []
  where
    -- Transfiere el problema a cada amigo del usuario original usando una
    -- lista que incluye los usuarios cuyas amistades ya fueron analizadas por la función
    -- para evitar relaciones cíclicas.
    existeSecuenciaSinVistos :: RedSocial -> Usuario -> Usuario -> [Usuario] -> Bool
    existeSecuenciaSinVistos red u1 u2 vistos
      | u1 `pertenece` vistos = False
      | otherwise = u2 `pertenece` amigos || existeSecuenciaAmigosEnAmigos amigos
      where
        amigos = amigosDe red u1
        existeSecuenciaAmigosEnAmigos :: [Usuario] -> Bool
        existeSecuenciaAmigosEnAmigos [] = False
        existeSecuenciaAmigosEnAmigos (u : us) = existeSecuenciaSinVistos red u u2 (u1 : vistos) || existeSecuenciaAmigosEnAmigos us
