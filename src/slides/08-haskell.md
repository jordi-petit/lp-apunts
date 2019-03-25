
class: center, middle


Llenguatges de Programació

# Haskell - Part 5

Albert Rubio, Jordi Petit

<br/>

![:height 10em](img/haskell.svg)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Functors

.cols5050[
.col1[
Ja sabem aplicar funcions:

```haskell
λ> (+3) 2                   👉  5
```
]
.col2[
Però...

```haskell
λ> (+3) (Just 2)            ❌
```
]
]

En aquest cas, podem fer servir `fmap`!

```haskell
λ> fmap (+3) (Just 2)       👉  (Just 5)
λ> fmap (+3) Nothing        👉  Nothing
```

I també funciona amb `Either`:

```haskell
λ> fmap (+3) (Right 2)      👉  (Right 5)
λ> fmap (+3) (Left "err")   👉  (Left "err")
```

I també funciona amb llistes, com un `map`:

```haskell
λ> fmap (+3) [1, 2, 3]      👉  [4, 5, 6]
```


---

# Functors

`fmap` és una funció de les instàncies de la classe `Functor`:

```haskell
λ> :type fmap
fmap :: Functor f => (a -> b) -> f a -> f b
```

On

```haskell
λ> :info Functor
class Functor f where
    fmap :: (a -> b) -> f a -> f b
```

---

# Functors

El tipus `Maybe` és instància de `Functor`:

```haskell
λ> :info Maybe
data Maybe a = Nothing | Just a
instance Ord a => Ord (Maybe a)
instance Eq a => Eq (Maybe a)
instance Applicative Maybe
*instance Functor Maybe
instance Monad Maybe
⋮
```

Concretament,

```haskell
instance Functor Maybe where
    fmap f Nothing = Nothing
    fmap f (Just x) = Just (f x)
```

Igualment:


```haskell
instance Functor (Either a) where
    fmap f (Left  x) = Left x
    fmap f (Right x) = Right (f x)

instance Functor [] where
    fmap = map
```


---

# Functors

Exemple d'ús real: consulta a una BD:

- Llenguatge sense `Maybe`:

    ```python
    post = Posts.find(1234)
    if post:
        return post.title
    else:
        return None
    ```

