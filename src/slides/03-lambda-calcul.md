
class: center, middle


Llenguatges de Programació

# Fonaments: λ-càlcul

Albert Rubio, Jordi Petit, Fernando Orejas

<br/>

![:height 10em](img/lambda.png)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Introducció

El **λ-càlcul** és un model de computació funcional, l'origen dels llenguatges
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

<br>

.xxs[
Fotos: Fair Use, [jstor.org](https://www.ics.uci.edu/~lopes/teaching/inf212W12/readings/church.pdf), [Lambda Calculus for Absolute Dummies](http://palmstroem.blogspot.com/2012/05/lambda-calculus-for-absolute-dummies.html)
]


---

# Gramàtica

```
      terme  →  lletra  |  ( terme )  |  abstracció  |  aplicació
 abstracció  →  λ  lletra  .  terme
  aplicació  →  terme  terme
```


Exemples de termes:
-  $x$
-  $λ x . x$
-  $(λ y . x(yz)) (ab)$

Arbre de  $(λ y . x(yz)) (ab)$:

<div id='cy_expr1' style='width: 75%; height: 14em; border: solid black 0px;'></div>




---

# Gramàtica


Les lletres es diuen *variables* i no tenen cap significat. El seu nom no importa.
Si dues variables tenen el mateix nom, són la mateixa cosa.

Els parèntesis agrupen termes. Per claredat, s'agrupen per l'esquerra:

$$
  a b c d \equiv (((a b) c) d).
$$

La λ amb el punt introdueix funcions. Per claredat, es poden agrupar λs:
$$
    λ x . λ y . a \equiv λ x . (λ y . a) \equiv λ xy.a
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
    f \ x
$$
on $f$ i $x$ són dos termes.

  *Intuició:*
$
    f(x)
$
és representat per
$
    f x
$

---

# Currificació

Al λ-càlcul totes les funcions tenen un sol paràmetre.

Les funcions que
normalment consideraríem que tenen més d'un paràmetre es representen com a
funcions d'un sol paràmetre utilitzant la tècnica del *currying*:

- Una funció amb dos paràmetres, com ara la suma, +: int x int ⟶ int, es pot considerar equivalent a una funció d'un sol paràmetre que retorna una funció d'un paràmetre, +: int ⟶ (int ⟶ int).

- Això vol dir que $2 + 3$, amb notació prefixa $(+ 2 ~ 3)$, s'interpretaria com $(+2)~3$, on $(+2)$ és la funció que aplicada a qualsevol paràmetre $x$, retorna $x+2$.


<br>

**Currificar** és transformar una funció que accepta $n$ paràmetres i convertir-la en una
funció que, donat un paràmetre (el primer) retorna una funció que
accepta $n-1$ paràmetres (i són semànticament equivalents).



---

# Computació

La **β-reducció** (*cut-and-paste*) és la regla essencial de computació del λ-càlcul:
.my-inverse[
$$
   (λ x . u \  v) ⟶_β  u[x:=v]
$$
]

on $u[x:=v]$ vol dir reescriure $u$ substituint les seves $x$ per $v$.

Exemple: $(λ y . x(yz))(a b) ⟶_β x ((ab)z) \ ≡ \ x (a b z)$.

<br>

Si una expressió no pot β-reduir-se, aleshores es diu que està en **forma normal**.

Si $t  ⟶  ... ⟶ t'$   i   $t'$ està en forma normal, aleshores es diu que $t'$ és la forma normal de $t$, i es considera que $t'$ es el resultat de l'avaluació de $t$.

Una λ-expressió té, com a màxim, una forma normal.

---

# Variables lliures i lligades

Dins d'un terme, una variable és **lligada** si apareix al cap d'una funció
que la conté. Altrament és **lliure**.

Les variables poden ser lliures i lligades alhora en un mateix terme.

Per exemple: $$(λx.xy)(λy.y)$$

- $y$ és lliure a la primera subexpressió.
- $y$ és lligada a la segona subexpressió.

---

# El problema de la captura de noms

Quan s'aplica la β-reducció s'ha de tenir cura amb els noms de les variables i, si cal, renomenar-les.

El problema es pot veure en el següent exemple:
Sigui $\text{TWICE}$: $$λf.λx.f(f x)$$

Calculem $(\text{TWICE} ~ \text{TWICE})$:

$$
\begin{align}
\text{TWICE} ~ \text{TWICE}
~=~& (λf.λx.f(f x)) \text{TWICE} \\\\
~⟶_β~& (λx.\text{TWICE}(\text{TWICE} ~ x)) \\\\
~=~& (λx.\text{TWICE}(λf.λx.f(f x)) x) \\\\
\end{align}
$$
Aplicant la β-reducció directament tindríem:

$(λx.\text{TWICE}(λf.λx.f(f x)) x) ⟶_β (λx.\text{TWICE}(λx.x(x x)))$ **ERROR**

El que hauríem de fer és renomenar la variable lligada $x$ mes interna:

$(λx.\text{TWICE}((λf.λx.f(f x)) x) = (λx.\text{TWICE}((λf.λy.f(f y)) x) $
<br>
$⟶_β (λx.\text{TWICE}((λy.x(x y))$ **OK**

---

#  α-Conversió

A més de la β-reducció, al λ-càlcul tenim la regla de l'α-conversió per renomenar les variables. Per exemple:

$$
    λ x . λ y . xy ⟶_a λ z . λ y . zy ⟶_a λ z . λ t . zt
$$

Aleshores l'exemple del $\text{TWICE}$ el podríem escriure:

$$
\begin{align}
\text{TWICE} ~ \text{TWICE}
~=~& (λf.λx.f(f x)) \text{TWICE} \\\\
~⟶_β~& (λx.\text{TWICE}(\text{TWICE} ~ x)) \\\\
~=~& (λx.\text{TWICE}(λf.λx.f(f x)) x) \\\\
~⟶_a~& (λx.\text{TWICE}((λf.λy.f(f y)) x) \\\\
~⟶_b~& (λx.\text{TWICE}((λy.x(x y))
\end{align}
$$
---
#  Ordres de reducció

Donada una λ-expressió, pot haver més d'un lloc on es pot aplicar  β-reducció, per exemple:

$$
(1)   ~~(λ x .x((λ z .zz)x)) t ⟶ t((λ z .zz)t) ⟶ t(tt)
$$

però també:

$$
(2)    ~~(λ x .x((λ z .zz)x)) t \longrightarrow (λ x .x(xx)) t ⟶ t(tt)
$$

Hi ha dues formes estàndard d'avaluar una λ-expressió:

- Avaluació en **ordre normal**: s'aplica l'estratègia **left-most outer-most**: Reduir la λ sintàcticament més a l'esquerra (1).

- Avaluació en  **ordre aplicatiu**: s'aplica l'estratègia **left-most inner-most**: Reduir la λ més a l'esquerra de les que són més endins (2).

---


#  Ordres de reducció

En principi, podríem pensar que no importa l'ordre d'avaluació que utilitzem, perquè la  β-reducció és  **confluent**:

Si $t → \dots → t_1$ i $t → \dots → t_2$ llavors<br>
$t_1 → \dots → t_3$ i $t_2 → \dots → t_3$

Tanmateix, si una expressió té una forma normal, aleshores la reducció en ordre normal la trobarà, però no necessàriament la reducció en ordre aplicatiu.

Per exemple, en ordre normal tenim:

$$(λx.a) ((λy.yy) (λz.zz)) ⟶ a$$

però en ordre aplicatiu:

$$(λx.a) ((λy.yy) (λz.zz)) ⟶ (λx.a) ((λz.zz) (λz.zz)) ⟶ ... $$



---

# Macros

En el λ-càlcul, les funcions no reben noms.

Per facilitar-ne la escriptura, utilitzarem **macros** que representen
funcions i les expandirem quan calgui, com vam fer a les transparències anteriors amb $\text{TWICE}$.

Les macros també es diuen **combinadors**.

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

S'utilitza el **combinador Y**, anomenat *combinador paradoxal* o *combinador de punt fixe*, amb la següent proprietat:

$$
\text{Y} \text{R} \ ≡\ \text{R}(\text{Y} \text{R})
$$

Concretament, Y es defineix així:

$$
  \text{Y} \ ≡\ λy. (λx.y(xx))(λx.y(xx))
$$

Com podem veure:

$$
  \begin{align}
    \text{Y} \ \text{R} &\ ≡ \  (λy . (λx.y(xx))(λx.y(xx)))\text{R} \\\\
    &\ ≡ \  (λx.\text{R}(xx))(λx.\text{R}(xx)) \\\\
    &\ ≡ \  \text{R}((λx.\text{R}(xx))(λx.\text{R}(xx))) \\\\
    &\ ≡ \  \text{R}(\text{Y} \text{R})  &\text{(per la línia anterior)} \\\\
  \end{align}
$$

---

# Recursivitat en λ-càlcul

El combinador Y ens permet definir la funció factorial.

Sigui H la funció següent:

$$λf.λn.\text{IF} (n=0) ~ 1 ~  (n × (f ~ (n-1)))$$

podem veure com Y H funciona com el factorial:

<br>

$$
Y H 1 ⟶ H(Y H) 1 =  λf.λn.\text{IF} (n=0) 1 (n × (f  (n-1))) (Y H) 1 ⟶
$$

$$
λn.IF (n=0) 1 (n × (Y H (n-1))) 1 ⟶ IF (1=0) 1 (1 \times (Y H (1-1))) ⟶
$$

$$
1 × (Y H (1-1))) ⟶ Y H 0 ⟶ H (Y H) 0  =
$$

$$
λf.λn.\text{IF} (n=0) 1 (n × (f (n-1))) (Y H) 0 ⟶
$$

$$
λn.\text{IF} (n=0) 1 (n × (Y H (n-1))) 0 ⟶ \text{IF} (0=0) 1 (0 × (Y H (0-1))) ⟶ 1
$$

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

A diferència de les màquines de Turing que són un model matemàtic d'una
màquina *hardware* imperativa, el λ-càlcul només utilitza reescriptura
i és un model matemàtic més *software* i funcional.

