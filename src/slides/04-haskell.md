
class: center, middle


# Llenguatges de Programació

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
        menors = [x | x <- xs, x <  p]      -- o també filter (< p) xs
        majors = [x | x <- xs, x >= p]
```



---

# Primer tast


## Arbres

```haskell
data Arbin a = Buit | Node a (Arbin a) (Arbin a)

fondaria :: Arbin a -> [a]

fondaria Buit = []
fondaria (Node x fe fd) = [x] ++ fondaria fe ++ fondaria fd
```

--
## Entrada/sortida

```haskell
main = do
    linia <- getLine
    print $ factorial $ read linia
```
