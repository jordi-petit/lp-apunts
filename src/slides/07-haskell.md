
class: center, middle


Llenguatges de Programació

# Haskell - Part 4

Albert Rubio, Jordi Petit

<br/>

![:height 10em](img/haskell.svg)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Tipus predefinits

Com ja hem vist existeixen una sèrie de tipus predefinits:

- Tipus simples:
    - Int, Integer, Float, Double
    - Bool
    - Char

- Tipus estructurats:
    - Llistes
    - Tuples
    - Funcions

```haskell
     5  :: Integer
   True :: Bool
    'a' :: Char
[1,2,3] :: [Integer]
('b',4) :: (Char,Integer)
    not :: Bool -> Bool
```


---

# Tipus polimòrfics

```haskell
length :: [a] -> Int
map :: (a -> b) -> [a] -> [b]
```

El **polimorfisme paramètric**  és un mecanisme senzill que permet
definir funcions (i tipus) que s'escriuen genèricament, sense
dependre dels tipus dels objectes sobre els quals s'apliquen.

En Haskell, les **variables de tipus** poden prendre qualsevol valor
i estan quantificades universalment. Per convenció `a`, `b`, `c`, ...



---

# Tipus polimòrfics


Per a utilitzar funcions amb tipus polimòrfics cal que hi hagi
una substitució de les variables de tipus que s’adeqüi a l’aplicació que estem fent.

**Exemple:**  `map even [3,6,1]` té tipus `[Bool]` ja que:

- el tipus de `map` és `(a -> b) -> [a] -> [b]`,
- el tipus de `even` és `Int -> Bool`,
- per tant, `a` es pot substituir per `Int` i `b` es pot substituir per `Bool`,
- i el tipus final de l'expressió és `[Bool]`.

<br>

Una expressió dóna error de tipus si no existeix una substitució
per a les seves variables de tipus.

**Exemple:** `map not ['b','c']` dóna error de tipus ja que:

- per una banda, `a` hauria de ser `Bool`,
- per altre banda, `a` hauria de ser `Char`.



---

# Tipus sinònims

La construcció `type` permet substituir un tipus (complex)
per un nou nom.

Els dos tipus són intercanviables.

```haskell
type Euros = Float

sou :: Persona -> Euros
```

```haskell
type Diccionari = String -> Int

crear :: Diccionari
cercar :: Diccionari -> String -> Int
inserir :: Diccionari -> String -> Int -> Diccionari
esborrar :: Diccionari -> String -> Diccionari
```

Els tipus sinònims aporten claredat.

---

# Tipus enumerats

Els **tipus enumerats** dónen la llista de valors possibles
dels objectes d'aquell tipus.

```haskell
data Jugada = Pedra | Paper | Tisores

data Operador
    = Suma
    | Resta
    | Producte
    | Divisio

data Bool = False | True    -- predefinit
```

Els valors enumerats (**constructors**), han de començar amb majúscula.

Els tipus enumerats es poden desconstruir amb patrons:

```haskell
guanya :: Jugada -> Jugada -> Bool

guanya Paper Pedra = True
guanya Pedra Tisores = True
guanya Tisores Paper = True
guanya _ _ = False
```



---

# Tipus algebraics



Els **tipus algebraics** defineixen diversos constructors,
cadascun amb zero o més dades associades.


```haskell
data Forma
    = Rectangle Float Float         -- alçada, amplada
    | Quadrat Float                 -- mida
    | Cercle Float                  -- radi
    | Punt
```

Les dades es creen especificant el constructor i els seus valors respectius:

```haskell
λ> r = Rectangle 3 4
λ> :type r
👉 r :: Forma

λ> c = Cercle 2.0
λ> :type c
👉 c :: Forma
```


---

# Tipus algebraics

```haskell
data Forma
    = Rectangle Float Float         -- alçada, amplada
    | Quadrat Float                 -- mida
    | Cercle Float                  -- radi
    | Punt
```

Els tipus algebraics es poden desconstruir amb patrons:

```haskell
area :: Forma -> Float

area (Rectangle amplada alçada) = amplada * alçada
area (Quadrat mida) = mida^2
area (Cercle radi) = pi * radi^2
area Punt = 0
```

```haskell
λ> area (Rectangle 3 4)
👉 12

λ> c = Cercle 2.0
λ> area c
👉 12.566370614359172
```

---

# Tipus algebraics

Per escriure valors algebraics, cal afegir `deriving (Show)` al final
del tipus.
<br>⟹ més endavant veurem què vol dir.

```haskell
data Punt = Punt Int Int
    deriving (Show)

data Rectangle = Rectangle Punt Punt
    deriving (Show)
```

```haskell
λ> p1 = Punt 2 3
λ> p1
👉 Punt 2 3

λ> p2 = Punt 4 6
λ> p2
👉 Punt 4 6

λ> r = Rectangle p1 p2
λ> r
👉 Rectangle (Punt 2 3) (Punt 4 6)
```

---

# Arbres binaris d'enters

Els tipus algebraics també es poden definir recursivament!

```haskell
data Arbin = Buit | Node Int Arbin Arbin
    deriving (Show)
```