- En Haskell:

    ```haskell
    fmap getPostTitle (findPost 1234)
    ```

    o també:

    ```haskell
    getPostTitle `fmap` findPost 1234
    ```

    o millor (`<$>` és l'operador infix per a `fmap`):

    ```haskell
    getPostTitle <$> findPost 1234
    ```




---

# Functors


Les funcions també són instàncies de `Functor`:

```haskell
instance Functor ((->) r) where
    fmap = (.)
```

Exemple:

```haskell
λ> (*3) <$> (+2) <$> Just 1      👉   Just 9
λ> (*3) <$> (+2) <$> Nothing     👉   Nothing
```



---

# Functors

La classe `Functor` captura la idea de tipus contenidor al qual se li pot
aplicar una funció per canviar el seu contingut (però no el contenidor).

.cols5050[
.col1[
.center[
![:height 6em](img/fmap_apply.png)
![:height 7em](img/fmap_list.png)
]]
.col2[
.center[
![:height 6em](img/fmap_nothing.png)
![:height 7em](img/fmap_function.png)
]]]




.right[.xxs[Dibuixos: [adit.io](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html)]]


---

# Functors

**Lleis** dels functors:

1. Identitat: `fmap id ≡ id`

2. Composició: `fmap (f . g) ≡ fmap f . fmap g`


<br>

<br>
**Exercici:** Comproveu que `Maybe`, `Either a` i `[]` compleixen
les lleis dels functors.


---

# Functors

Functors per arbres binaris:

```haskell
data Arbin a = Buit | Node a (Arbin a) (Arbin a)
    deriving (Show)
```

```haskell
instance Functor (Arbin) where
    fmap f Buit = Buit
    fmap f (Node x fe fd) = Node (f x) (fmap f fe) (fmap f fd)
```

```haskell
a = Node 3 Buit (Node 2 (Node 1 Buit Buit) (Node 1 Buit Buit))

λ> fmap (*2) a
👉 Node 6 Buit (Node 4 (Node 2 Buit Buit) (Node 2 Buit Buit))
```


---

# Mònades

Considerem que `meitat` és una funció que només té sentit
sobre parells:

```haskell
meitat :: Int -> Maybe Int

meitat x
    | even x    = Just (div x 2)
    | otherwise = Nothing
```

.cols5050[
.col1[
Podem veure la funció així: Donat un valor, retorna un valor empaquetat.

.center[
![:height 7em](img/half.png)
]
]
.col2[
Però llavors no li podem ficar valors empaquetats!

.center[
![:height 7em](img/half_ouch.png)
]
]
]

<br>

.right[.xxs[Dibuixos: [adit.io](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html)]]



---

# Mònades

Ens cal una funció que
desempaqueti,
apliqui `meitat` i
torni a empaquetar: `>>=` (*bind*)

```haskell
λ> Just 31 >>= meitat   👉 Nothing
λ> Just 40 >>= meitat   👉 Just 20
λ> Nothing >>= meitat   👉 Nothing

λ> Just 20 >>= meitat >>= meitat             👉 Just 5
λ> Just 20 >>= meitat >>= meitat >>= meitat  👉 Nothing
```

L'operador `>>=` és una operació de la class `Monad`:

```haskell
class Monad m where
    (>>=) :: m a -> (a -> m b) -> m b
```

El tipus `Maybe` és instància de `Monad`:

```haskell
instance Monad Maybe where
    Nothing >>= f   =   Nothing
    Just x  >>= f   =   Just (f x)
```



---

# Mònades

De fet, les mònades tenen tres operacions:

```haskell
class Monad m where
    return :: a -> m a
    (>>=)  :: m a -> (a -> m b) -> m b
    (>>)   :: m a -> m b -> m b

    r >> k   =   r >>= (\_ -> k)
```

- `return` empaqueta.

- `>>` és purament estètica.



Els tipus `Maybe`, `Either a` i [] són instàncies de `Monad`:

```haskell
instance Monad Maybe where
    Nothing >>= f   =   Nothing
    Just x  >>= f   =   Just (f x)

instance Monad (Either a) where
    Left x  >>= f   =   Left x
    Right x >>= f   =   Right (f x)

instance Monad [] where
    xs >>= f        =   concatMap f xs
```


---

# Mònades

Les mònades han de seguir tres lleis:

1. Identitat per l'esquerra: `return x >> f ≡ f x`.

2. Identitat per la dreta: `m >>= return >> m`.

3. Associativitat: `(m >>= f) >>= g ≡ \x -> f x >>= g`.

El compilador no comprova aquestes propietats (però les pot usar).
<br>⇒ És responsabilitat del programador assegurar-les.

<br>
**Exercici:** Comproveu que `Maybe`, `Either` i `[]` compleixen
les lleis de mònades

---

# Notació `do`

La **notació `do`** és sucre sintàctic
per facilitar l'ús de les mònades.
<br>⇒ Amb `do`, codi funcional sembla codi imperatiu.


.cols5050[
.col1[

Els còmputs es poden **seqüenciar**:

```haskell
do { e1 ; e2 }
```
.center[≡]
```haskell
do
    e1
    e2
```
.center[≡]
```haskell
e1 >> e2
```
]
.col2[

I amb `<-` **extreure** el seus resultats:

```haskell
do { x <- e1 ; e2 }
```
.center[≡]
```haskell
do
    x <- e1
    e2
```
.center[≡]
```haskell
e1 >>= \x -> e2
```
]]




---

# Notació `do`

Petita BD de joguina: Tenim informació sobre propietaris de cotxes,
les seves matrícules, els seus models i la seva etiqueta d'emissions:


```haskell
data Model = FordMustang | TeslaS3 | NissanLeaf | ToyotaHybrid
    deriving (Eq, Show)

data Etiqueta = Eco | B | C | Cap
    deriving (Eq, Show)

matricules = [("Joan", 6524), ("Pere", 6332), ("Anna", 5313), ("Laia", 9999)]

models = [(6524, NissanLeaf), (6332, FordMustang), (5313, TeslaS3), (7572, ToyotaHybrid)]

etiquetes = [(FordMustang, Cap), (TeslaS3, Eco), (NissanLeaf, Eco), (ToyotaHybrid, B)]
```

Donat un nom de propietari, volem saber quina és la seva etiqueta
d'emissions:

```haskell
etiqueta :: String -> Maybe Etiqueta
```

És `Maybe` perquè, potser el propietari no existeix, o no tenim
la seva matrícula, o no tenim el seu model, o no tenim la seva etiqueta...

---

# Notació `do`

Solució amb `case`: 💩
```Haskell
etiqueta nom =
    case lookup nom matricules of
        Nothing  -> Nothing
        Just mat -> case lookup mat models of
                        Nothing  -> Nothing
                        Just mod -> lookup mod etiquetes
```

--

Solució amb notació `do`: 💜
```Haskell
etiqueta nom = do
    mat <- lookup nom matricules
    mod <- lookup mat models
    lookup mod etiquetes

```

--

Transformació de notació `do` a funcional: 😜
```Haskell
etiqueta nom =
    lookup nom matricules >>=
        \mat -> lookup mat models >>=
            \mod -> lookup mod etiquetes
```


---

# Entrada/Sortida

L'entrada/sortida en Haskell es basa en una mònada:

- El programa principal és `main :: IO ()`

- S'usa el constructor de tipus `IO` per gestionar l'entrada/sortida.

- `IO` és instància de les classes `Functor` i `Monad`.

- Es sol usar amb notació `do`.


Algunes operacions bàsiques:

```haskell
getChar     :: IO Char
getLine     :: IO String
getContents :: IO String

putChar     :: Char -> IO ()
putStr      :: String -> IO ()
putStrLn    :: String -> IO ()
print       :: Show a => a -> IO ()
```

`()` s'anomena el tipus *unit* i representa *res* (⇔ `void` de C i cia).



---

#  Entrada/Sortida

Exemple:

```haskell
main = do
    putStrLn "Com et dius?"
    nom <- getLine
    putStrLn $ "Hola " ++ nom + "!"
```

Compilació i execució:

```bash
> ghc p.hs
[1 of 1] Compiling Main             ( p.hs, p.o )
Linking p ...

> ./p
Com et dius?
Jordi
Hola Jordi!
```

---

#  Entrada/Sortida

Exemple:

```haskell
main = do
    x <- getLine
    let y = reverse x
    putStrLn x
    putStrLn y
```

Compilació i execució:

```bash
> ghc p.hs
[1 of 1] Compiling Main             ( p.hs, p.o )
Linking p ...

> ./p
GAT
GAT
TAG
```


---

#  Entrada/Sortida

Exemple: Llegir seqüència de línies acabades en `*`
i escriure cadascuna del revés:

```haskell
main = do
    line <- getLine
    if line /= "*" then do
        putStrLn $ reverse line
        main
    else
        return ()
```

<br>

Exemple: Llegir seqüència de línies
i escriure cadascuna del revés:

```haskell
main = do
    contents <- getContents
    mapM (putStrLn . reverse) (lines contents)
```

L'E/S també és *lazy*, no cal preocupar-se perquè l'entrada
sigui massa llarga.


