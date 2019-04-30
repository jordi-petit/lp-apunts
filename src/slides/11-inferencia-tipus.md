
class: center, middle


Llenguatges de Programació

# Inferència de Tipus

Jordi Petit i Albert Rubio

<br/>

![:height 10em](img/type-inference.png)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Inferència de tipus

**Problema:** Donat un programa,
trobar el tipus més general pel programa (i totes les seves expressions)
dins del sistema de tipus del llenguatge.

**Solució presentada:** Algorisme de Milner

- Curry i Hindley havien desenvolupat idees similars
independentment en el context del λ-càlcul.

- L'algorisme és similar a la "unificació".

- Sempre present als llenguatges funcionals.

- S'ha estès a altres llenguatges: Visual Basic, C#, C++, ...

<br>
<br>
![:height 6em](img/robin-milner.png)
.xxs[Foto: Domini públic]


---

# Inferència de tipus a C++

La inferència de tipus apareix a la versió 11 de l'estàndar de C++.

-   `auto`: Dedueix el tipus d'una variable a través de
    la seva inicialització:

    ```c++
    map<int, string> m;
    auto x = 12;                // x és un int
    auto it = m.find(x);        // x és un map<int, string>::iterator
    ```

-  `decltype`: Obté el tipus d'una expressió.

    ```c++
    int x = 12;
    decltype(x + 1) y = 0;      // y és un int
    ```


---

# Inferència de tipus a Haskell

- En la majoria de casos no cal definir els tipus.

- Es poden demanar els tipus inferits (que inclouen classes, si cal).

    ```haskell
    λ> :type 3 * 4
    👉 3 * 4 :: Num a => a

    λ> :type odd (3 * 4)
    👉 odd (3 * 4) :: Bool
    ```

- Algunes situacions estranyes.

    - *Monomorphism restriction*:
    Sovint no es pot sobrecarregar una funció si no es dona una declaració
    explícita de tipus.

---

# Algorisme de Milner

## Noms aternatius

- Hindley–Milner, Damas–Milner, Damas–Hindley–Milner


## Propietats

- Complet.

- Computa el tipus més general possible sense necessitat d'anotacions.

