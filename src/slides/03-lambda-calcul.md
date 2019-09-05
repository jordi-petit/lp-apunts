
class: center, middle


Llenguatges de Programació

# Fonaments: λ-càlcul

Albert Rubio, Jordi Petit

<br/>

![:height 10em](img/lambda.png)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Introducció

El **λ-càlcul** és un model de computació funcional, l'orígen dels llenguatges
funcionals, i la base de la seva implementació.

.cols5050[
.col1[

Inventat per Alonzo Church, cap al 1930.

![:height 10em](img/alonzo-church.jpg)
.sepimg[]
![:height 10em](img/article-church.png)

]
.col2[

Consisteix en agafar una línia de símbols i aplicar una operació de *cut-and-paste*.

![:height 10em](img/lambda2.png)

]
]

<br><br>
.xxs[Fotos: Fair Use, [jstor.org](https://www.ics.uci.edu/~lopes/teaching/inf212W12/readings/church.pdf), [Lambda Calculus for Absolute Dummies](http://palmstroem.blogspot.com/2012/05/lambda-calculus-for-absolute-dummies.html)]


---

# Gramàtica

.my-inverse[
$$
\begin{align}
      \textit{terme} \ := \ & \textit{lletra} \ | \ (\ \textit{terme}\ ) \ | \ \textit{abstracció} \ | \ \textit{aplicació} \\\\
 \textit{abstracció} \ := \ & \mathbf{λ} \ \textit{lletra} \ . \ \textit{terme}\\\\
  \textit{aplicació} \ := \ & \textit{terme} \ \textit{terme}\\\\
\end{align}
$$
]

Exemples de termes:
-  $x$
-  $λ x . x$
-  $(λ y . x(yz)) (ab)$

Les lletres es diuen *variables* i no tenen cap significat. El seu nom no importa.
Si dues variables tenen el mateix nom, són la mateixa cosa.

Els parèntesis agrupen termes. Per claretat, s'agrupen per l'esquerra:

$$
  a b c d \equiv (((a b) c) d).
$$

La λ amb el punt introdueix funcions. Per claretat, es poden agrupar λs:
$$
    λ x . λ y . a \equiv λ x . (x) \equiv λ xy.a
$$

---

# Operacions

Només hi ha dues operacions per la construcció de termes:

- L'**abstracció** captura la idea de definir una funció amb un paràmetre:
$$
    λ x . u
$$
on $u$ és un terme.

  Diem que $λx$ és el *cap* i que $u$ és el *cos*.

  *Intuició:*
$
    f(x, y) = x^2 + 2y + x - 1
$
és representat per
$
    λ x . λ y . x^2 + 2y + x - 1
$

<br>

- L'**aplicació** captura la idea d'aplicar una funció sobre un paràmetre:
$$
    u \ v
$$
on $u$ i $v$ són dos termes.

    *Intuició:*
$
    f(6, 3)
$
és representat per
$
    f \ 6\  3
$
és a dir
$
    (f\  6) \ 3
$.


---

# Computació

La **β-reducció** és la única regla (*cut-and-paste*):
.my-inverse[
$$
   (λ x . u \  v) ⟶_β  u[x:=v]
$$
]

on $u[x:=v]$ vol dir reescriure $u$ substituïnt les seves $x$ per $v$.

Exemple: $(λ y . x(yz))(a b) ⟶_β x ((ab)z) \ ≡ \ x (a b z)$.

---

# Variables lliures i lligades

Dins d'un terme, una variable és **lligada** si apareix al cap d'una funció
que la conté. Altrament és **lliure**.

Les variables poden ser lliures i lligades alhora en un mateix terme.
Per exemple: $$(λx.xy)(λy.y)$$

En cas de tenir variables lligades, cal *renomenar-les*
abans d'operar.
Per exemple: $$(λx.x)x≡(λz.z)x≡x$$


---

# Macros

En el λ-càlcul, les funcions no reben noms.

Per facilitar-ne la escriptura, utilitzarem **macros** que representen
funcions i les expandirem quan calgui.

⇒ És un recurs "meta" que no forma part del llenguatge (preprocessador).

Exemple: $$\text{ID} ≡ λx.x$$

Llavors:
$$
    \begin{align}
        \text{ID} \ \text{ID} &\ ≡\  (λx.x)(λx.x)\\\\
         &\ ≡\  (λz.z)(λx.x)\\\\
         &\ ≡\  λx.x\\\\
         &\ ≡\  \text{ID} \\\\
    \end{align}
$$


---

# Calculadores

Existeixen moltes calculadores de λ-càlcul *online*:

- https://www.cl.cam.ac.uk/~rmk35/lambda_calculus/lambda_calculus.html
- https://jacksongl.github.io/files/demo/lambda/index.htm
- http://www-cs-students.stanford.edu/~blynn/lambda/ (amb notació Haskell)


---

# Naturals en λ-càlcul: Codificació

Podem definir els naturals en λ-càlcul d'aquesta manera:

$$
  \begin{align}
    0 & \ ≡\ λ sz.z \\\\
    1 & \ ≡\ λ sz.s(z) \\\\
    2 & \ ≡\ λ sz.s(s(z)) \\\\
    3 & \ ≡\ λ sz.s(s(s(z))) \\\\
      & \ \dots \\\\
    n & \ ≡\ λ sz.s^n z
  \end{align}
$$

En altres paraules, el natural $n$ és l'aplicació d'$n$ cops la funció $s$
a $z$.


---

# Naturals en λ-càlcul: Codificació

Una codificació estranya? No tant:

| Dec | Bin | Romà | Xinès | Devanagari|
|-------:|-------:|-------:|-------:|-------:|
| 0 | 0 | | 零 | ० |
| 1 | 1 | I | 一 | १ |
| 2 | 10 | Ⅱ   | 二 | २ |
| 3 | 11 | Ⅲ | 三 |३|
| 4 | 100 | Ⅳ | 四 | ४ |
| $\vdots$ |  | | | $\vdots$ |


L'important no és com es representen els naturals, sinó
establir una bijecció entre la seva representació i $\mathbb{N}$.

Tampoc estem considerant-ne l'eficiència.

---

# Naturals en λ-càlcul: Funció successor

La funció successor pot donar-se així:
$$
  \text{SUCC}\ ≡ \ λabc.b(abc)
$$

Apliquem-la a zero:
$$
  \begin{align}
    \text{SUCC 0} & \ ≡ \ (λabc.b(abc))(λsz.z) & \text{remplaçament macros}\\\\
    & \ ≡ \ λbc.b((λsz.z)bc))  & \text{aplicació}\\\\
    & \ ≡ \ λbc.b((λz.z)c))  & \text{aplicació}\\\\
    & \ ≡ \ λbc.b(c)  & \text{aplicació}\\\\
    & \ ≡ \ λsz.s(z)  & \text{renonenament de variables}\\\\
    & \ ≡ \ 1  & 😄\\\\
  \end{align}
