
class: center, middle


Llenguatges de Programació

# Haskell - Part 1

Albert Rubio, Jordi Petit

<br/>

![:height 10em](img/haskell.svg)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Introducció

Haskell és llenguatge de programació funcional pur.

.cols5050[
.col1[
No hi ha:

  - assignacions,

  - bucles,

  - efectes laterals,

  - gestió explícita de la memòria.
]
.col1[
Hi ha:

  - *Lazy evaluation*: permet tractar estructures molt grans o infinites.

  - Funcions d'ordre superior: Funcions com a paràmetres o resultats.

  - Sistema de tipus potent:

      - tipus algebraics,
      - tipus polimòrfics,
      - inferència de tipus automàtica.
]]

---

# Primer tast


## Factorial recursiu

```haskell
factorial :: Integer -> Integer

factorial 0 = 1
factorial n = n * factorial (n - 1)
```

--

## Factorial amb funció d'ordre superior

```haskell
factorial n = foldl (*) 1 [1..n]
```

--

## Quicksort

```haskell
quicksort :: Ord a => [a] -> [a]

quicksort []     = []
quicksort (p:xs) = (quicksort menors) ++ [p] ++ (quicksort majors)
    where
        menors = [x | x <- xs, x <  p]      -- filter (<  p) xs
        majors = [x | x <- xs, x >= p]      -- filter (>= p) xs
```



---

# Primer tast


## Arbres

```haskell
data Arbin a = Buit | Node a (Arbin a) (Arbin a)


alcada :: Arbin a -> Int

alcada Buit = 0
alcada (Node x fe fd) = 1 + max (alcada fe) (alcada fd)


preordre :: Arbin a -> [a]

preordre Buit = []
preordre (Node x fe fd) = [x] ++ preordre fe ++ preordre fd
```

--
## Entrada/sortida

```haskell
hiHaFoos = not . null . filter (== "Foo") . lines

main = do
    entr <- getContents
    let b = hiHaFoos entr
    print b
```


---

# Punts forts


- Fàcil de llegir, elegant

- Concís

- Compilat

- Tipatge fort

- Abstraccions potents

- Promou reús de codi

---

# Història


- Al 1987 degut a la proliferació de FPLs és decideix definir un
  Standard: Haskell.

- Al 1998 es crea una versió estable: Haskell98.

- El nom és en homenatge a Haskell B. Curry, pel seu treball en lògica
  matemàtica, base dels FPLs.



---

# Eines

Utilitzarem el *Glasgow Haskell Compiler* (GHC).

Funciona amb dos modes:

  - compilador (`ghc`): genera un executable

  - intèrpret (`ghci`): obre un REPL (*Read–eval–print loop*)

Inicialment usarem l'intèrpret, després el compilador.

<br>

