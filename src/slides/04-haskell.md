
class: center, middle


Llenguatges de Programació

# Haskell

Albert Rubio, Jordi Petit

<br/>

![:height 10em](img/haskell.svg)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Introducció

- Llenguatge funcional pur.

- No hi ha:

  - assignacions,
  - bucles,
  - gestió memòria explícita.

- Hi ha:

  - *Lazy evaluation*: tractar estructures molt grans o infinites.

  - Sistemes de tipus potents.

    - tipus algebraics,
    - tipus polimòrfics,
    - inferència de tipus automàtica.

  - Funcions d'ordre superior. Funcions com a paràmetres.


---

# Història


- Al 1987 degut a la proliferació de FPLs és decideix definir un
  Standard: Haskell.

- Al 1998 es crea una versió estable: Haskell98.

- El nom és en homenatge a Haskell B. Curry, pel seu treball en lògica
  matemàtica, base dels FPLs.

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
comptaLiniesAmbFoo = not . null . filter (== "Foo") . lines

main = do
    entr <- getContents
    let hiHaFoo = comptaLiniesAmbFoo entr
    print hiHaFoo
```




---

# Eines

Utilitzarem el *Glasgow Haskell Compiler* (GHC).

Funciona amb dos modes:

  - compilador (`ghc`): genera un executable

  - intèrpret (`ghci`): obre un REPL (*Read–eval–print loop*)

Inicialment usarem l'intèrpret, després el compilador.


.cols5050[
.col1[
Instal·lació Linux
```bash
🐧> sudo apt install ghc
```
]
.col2[
Instal·lació Mac
```bash
🍎> brew install ghc
```
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
- Relacionals: `<`, `>`, `<=`, `>=`, `==`, `/=`

## Notació prefixa/infixa

```haskell
2 + 3
(+) 2 3

div 9 4
9 `div` 4
```

- Els operadors són infixos ⇒ posar-los entre parèntesi per fer-los prefixos
- les funcions són prefixes ⇒ posar-les entre *backtits* per fer-les infixes




---

# Definició de funcions

Els identificadors de funcions comencen amb minúscula.
i les funcions poden tenir associada una declaració de tipus.

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
fibonacci :: Integer -> Integer

fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n - 1) + fibonacci (n - 2)
```


Valor absolut

```haskell
valAbs :: Int -> Int

valAbs n
    | n >= 0    = n
    | otherwise = -n
```

Exponenciació

```haskell
elevat :: Int -> Int -> Int

x `elevat` 0 = 1
x `elevat` n = x * (x `elevat` (n - 1))
```



---

# Condicionals

La construcció `if-then-else` no és una instrucció sinó una funció de tres paràmetres:

- un booleà i dues expressions del mateix tipus,
- i retorna el resultat d'una de les dues expressions.

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
prod n m =
    if n == 0 then 0
    else
        let x = div n 2
            y = mod n 2
            p = prod x m
        in
            if y == 0 then p + p
            else m + prod (n - 1) m
```

O el `where`:

```haskell
prod n m =
    if n == 0 then 0
    else
        if y == 0 then p + p
        else m + prod (n - 1) m
    where
        x = div n 2
        y = mod n 2
        p = prod x m
```

El `where` no és una expressió i el seu àmbit es defineix per la indentació.


---

# Tuples

Una tupla és un tipus estructurat que genera un producte cartesià d'altres
tipus. Els camps són de tipus heterogenis.

```Haskell
(3, "Girona", False) :: (Int, String, Bool)

descomposicioHoraria :: Int -> (Int, Int, Int)    -- hores, minuts i segons
descomposicioHoraria segons = (h, m, s)
    where
        h = div segons 3600
        m = div (mod segons 3600) 60
        s = mod segons 60
```

Per a tuples de dos elements, es pot accedir amb `fst` i `snd`:

  - `fst ('a', 12)` és `'a'`
  - `snd ('a', 12)` és `12`

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

Una tupla és un tipus estructurat que conté una seqüència
d'elements, tots del mateix tipus.

```haskell
[]
[3, 9, 27] :: [Int]
[[7], [3, 9, 27], [1, 5], []] :: [[Int]]
["Barcelona", "Brusel·les"] :: [[Char]]
[1 .. 10]
[1, 3 .. 10]
```

Les llistes tenen dos **constructors**:

  - La llista buida: `[]`
  - Afegir per davant: `:` (amb `(:) :: a -> [a] -> [a]`)

La notació `[16, 12, 21]` és una drecera per `16 : 12 : 21 : []`
que vol dir `16 : (12 : (21 : []))`.

En Haskell poden haver-hi llistes infinites (ja ho veurem).

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

# Funcions predefinides sobre llistes

Vegeu [Funcions sobre llistes habituals en Haskell](https://xn--llions-yua.jutge.org/haskell/funcions-sobre-llistes.html).
