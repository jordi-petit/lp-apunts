
class: center, middle


Llenguatges de Programació

# Haskell - Part 3

Albert Rubio, Jordi Petit

<br/>

![:height 10em](img/haskell.svg)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Llistes

Les llistes en Haskell s'implementen con a llistes encadenades.

La immutablitat de les dades permet compartir segments de les llistes.

|Operació | Cost     |
|:--------|:---------|
| `[]` |  $\Theta(1)$ |
| `$x$:$\textit{xs}$` |  $\Theta(1)$ |
| `$\textit{xs}$ ++ $\textit{ys}$` |  $\Theta(\vert \textit{xs}\vert)$ |
| `head $\textit{xs}$` |  $\Theta(1)$ |
| `tail $\textit{xs}$` |  $\Theta(1)$ |
| `last $\textit{xs}$` |  $\Theta(\vert \textit{xs}\vert)$ |
| `init $\textit{xs}$` |  $\Theta(\vert \textit{xs}\vert)$ |
| `null $\textit{xs}$` |  $\Theta(1)$ |
| `length $\textit{xs}$` |  $\Theta(\vert \textit{xs}\vert)$ |
| `reverse $\textit{xs}$` |  $\Theta(\vert \textit{xs}\vert)$ |
| `elem $x$ $\textit{xs}$` |  $\Theta(\vert \textit{xs}\vert)$ |
| `$\textit{xs}$ !! $i$` |  $\Theta(i)$ |

---

# Llistes amb rangs

Rangs

```haskell
λ> [1 .. 10]
👉 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
λ> [10 .. 1]
👉 []
λ> ['E' .. 'J']
👉 ['E', 'F', 'G', 'H', 'I', 'J']
```

Rangs amb salt

```haskell
λ> [10, 20 .. 100]
👉 [10, 20, 300, 40, 50, 60, 70, 80, 90, 100]
λ> [10, 9 .. 1]
👉 [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

λ> [1, 2, 4, 8, 16 .. 256]
💣
```

Rangs sense final

```haskell
λ> [1..]
👉 [1, 2, 3, 4, 5, 6, 7, 8, 9, .......... ]
λ> [1, 3 ..]
👉 [1, 3, 5, 7, 9, 11, 13, 15, .......... ]
```


---

# Llistes per comprensió


Una **llista per comprensió** és una construcció per crear, filtrar i combinar
llistes.

Sintàxi semblant a la notació matemàtica de construcció de conjunts.

<br>

Ternes pitagòriques en matemàtiques:
$$
    \\left\\{ (x,y,z) \mid 0 < x \le y \le z,  \  x^2+y^2=z^2 \\right\\}
$$

Ternes pitagòriques en Haskell (fins a `n`):

```haskell
λ> ternes n = [(x, y, z) | x <- [1..n], y <- [x..n], z <- [y..n], x*x + y*y == z*z]
    -- gens eficient

λ> ternes 20
👉 [(3,4,5),(5,12,13),(6,8,10),(8,15,17),(9,12,15),(12,16,20)]
```


---

# Llistes per comprensió

Ús bàsic: expressió amb generador (semblant a `map`)

```haskell
[x*x | x <- [1..100]]
```

Filtre (semblant a `map` i `filter`)

```haskell
[x*x | x <- [1..100], capicua x]
```

Múltiples filtres

```haskell
[x | x <- [1..100], x `mod` 3 == 0, x `mod` 5 == 0]
```

Múltiples generadors (producte cartesià)

```haskell
[(x, y) | x <- [1..10], y <- [1..10]]
```

Introducció de noms

```haskell
[q | x <- [10..], let q = x*x, let s = show q, s == reverse s]
```


---

# Llistes per comprensió


Compte amb l'ordre

```haskell
[(x, y) | x <- [1..3], y <- [1..2], even x]
[(x, y) | x <- [1..3], even x, y <- [1..2]]
```

Ternes pitagòriques

```haskell
ternes n = [(x, y, z) | x <- [1..n], y <- [x..n], z <- [y..n], x*x + y*y == z*z]
🐌

ternes n = [(x, y, z) | x <- [1..n],
                        y <- [x..n],
                        let z = floor $ sqrt $ fromIntegral $ x*x + y*y,
                        z <= n,
                        x*x + y*y == z*z]
😄
```

---

# Llistes per comprensió

## Perspectiva

Haskell

```haskell
[(x, y) | x <- xs, y <- ys, f x == g y, even x]
```

SQL

```sql
SELECT *
FROM xs
JOIN ys
WHERE xs.f = ys.g
AND xs % 2 = 0
```

---

# Exercicis


- Feu aquests problemes de Jutge.org:

    - [P93588](https://jutge.org/problems/P93588) Usage of comprehension lists

---

# Avaluació mandrosa


- L'**avaluació mandrosa** (*lazy*) només avalua el que cal.

- Un valor que encara no ha estat avaluat s'anomena *thunk*.

- Es pot avaluar una funció que té *thunks* com arguments.

- Provoca cert indeterminisme, sobre com s'executa.

- Ineficiència(?). Depen del compilador i depen del cas.

- Permet tractar estructures potencialment molt grans o "infinites".

---


...


---

# Llistes infinites

Generació de la llista infinita de zeros

```haskell
zeros :: [Int]

-- amb repeat
zeros = repeat 0

-- amb recursivitat infinita
zeros = 0 : zeros

-- prova
λ> take 5 zeros
👉 [0, 0, 0, 0, 0]
```


---

# Llistes infinites

Generació de la llista infinita de naturals

```haskell
naturals :: [Int]

-- amb rangs infinits
naturals = [0..]

-- amb iterate
naturals = iterate (+1) 0

-- amb recursivitat infinita
naturals = 0 : map (+1) naturals

-- prova
λ> take 5 naturals
👉 [0, 1, 2, 3, 4]
```


---

# Llistes infinites

Generació de la llista infinita de nombres de Fibonacci

*Figura!!!*

--

```haskell
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
```

--

```haskell
fibs :: [Integer]
fibs = fibs' 0 1
    where
        fibs' m n = m : fibs' n (m+n)
```


---

# Llistes infinites

Generació dels nombres primers amb el Garbell d'Eratòstenes


*Figura!!!*

--

```haskell
primers :: [Integer]

primers = garbell [2..]

    where

        garbell (p : xs) = p : garbell [x | x <- xs, x `mod` p > 0]
```


---

# Avaluació ansiosa

En Haskell es pot forçar cert nivell d'avaluació ansiosa (*eager*)
usant l'operador infix `$!`.

`f $! x` avalua primer `x` i després `f x`
però només avalua fins que troba un constructor.


---

# Exercicis


- Feu aquests problemes de Jutge.org:

    - [P98957](https://jutge.org/problems/P98957) Infinite lists