.my-center[
[![:height 3em](img/haskell-platform.png)](https://www.haskell.org/platform/)
]


.cols5050[
.col1[
Instal·lació Linux
```bash
🐧> sudo apt install ghc
```
]
.col2[
Instal·lació MacOS
```bash
🍎> brew install ghc
```
.xxs[
    [Brew](https://brew.sh/index_ca):
    El gestor de paquets per macOS que faltava]
]
]

---

# Comandes de `ghci`


Invocació: `ghci`.

- `:?` invoca l'ajuda.

- `:load fitxer.hs` (`:l`) carrega codi font de `fitxer.hs`.

- `:reload` (`:r`) recarrega el darrer codi font.

- `:type expressió` (`:t`) escriu el tipus de l'`expressió`.

- `:quit` (`:q`, <kbd>control</kbd>+<kbd>d</kbd>) surt.



---

# Tipus predefinits bàsics

|Tipus       |  Descripció     | Literals      |
|:--------|:--------|:-------|
|`Bool`|Booleans|`False`, `True`|
|`Int`|Enters (32 o 64 bits Ca2)|`16`, `(-22)`|
|`Integer`|Enters (arbitràriament llargs)| `587326354873452644428` |
|`Char`|Caràcters|`'a'`, `'A'`, `'\n'`|
|`Float`|Reals|`3.1416`, `1e-9`|

Exemples:

```haskell
3 :: Int
3 :: Integer
3.0 :: Float
```



---

# Tipus complexos

|Tipus       |  Descripció     | Literals      |
|:--------|:--------|:-------|
|`a -> b`|Funcions|`Int -> Bool`|
|`(a, b, c)`|Tuples|`("Lleida", 23465, 'M')`|
|`[a]`|Llistes de `a`s|`[1, 4, 9, 16]`|
|`String`|Textos ≡ `[Char]`|`"Jordi"`|

Les fletxes de les funcions s'associen per la dreta:

- `a -> b -> c` vol dir `a -> (b -> c)`.
- `a -> b -> c -> d` vol dir `a -> (b -> (c -> d))`.



---

# Operacions bàsiques

## Bool

Operadors habituals:

- ` not :: Bool -> Bool`
- `(&&) :: Bool -> Bool -> Bool`
- `(||) :: Bool -> Bool -> Bool`

Definició de la o-exclusiva:

```haskell
xOr :: Bool -> Bool -> Bool
xOr x y = (x || y) && not (x && y)
```

--

## Char

Funcions de conversió: (cal un `import Data.Char`)

- `ord :: Char -> Int`
- `chr :: Int -> Char`

Operadors relacionals: `<`, `>`, `<=`, `>=`, `==`, `/=` (⚠️ no `!=`)


---

# Operacions bàsiques

## Operadors aritmàtics (`Int`, `Integer`, `Float`)

- Suma: `+`
- Resta: `-`
- Multiplicació: `*`
- Divisió: `/`, `div`, `rem`, `mod`
- Valor absolut: `abs`
- Conversió enter a real: `fromIntegral`
- Conversió real a enter: `round`, `floor`, `ceiling`
- Relacionals: `<`, `>`, `<=`, `>=`, `==`, `/=` (⚠️ no `!=`)

## Notació prefixa/infixa

.cols5050[
.col1[
```haskell
2 + 3       👉 5
(+) 2 3     👉 5
```
Els operadors són infixos ⇒ posar-los entre parèntesis per fer-los prefixos
]
.col2[
```haskell
div 9 4     👉 2
9 `div` 4   👉 2
```
Les funcions són prefixes ⇒ posar-les entre *backtits* per fer-les infixes
]]




---

# Definició de funcions

Els identificadors de funcions comencen amb minúscula.
<br>Les funcions poden tenir associada una declaració de tipus.

```haskell
factorial :: Integer -> Integer
```

Si no hi és, Haskell infereix tot sol el tipus (inconvenient per a novells).

Les funcions es poden definir amb **patrons**:

```haskell
factorial 0 = 1
factorial n = n * factorial (n - 1)
```

o amb **guardes**:

```haskell
factorial n
    | n == 0    = 1
    | otherwise = n * factorial (n - 1)
```

L'avaluació dels patrons i de les guardes entra per la primera
branca satisfactible. <br>⇒ Es pot assumir que les anteriors han fallat.

⚠️ La igualtat va després de cada guarda!



---

# Definició de funcions: Exemples

Fibonacci

```haskell
fibonacci :: Integer -> Integer     -- retorna el número de Fibonacci corresponent

fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)
```


Valor absolut

```haskell
valAbs :: Int -> Int                -- retorna el valor absolut d'un enter

valAbs n
    | n >= 0    = n
    | otherwise = -n
```

Exponenciació

```haskell
elevat :: Int -> Int -> Int         -- a `elevat` b retorna a^b

x `elevat` 0 = 1
x `elevat` n = x * (x `elevat` (n - 1))
```



---

# Condicionals

La construcció `if-then-else` no és una instrucció sinó una funció de tres paràmetres:

- un booleà i dues expressions del mateix tipus,
- que retorna el resultat d'una de les dues expressions.

    ```haskell
    prod n m =
        if n == 0 then
            0
        else
            m + prod (n - 1) m
    ```

Similarment, el `case` també és una funció que permet aplicar discriminació
per patrons:

  - S'utilitza de forma semblant als patrons de les funcions però
    amb qualsevol expressió.

    ```haskell
    prod n m =
        case n of
            0 -> 0
            x -> m + prod (x - 1) m
    ```


---

# Ús de funcions

Els paràmetres no es passen, s'apliquen.

NO cal passar tots els parametres.

Totes les funcions tenen un únic paràmetre.

Les funcions de més d'un paràmetre retornen, en realitat, una nova funció.

Exemple:

`prod 3 5` és, en realitat, `(prod 3) 5`

--

Primer apliquem 3 i el resultat és un funció que espera un altre enter.

`prod :: Int -> Int -> Int`

--

`prod :: Int -> (Int -> Int)`

--

`(prod 3) :: (Int -> Int)`

--

`(prod 3) 5:: Int`




---

# Definicions locals

Per definir noms locals s'utilitza el `let-in`:

```haskell
fastExp x 0 = 1
fastExp x n =
        let y  = fastExp x n2
            n2  = div n 2
        in
            if even n then y * y
            else y * y * x
```

O el `where`:

```haskell
fastExp x n
    | n == 0    = 1
    | even n    = y * y
    | otherwise = y * y * x
    where
        y  = fastExp x n2
        n2 = div n 2
```

El `where` no és una expressió i el seu àmbit es defineix per la indentació.


---

# Tuples

Una tupla és un tipus estructurat que genera un producte cartesià d'altres
tipus.
<br>Els camps són de tipus heterogenis.

```Haskell
descomposicioHoraria :: Int -> (Int, Int, Int)    -- hores, minuts, segons
descomposicioHoraria segons = (h, m, s)
    where
        h = div segons 3600
        m = div (mod segons 3600) 60
        s = mod segons 60
```

Per a tuples de dos elements, es pot accedir amb `fst` i `snd`:

```Haskell
λ> fst (3, "tres")
👉 3
λ> snd (3, "tres")
👉 "tres"
```

Per a tuples generals, no hi ha definides funcions d'accés
<br>⇒ Es poden crear o, millor, usar discriminació per patrons:
.cols5050[
.col1[
```haskell
primer (x, y, z) = x
segon  (x, y, z) = y
tercer (x, y, z) = z
```

]
.col2[
```haskell
primer (x, _, _) = x
segon  (_, y, _) = y
tercer (_, _, z) = z
```

]
]



---

# Llistes

Una llista és un tipus estructurat que conté una seqüència
d'elements, <br>
tots del mateix tipus.

```haskell
[]
[3, 9, 27] :: [Int]
[(1, "un"), (2, "dos"), (3, "tres")] :: [(Int, String)]
[[7], [3, 9, 27], [1, 5], []] :: [[Int]]
[1 .. 10]
[1, 3 .. 10]
```

Les llistes tenen dos **constructors**:

  - La llista buida: `[]`
  - Afegir per davant: `:` (amb `(:) :: a -> [a] -> [a]`)

La notació `[16, 12, 21]`
<br>és una drecera per `16 : 12 : 21 : []`
<br>que vol dir `16 : (12 : (21 : []))`.


---

# Llistes

- Els contructors `[]` i `:` funcionen en temps costant (*DS sharing*).

- L'operador `++` retorna la concatenació de dues llistes
(temps proporcional a la llarga de la primera llista).

- En Haskell poden haver-hi llistes infinites (ja ho veurem).

---

# Llistes i patrons

La discriminació per patrons permet **desconstruir** les llistes:

```haskell
suma :: [Float] -> Float

suma [] = 0.0
suma (x:xs) = x + suma xs
```

Diem que $e_1$ *matches* $e_2$ si existeix una substitució per les
variables de $e_1$ que la fan igual que $e_2$.

**Exemples**:

- `x:xs` *matches* `[2, 5, 8]` perquè `[2, 5, 8]` és `2 : (5 : 8 : [])`
  substituïnt `x` amb `2` i `xs` amb `(5 : 8 : [])`
  que és `[5, 8]`.

- `x:xs` *does not match* `[]` perquè `[]` i `:` són constructors
  diferents.

- `x1:x2:xs` *matches* `[2, 5, 8]`
  substituïnt `x1` amb `2`, `x2` amb `5`
  i `xs` amb `[8]`.

- `x1:x2:xs` *matches* `[2, 5]`
  substituïnt `x1` amb `2`, `x2` amb `5`
  i `xs` amb `[]`.

**Nota:** El mecanisme de *matching* no és el mateix que el d'*unificació*
(Prolog).



---

# Llistes i patrons

Els patrons també es poden usar al `case` i al `where`.

```haskell
suma llista =
    case llista of
        [] -> 0
        (x:xs) -> x + suma xs

divImod n m
    | n < m      = (0, n)
    | otherwise  = (q + 1, r)
    where (q, r) = divImod (n - m) m
```


---

# Funcions habituals sobre llistes

## head, last

- Signatura:

    ```Haskell
    head :: [a] -> a
    last :: [a] -> a
    ```

- Descripció:

    - `head xs` és el primer element de la llista `xs`.
    - `last xs` és el darrer element de la llista `xs`.

    Error si `xs` és buida.

- Exemples:

    ```Haskell
    λ> head [1 .. 4]
    👉 1
    λ> last [1 .. 4]
    👉 4
    ```

---

# Funcions habituals sobre llistes

## tail, init

- Signatura:

    ```Haskell
    tail :: [a] -> [a]
    init :: [a] -> [a]
    ```

- Descripció:

    - `tail xs` és la llista `xs` sense el seu primer element.
    - `init xs` és la llista `xs` sense el seu darrer element.

    Error si `xs` és buida.

- Exemples:

    ```Haskell
    λ> tail [1..4]
    👉 [2, 3, 4]
    λ> init [1..4]
    👉 [1, 2, 3]
    ```


---

# Funcions habituals sobre llistes

## reverse

- Signatura:

    ```Haskell
    reverse :: [a] -> [a]
    ```

- Descripció:

    `reverse xs` és la llista `xs` del revés.

- Exemples:

    ```Haskell
    λ> reverse [1..4]
    👉 [4, 3, 2, 1]
    ```


---

# Funcions habituals sobre llistes

## length

- Signatura:

    ```Haskell
    length :: [a] -> Int
    ```

- Descripció:

    `length xs` és el nombre d'elements a la llista `xs`.


---

# Funcions habituals sobre llistes

## null

- Signatura:

    ```Haskell
    null :: [a] -> Bool
    ```

- Descripció:

    `null xs` indica si la llista `xs` és buida.


---

# Funcions habituals sobre llistes

## elem

- Signatura:

    ```Haskell
    elem :: (Eq a) => a -> [a] -> Bool
    ```

- Descripció:

    `elem x xs` indica si `x` és a la llista `xs`.


---

# Funcions habituals sobre llistes

## `(!!)`

- Signatura:

    ```Haskell
    (!!) :: [a] -> Int -> a
    ```

- Descripció:

    `xs !! i` és l'`i`-èsim element de la llista `xs` (començant per zero).


---

# Funcions habituals sobre llistes

## maximum, minimum

- Signatura:

    ```Haskell
    maximum :: (Ord a) => [a] -> a
    minimum :: (Ord a) => [a] -> a
    ```

- Descripció:

    - `maximum xs` és l'element més gran de la llista (no buida!) `xs`.
    - `minimum xs` és l'element més petit de la llista (no buida!) `xs`.


---

# Funcions habituals sobre llistes

## and, or

- Signatura:

    ```Haskell
    and :: [Bool] -> Bool
    or  :: [Bool] -> Bool
    ```

- Descripció:

    - `and bs` és la conjunció de la llista de booleans `bs`.
    - `or bs` és la disjunció de la llista de booleans `bs`.


---

# Funcions habituals sobre llistes

## sum, product

- Signatura:

    ```Haskell
    sum     :: [Int] -> Int
    product :: [Int] -> Int
    ```

- Descripció:

    - `sum xs` és la suma de la llista d'enters `xs`.
    - `prod xs` és el producte de la llista d'enters `xs`.

- Exemples:

    ```Haskell
    fact n = prod [1 .. n]

    λ> fact 5
    👉 120
    ```

---

# Funcions habituals sobre llistes

## take, drop

- Signatura:

    ```Haskell
    take :: Int -> [a] -> [a]
    drop :: Int -> [a] -> [a]
    ```

- Descripció:

    - `take n xs` és el prefixe de llargada `n` de la llista `xs`.
    - `drop n xs` és el sufixe de la llista `xs` quan se li treuen els
      `n` primers elements.


- Exemples:

    ```Haskell
    λ> take 3 [1 .. 7]
    👉 [1, 2, 3]
    λ> drop 3 [1 .. 7]
    👉 [4, 5, 6, 7]
    ```



---

# Funcions habituals sobre llistes

## zip

- Signatura:

    ```Haskell
    zip :: [a] -> [b] -> [(a, b)]
    ```

- Descripció:

    `zip xs ys` és la llista que combina, en ordre, cada parell d'elements de `xs` i `ys`. Si en falten,
    es perden.

- Exemples:

    ```Haskell
    λ> zip [1, 2, 3] ['a', 'b', 'c']
    👉 [(1, 'a'), (2, 'b'), (3, 'c')]
    λ> zip [1 .. 10] [1 .. 3]
    👉 [(1, 1), (2, 2), (3, 3)]
    ```

---

# Funcions habituals sobre llistes

## repeat

- Signatura:

    ```Haskell
    repeat :: a -> [a]
    ```

- Descripció:

    `repeat x` és la llista infinita on tots els elements són `x`.

- Exemples:

    ```Haskell
    λ> repeat 3
    👉 [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, ...]
    λ> take 4 (repeat 3)
    👉 [3, 3, 3, 3]
    ```

---

# Funcions habituals sobre llistes

## concat

- Signatura:

    ```Haskell
    concat :: [[a]] -> [a]
    ```

- Descripció:

    `concat xs` és la llista que concatena totes les llistes de `xs`.

- Exemples:

    ```Haskell
    λ> concat [[1, 2, 3], [], [3], [1, 2]]
    👉 [1, 2, 3, 3, 1, 2]
    ```


---

# Exercicis

- Proveu de cercar documentació de funcions a [Hoogλe](https://www.haskell.org/hoogle/).

- Implementeu les funcions habituals sobre llistes anteriors.

    - Useu `myLength` enlloc de `length` per evitar xocs de noms.
    - Useu recursivitat quan calgui.

- Feu aquests problemes de Jutge.org:

    - [P77907](https://jutge.org/problems/P77907) Functions with numbers
    - [P25054](https://jutge.org/problems/P25054) Functions with lists
    - [P29040](https://jutge.org/problems/P29040) Sorting