- Eficient: gairebé lineal (inversa de la funció d'Ackermann).
    <br>
    L'eficiència depèn de l'algorisme d'unificació que s'apliqui.

---

# Algorisme de Milner

1. S'assigna un tipus a l'expressió i a cada subexpressió.

    - Si el tipus és conegut, se li assigna aquest tipus.

    - Altrament, se li assigna una variable de tipus.

    Recordeu que les funcions són expressions.

2. Es genera un conjunt de restriccions (d'igualtat principalment) a
   partir de l'arbre de l'expressió i les operacions que hi intervenen:

    - Aplicació,

    - Abstracció,

    - `let`, `where`,

    - `case`, guardes, patrons,

    - ...

3. Es resolen les restriccions mitjançant unificació.


---

# Algorisme de Milner

- Considerem aquesta expressió: `(+ 2 x)`

- Lliguem les variables lliures amb lambdes: `\x -> (+ 2 x)`

- Creem l'arbre de l'expressió: .xs[(els bucles estalvien feina)]

![:height 20em](img/inferencia/infer1.pdf.png)


---

# Algorisme de Milner

.cols5050[
.col1[
➀ Assignem tipus a totes les expressions:

![:height 20em](img/inferencia/infer2.pdf.png)
]
.col2[
➁ Obtenim les equacions:

$$
\begin{array}{rcl}
a &=& d → b \\\\
c &=& d → b \\\\
int → int → int &=& int → c \\\\
\end{array}
$$

<br>
➂ Solucionem:

$$
\begin{array}{rcl}
a &=& int → int \\\\
b &=& int  \\\\
c &=& int → int \\\\
d &=& int  \\\\
\end{array}
$$

<br>
➃ El tipus de l'expressió és doncs
$$
\begin{array}{rcl}
a &=& int → int \\\\
\end{array}
$$
]
]

---


# Algorisme de Milner

## Regles per generar les equacions

<br>
.cols303030[
.col13[
.my-center[
Abstracció

![:height 7em](img/inferencia/rule1.pdf.png)

$a = b → c$
]]
.col23[
.my-center[
Aplicació

![:height 7em](img/inferencia/rule2.pdf.png)

$b = c → a$
]]
.col23[
.my-center[
If-Then-Else

![:height 7em](img/inferencia/rule1.pdf.png)

$a = c$<br>
$a = b$

]]

]


---

# Algorisme de Milner

Considerem ara una defini ció de funció:

```haskell
map f l = if null l then [] else f (head l) : map f (tail l)
```

Podem entendre una definició com una funció que, aplicada als paràmetres,
torna la part dreta de la definició:

```haskell
\f -> \l -> if null l then [] else f (head l) : map f (tail l)
```

A més, podem entendre que el tipus del `if-then-else` és
$\textit{Bool} → a → a → a$.


---

# Algorisme de Milner

```haskell
\f -> \l -> if null l then [] else f (head l) : map f (tail l)
```

.my-center[
![:height 24em](img/inferencia/infer3.pdf.png)
]

---

# Algorisme de Milner

.my-center[
![:height 24em](img/inferencia/infer4.pdf.png)
]

---

# Algorisme de Milner

$$
\begin{array}{l}
s &=& c \to t\\\\
t &=& u_1 \to v_1\\\\
u_2 &=& b \to u_1\\\\
a_1\to [a_1]\to [a_1] &=& a \to u_2\\\\
v_2 &=& v_3 \to v_1\\\\
a_2\to [a_2]\to [a_2] &=& v_4 \to v_2\\\\
c &=& a \to v_4\\\\
v_5 &=& b \to v_3\\\\
d &=& c \to v_5\\\\
\\\\
s &=& d\\\\
\end{array}
$$



---

# Algorisme de Milner

$$
\begin{array}{rl}
a    & =  & [a_1] \\\\
a_2  & =  & a_1 \\\\
a_4  & =  & a_1 \\\\
a_5  & =  & a_3 \\\\
b    & =  & [a_3] \\\\
c    & =  & a_1\to a_3 \\\\
d    & =  & (a_1\to a_3)\to [a_1]\to [a_3] \\\\
s    & =  & (a_1\to a_3)\to [a_1]\to [a_3] \\\\
t    & =  & [a_1]\to [a_3] \\\\
u    & =  & [a_3] \\\\
v_1  & =  & [a_3]\to [a_3] \\\\
v_2  & =  & [a_3] \\\\
v_3  & =  & a_3 \\\\
v_4  & =  & a_1 \\\\
v_5  & =  & [a_1]\to [a_3] \\\\
v_6  & =  & [a_1] \\\\
\end{array}
$$


---

# Algorisme de Milner

Considerem ara una definició de funció amb patrons:

```haskell
map f (x : xs) = f x : map f xs
```

En aquest cas la introducció de lambdes és una mica diferent, ja que
tractem els patrons com si fossin variables lliures:

```haskell
\f -> \(x : xs) -> f x : map f xs
```

Noteu que ara hem de considerar que el primer argument de la lambda pot
ser una expressió, que tractarem igual que les demés.

Totes les variables del patró queden lligades per la lambda.


---

# Algorisme de Milner

```haskell
\f -> \(x : xs) -> f x : map f xs
```

.my-center[
![:height 24em](img/inferencia/infer5.pdf.png)
]


---

# Algorisme de Milner

$$
\begin{array}{l}
s = c \to t\\\\
t = u_1 \to v_1\\\\
u_2 = b \to u_1\\\\
a_1\to [a_1]\to [a_1] = a \to u_2\\\\
v_2 = v_3 \to v_1\\\\
a_2\to [a_2]\to [a_2] = v_4 \to v_2\\\\
c = a \to v_4\\\\
v_5 = b \to v_3\\\\
d = c \to v_5\\\\
\\\\
s = d\\\\
\end{array}
$$


---


# Algorisme de Milner

$$
\begin{array}{lcl}
a_1 &=& a\\\\
b  &=& [a]\\\\
c  &=& a\to a_2\\\\
d  &=& (a\to a_2)\to [a]\to [a_2]\\\\
s  &=& (a\to a_2)\to [a]\to [a_2]\\\\
t  &=& [a]\to [a_2]\\\\
u_1 &=& [a]\\\\
u_2 &=& [a]\to [a]\\\\
v_1 &=& [a_2]\\\\
v_2 &=& [a_2]\to [a_2]\\\\
v_3 &=& [a_2]\\\\
v_4 &=& a_2\\\\
v_5 &=& [a]\to [a_2]\\\\
\end{array}
$$

Per tant, el tipus era $(a\to a_2)\to [a]\to [a_2]$.


---

# Algorisme de Milner

Inferència per altres construccions:

-   Els `let` o `where` es poden expressar amb abstraccions i aplicacions:

    Per exemple

    ```haskell
    let x = y
    in z
    ```

    es tracta com

    ```haskell
    \x -> z y
    ```

-   Les guardes es tracten com un `if-then-else`.

-   El `case` es tracta com una definició per patrons.

---

# Algorisme de Milner (Classes)

Considerem ara que tenim classes de tipus.

És a dir, que tenim definicions com ara

```haskell
(+) :: Num a => a -> a -> a
(>) :: Ord a => a -> a -> Bool
```

Això introdueix un nou tipus de restricció *de context*.

Per tant, les solucions també

- han de satisfer les condicions de classe.
- contindran condicions de classe.


---

# Algorisme de Milner (Classes)

Reconsiderem l'exemple inicial:  `(+ 2 x)`

![:height 20em](img/inferencia/infer1.pdf.png)

---

# Algorisme de Milner (Classes)

Reconsiderem l'exemple inicial:  `(+ 2 x)`

![:height 20em](img/inferencia/infer8.pdf.png)

---

# Algorisme de Milner (Classes)

Equacions:

$$
\begin{array}{lcl}
s &=& d \to b\\\\
c &=& d \to b\\\\
e\to e\to e &=& a \to c\\\\
\end{array}
$$

Restriccions:

$$
\textit{Num} \;  e, \; \textit{Num} \;  a
$$

Solució:

$$
\begin{array}{lcl}
s  &=& a \to a\\\\
b  &=& a\\\\
c  &=& a\to a\\\\
d  &=& a\\\\
e  &=& a\\\\
\textit{Num} \; a \\\\
\end{array}
$$

El tipus és doncs $\textit{Num} \; a ⇒ a → a$.


---

# Algorisme de Milner (Errors)

Considerem ara un error: `(+ '2' x)`

![:height 20em](img/inferencia/infer9.pdf.png)


---

# Algorisme de Milner (Errors)

Considerem ara un error: `(+ '2' x)`

![:height 20em](img/inferencia/infer10.pdf.png)


---

# Algorisme de Milner (Errors)

Equacions:

$$
\begin{array}{lcl}
s &=& d \to b\\\\
c &=& d \to b\\\\
e\to e\to e &=& a \to c\\\\
\end{array}
$$

Restriccions:

$$
\textit{Num} \;  e
$$

Intent de solució:

$$
\begin{array}{lcl}
s  &=& \textit{Char}  \to \textit{Char} \\\\
b  &=& \textit{Char} \\\\
c  &=& \textit{Char} \to \textit{Char} \\\\
d  &=& \textit{Char} \\\\
e  &=& \textit{Char} \\\\
\textit{Num} \; \textit{Char} && ❌ \\\\
\end{array}
$$

Però `Char` no és instància de `Num`!



---

# Exercicis

-   Inferiu el tipus de:

    ```haskell
    even x = if rem x 2 == 0 then True else False
    ```

    amb `rem :: int -> int -> int`.

-   Inferiu el tipus de:

    ```haskell
    even x = rem x 2 == 0
    ```

-   Inferiu el tipus de:

    ```haskell
    last [x] = x
    ```

    Recordeu que `[x]` és `x:[]`.


---

# Exercicis


-   Inferiu el tipus de:

    ```haskell
    foldr f z (x : xs) = f x (foldr f z xs)
    ```

-   Inferiu el tipus de:

    ```haskell
    foldr f z (x : xs) = f x : (foldr f z xs)
    ```

-   Inferiu el tipus de:

    ```haskell
        delete x (y:ys) =
            if x == y
            then ys
            else y : delete x ys
    ```
    amb `(==) :: Eq a => a -> a -> Bool`.