$$


Apliquem-la a un:
$$
  \begin{align}
    \text{SUCC (SUCC 0)} & \ ≡ \ (λabc.b(abc))(λsz.s(z))\\\\
    & \ \dots  & \text{exercici}\\\\
    & \ ≡ \ λsz.s(s(z)) \\\\
    & \ ≡ \ 2  & 😄\\\\
  \end{align}
$$


---

# Naturals en λ-càlcul: Funció suma

La funció de suma:
$$
  \text{SUMA}\ x \ y \ ≡ \ x + y \ ≡\ x\text{ SUCC } y
$$
o, també:
$$
  x + y \ ≡\ λ p q x y . (p x (q x y))
$$

Proveu de sumar 3 i 2 amb les calculadores *online*.

<br>

Exercici: Com fer el producte?


---

# Lògica en λ-càlcul: Booleans

Podem definir els booleans en λ-càlcul d'aquesta manera:

$$
  \begin{align}
    \text{TRUE} & \ ≡\ λ xy.x \\\\
    \text{FALSE} & \ ≡\ λ xy.y & \text{(com el zero!)}\\\\
  \end{align}
$$

i definir els operadors lògics així:

$$
  \begin{align}
    \text{NOT} & \ ≡\ λ a.a(λbc.c)(λde.d) \\\\
    \text{AND} & \ ≡\ λ ab.ab(λxy.y) \\\\
    \text{OR} & \ ≡\ λ ab.a.(λxy.x)b \\\\
  \end{align}
$$


<br>

Exercici: Feu a mà
les taules de veritat de la NOT i comproveu que
és correcta.

Exercici: Utilitzeu les calculadores *online* per fer
les taules de veritat de les operacions AND i OR i comprovar que
són correctes.

Exercici: Escriviu TRUE i FALSE en Haskell, utilitzant funcions d'ordre superior.


---

# Recursivitat en λ-càlcul

Sembla que sense poder donar noms a les funcions, el λ-càlcul no pugui
donar suport a la recursivitat... però sí que es pot:

S'utilitza el **combinador Y** que crida una funció $y$ i es regenera ell mateix:

$$
  \text{Y} \ ≡\ λy (λx.y(xx))(λx.y(xx))
$$

Exemple: Apliquem Y a una funció R:


$$
  \begin{align}
    \text{Y} \ \text{R} &\ ≡ \  λy (λx.y(xx))(λx.y(xx))\text{R} \\\\
    &\ ≡ \  (λx.\text{R}(xx))(λx.\text{R}(xx)) \\\\
    &\ ≡ \  \text{R}((λx.\text{R}(xx))(λx.\text{R}(xx))) \\\\
    &\ ≡ \  \text{R}(\text{Y} \text{R})  &\text{(per la línia anterior)} \\\\
  \end{align}
$$

Per tant, hem aplicat R sobre YR, per tant, hem aplicat R recursivament!

---

# Universalitat del λ-càlcul

A partir d'aquí, ja només queda anar continuant fent definicions
i anar-les combinant:

- ISZERO
- IF THEN ELSE
- ...

Eventualment, es pot arribar a veure que qualsevol algorisme és implementable
en λ-càlcul perquè pot simular a una màquina de Turing.

**Teorema [Kleene i Rosser, 1936]:** Totes les funcions recursives poden ser
representades en λ-càlcul  (⟺ Turing complet).

<br>

A diferència del les màquines de Tuing que són un model matemàtic d'una
màquina *hardware* imperativa, el λ-càlcul només utilitza reescriptura
i és un model matemàtic més *software* i funcional.

---

# Propietats de la β-reducció

La β-reducció (→) és **confluent**:

Si $t → \dots → t_1$ i $t → \dots → t_2$ llavors<br>
$t_1 → \dots → t_3$ i $t_2 → \dots → t_3$

<br>

Estratègia **left-most outer-most**: Reduir la λ sintàcticament més a l'esquerra.

Aquesta estratègia és *normalitzant*: Si existeix un terme que no es pot
reescriure més, aquesta estratègia el troba!