```haskell
λ> a1 = Node 1 Buit Buit
λ> a2 = Node 2 Buit Buit
λ> a3 = Node 3 a1 a2
λ> a4 = Node 4 a3 Buit
λ> a4
👉 Node 4 (Node 3 (Node 1 Buit Buit) (Node 2 Buit Buit)) Buit

λ> a5 = Node 5 a4 a4        -- I 💜 sharing
λ> a5
👉 Node 5 (Node 4 (Node 3 (Node 1 Buit Buit) (Node 2 Buit Buit)) Buit) (Node 4 (Node 3 (Node 1 Buit Buit) (Node 2 Buit Buit)) Buit)
```

Com sempre, la desconstrucció via patrons marca el camí: 👣

```haskell
alcada :: Arbin -> Int

alcada Buit = 0
alcada (Node _ fe fd) = 1 + max (alcada fe) (alcada fd)
```

---

# Arbres binaris genèrics

Els tipus algebraics també tenen polimorfisme paramètric!

```haskell
data Arbin a = Buit | Node a (Arbin a) (Arbin a)
    deriving (Show)
```

```haskell
a1 :: Arbin Int
a1 = Node 3 (Node 1 Buit Buit) (Node 2 Buit Buit)

a2 :: Arbin Forma
a2 = Node (Rectangle 3 4) (Node (Cercle 2) Buit Buit) (Node Punt Buit Buit)
```

```haskell
alcada :: Arbin a -> Int

alcada Buit = 0
alcada (Node _ fe fd) = 1 + max (alcada fe) (alcada fd)
```


```haskell
preordre :: Arbin a -> [a]

preordre Buit = []
preordre (Node x fe fd) = [x] ++ preordre fe ++ preordre fd
```

---

# Arbres generals genèrics

```haskell
data Argal a = Argal a [Argal a]        -- (no hi ha arbre buit en els arbres generals)
    deriving (Show)
```

```haskell
a = Argal 4 [Argal 1 [], Argal 2 [], Argal 3 [Argal 0 []]]
```

```haskell
mida :: Argal a -> Int

mida (Argal _ fills) = 1 + sum (map mida fills)
```


```haskell
preordre :: Argal a -> [a]

preordre (Argal x fills) = x : concatMap preordre fills
```



---

# Expressions booleanes amb variables

```haskell
data Expr
    = Val Bool
    | Var String
    | Not Expr
    | And Expr Expr
    | Or  Expr Expr
    deriving (Show)

type Dict = Char -> Bool
```

```haskell
eval :: ExprBool -> Dict -> Bool

eval (Val x) d = x
eval (Var v) d = d v
eval (Not e) d = not $ eval e d
eval (And e1 e2) d = eval e1 d && eval e2 d
eval (Or  e1 e2) d = eval e1 d || eval e2 d
```


```haskell
eval (And (Or (Val False) 'x') (Not (And 'y' 'z'))) (`elem` "xz")
    -- evalua (F ∨ x) ∧ (¬ (y ∧ z)) amb x = z = T i y = F
```


---

# Llistes genèriques:

```haskell
data Llista a = Buida | a `Davant` (List a)
    deriving (Show)
```

```haskell
l1 = 3 `Davant` 2 `Davant` 4 `Davant` Buida
```

```haskell
llargada :: Llista a -> Int

llargada Buida = 0
llargada (cap `Davant` cua) = 1 + llargada cua
```

--

Les llistes de Haskell són exactament això!


```haskell
data [a] = [] | a : (List a)
    deriving (Show)
```

```haskell
length :: [a] -> Int

length [] = 0
length (x:xs) = 1 + length xs
```



---

# Maybe a

El tipus polimòrfic `Maybe a` està predefinit així:

```haskell
data Maybe a = Just a | Nothing
```

Expressa dues possibilitats:

- la presència d'un valor (de tipus `a` amb el constructor `Just`), o
- la seva absència (amb el constructor buit `Nothing`).

Aplicacions:

- Indicar possibles valor nuls.
- Indicar absència d'un resultat.
- Reportar un error.

Exemples: (busqueu doc a [Hoogλe](https://www.haskell.org/hoogle/))

```haskell
find :: (a -> Bool) -> [a] -> Maybe a
lookup :: Eq a => a -> [(a,b)] -> Maybe b
```





---

# Either a b

El tipus polimòrfic `Either a b` està predefinit així:

```haskell
data Either a b = Left a | Right b
```

Expressa dues possibilitats per un valor:

- un valor de tipus `a` (amb el constructor `Left`), o
- un valor de tipus `b` (amb el constructor `Right`).

Aplicacions:

- Indicar que un valor pot ser, alternativament, de dos tipus.
- Reportar un error. Habitualment:
    - `a` és un `String` i és el diagnòstic de l'error.
    - `b` és del tipus del resultat esperat.
    - **Mnemotècnic:** *right* vol dir *dreta* i també *correcte*.

Exemple:

```haskell
secDiv :: Float -> Float -> Either String Float
secDiv _ 0 = Left "divisió per zero"
secDiv x y = Right (x / y)
```


---

# Exercicis

- Feu aquests problemes de Jutge.org:

    - [P97301](https://jutge.org/problems/P97301) FizzBuzz
    - [P37072](https://jutge.org/problems/P37072) Arbre binari
    - [P87706](https://jutge.org/problems/P87706) Arbres binaris de cerca
    - [P80618](https://jutge.org/problems/P80618) Cua (només el primer apartat)
    - [P79515](https://jutge.org/problems/P79515) Arbres AVL (🏅)
    - [P92181](https://jutge.org/problems/P92181) Nombres pseudoperfectes (🏅)
