
class: center, middle


Llenguatges de Programació

# Subtipus, herència i programació orientada a objectes

Fernando Orejas, Jordi Petit

<br/>

![:height 10em](img/subtipus.png)

<br/>

Universitat Politècnica de Catalunya, 2022


---

# Subtipus, herència i programació OO

- [Transparències Subtipos y Herencia](pdf/subtipus/subtipos.pdf)

- [Programes OO](zip/oo.zip)

---

# Noció de subtipus

**Definició 1:**

`s` és subtipus de `t` si tots els valors de `s` són valors d'`t`.

<br>


**Exemple en Pearl:**

```
subset Evens of Int where {$_ % 2 == 0}
```

<br>

➡️ Aquesta mena de subtipus no són habituals en els LPs.

---

# Noció de subtipus

**Definició 2:**

`s` és subtipus de `t` si qualsevol funció que es pot aplicar a un objecte de tipus `t` es pot aplicar a un objecte de tipus `s`.

<br>


**Exemple en C++:**

```c++
class Forma;
class Quadrat: Forma;           // Forma és subtipus de Forma

double area(const Forma& f);

Forma f;
area(f);     ✅
Quadrat q;
area(q);     ✅
```

<br>

➡️ Aquesta és la definició en què es basa la programació orientada a objectes.


---

# Noció de subtipus

**Definició 2':**

`s` és subtipus de `t` si en tot context que es pot usar un objecte de tipus `t` es pot usar un objecte de tipus `s`.

<br>


➡️ Aquesta és la definició en què (a vegades es diu que) es basa la programació orientada a objectes.


---

# Noció de subtipus

Les definicions 1 i 2 no són equivalents:

- Si `s` és subtipus de `t` segons la Def.&nbsp;1, <br>llavors també ho és d'acord amb la Def.&nbsp;2.

- La inversa, en general, no és certa. És a dir, si `s` és
subtipus de `t` d'acord amb la Def.&nbsp;2, llavors no té
perquè ser-ho d'acord amb la Def.&nbsp;1.

    Exemple:

    ```c++
    class T {
        int x;
    };

    class S : T {
        int y;
    }
    ```

    Els valors de `S` no es poden veure com un subconjunt dels valors de `T`, ja que tenen més elements.



---

# Noció de subtipus

**Definició 3:**

`s` és subtipus de `t` si tots els objectes de `s` es poden convertir implícitament a objectes de `t` (*type casting* o coherció). 
<br>


➡️ Aquesta és la definició en què (a vegades es diu que) es basa la programació orientada a objectes.

---

# Herència i subclasses

L'herència i la relació de subclasses tenen per objectiu:

- Estructurar millor el codi.

- Reaprofitar millor el codi.

- Simplificar el disseny.

---

# Exemple:

```c++
class Empleat {...}
double sou(Empleat e) {...}

Empleat e;
double s = sou(e);
```

<br>

.cols5050[
.col1[
Amb programació "clàssica":

```c++
double sou(Empleat e) {
    if (e.es_venedor()) {
        ...
    } else if (e.es_contable()) {
        ...
    } else if (e.es_executiu()) {
        ...
    } 
}
```
]
.col2[
Amb programació "OO":

```c++
class Empleat {
    double sou();
    ...
}

class Venedor: Empleat {
    double sou() {...};
    ...
}

class Contable: Empleat {
    double sou() {...};
    ...
}
```
]
]


---

# Herència i subclasses

- A cada subclasse es poden redefinir operacions de la classe base.

- A cada subclasse es poden definir noves operacions.

- L'operació que es crida depèn del (sub)tipus de l'empleat en temps d'execució (*late binding*). 

    ```c++
    void escriu(Empleat e) {
        print(e.nom, e.sou());
    }

    escriu(new Venedor());
    escriu(new Contable());
    ```




---

# Promesa de l'OO:

Si es canvia l'estructura salarial:

- En programació "clàssica" cal refer del tot la funció `sou()` (i potser més operacions).

- En programació "OO", es canvien les classes i el mètode `sou()` d'algunes.


---

# Comprobació i inferència amb subtipus

- Si `e :: s` i `s <= t`, llavors `e :: t`.

- Si `e :: s`, `s <= t` i `f :: t -> t'`, llavors `f e :: t'`.


<br>

La notació `e :: t` indica que `e` és de tipus de `t`.<br>
La notació `s ≤ t` indica que `s` és un subtipus de `t`.



---

# Comprobació i inferència amb subtipus

- Si `e :: s` i `s <= t`, llavors `e :: t`.

- Si `e :: s`, `s <= t` i `f :: t -> t'`, llavors `f e :: t'`.

Per tant,

- Si `e :: s`, `s <= t` i `f :: t -> t`, llavors `f e :: t`.

Però no podem assegurar que `f e :: s`! Per exemple, si tenim

- `x :: parell`
- `parell <= int`
- `bool es_positiu(int);`
- `int incrementa(int);`

Llavors

- `es_positiu(x) :: bool`   ✅
- `incrementa(x) :: int`    ✅
- `incrementa(x) :: parell` ❌



---

# El cas de l'assignació

- Si `x :: t` i `e :: s` i `s <= t`, llavors `x = e` és una assignació correcta.

- Si `x :: s` i `e :: t` i `s <= t`, llavors `x = e` és una assignació incorrecta.

Exemples:

- Si `x :: int` i `e :: parell` , `x = e` no té problema.

- Si `x :: parell` i `e :: int` , `x = e` crearia un problema: `e` potser no és parell.



---

# El cas de les funcions

- Si `s <= t` i `s' <= t'`, llavors `(s -> s') <= (t -> t')`?

--

    No!

    Suposem que `f :: parell -> parell` i que `g :: int -> int`.

    Si `(s -> s') <= (t -> t')`, llavors sempre que puguem usar `g`, podem usar `f` al seu lloc. Com que `g 5` és legal, `f 5` també seria legal. Però `f` espera un `parell` i 5 no ho és.


--

- En canvi, si `s <= t` i `s' <= t'`, llavors `(t -> s') <= (s -> t')` és correcte.


---

# El cas dels constructors de tipus

- Si `s ≤ t`, podem assegurar que `List s ≤ List t`?

--

    No!

    ```c++
    class Animal;
    class Gos: Animal;
    class Gat: Animal;

    void f(List Animal animals) {
        animals.push(new Gat());     // perquè no?
    }

    List Gos gossos = ...;
    f(gossos);                      // ai, ai
    ```

---


# El cas dels constructors de tipus

- Si `s ≤ t`, podem assegurar que `List t ≤ List s`?

--

    No!

    ```c++
    class Animal;
    class Gos: Animal {
        void borda();
    }
    class Gat: Animal;

    void f(List Gos gossos) {
        for (Gos gos: gossos) gos.borda();
    }

    List Animal animals = [new Gos(), new Animal, new Gat()];
    f(animals);                  // alguns animals no borden
    ```


---

# Variancia de constructors de tipus

Sigui `C` un constructor de tipus i sigui `s <= t`.

- Si `C s <= C t`, llavors `C` és **covariant**.

- Si `C t <= C s`, llavors `C` és **contravariant**.

- Si no és covariant ni contravariant, llavors `C` és **invariant**.


<br>
--
Hem vist doncs que:

- El constructor `->` és contravariant amb el primer paràmetre.

- El constructor `->` és covariant amb el segon paràmetre.

- El constructor `List` és invariant.



---

# Subclasses i herència en Python, C++ i Java

**Herència simple:** Una classe només pot ser subclasse d'una altra classe.

**Herència múltiple:** Una classe pot ser subclasse de més d'una classe.

<br>
<center>
![:height 16em](img/tipus-herencia.png)
</center>


---

# Herència simple

<center>
![:height 10em](img/herencia-simple.svg)
</center>

---

# Herència múltiple

<br>
<center>
![:height 10em](img/herencia-multiple.svg)
</center>


<br>
<br>
<center>
![:height 10em](img/vaixell-amb-rodes.png)
</center>



---

# Declaració de subclasses en C++

```c++
class Empleat { ... };
class Venedor: Empleat { ... };
```

O també:

```c++
class Venedor: public    Empleat { ... };
class Venedor: protected Empleat { ... };
class Venedor: private   Empleat { ... };
```

Amb herència múltiple:

```c++
class Cotxe { ... };
class Vaixell { ... };
class Hibrid: public Cotxe, public Vaixell { ... };
```

Resolució de confictes:

```c++
hibrid.Cotxe::girar(90);
hibrid.Vaixell::girar(90);
```

---

# Declaració de subclasses en Java

```java
class Empleat { ... }
class Venedor extends Empleat { ... }
```

En Java no hi herència múltiple amb classes, però sí amb interfícies:

```java
Interface Cotxe { ... }
Interface Vaixell { ... }
class Hibrid implements Cotxe, Vaixell { ... }
```

---

# Declaració de subclasses en Python


```python
class Empleat: ...
class Venedor(Empleat): ...
```

Amb herència múltiple:

```python
class Hibrid(Cotxe, Vaixell): ...
```

Resolució de confictes:

- Quan a les dues classes hi ha mètodes amb el mateix nom, s'hereta el de la primera.


---

# Tipus en Python

En Python, el tipus dels objectes és dinàmic.

```python
>>> e = Empleat()
>>> v = Venedor()
>>> type(e)
<class '__main__.Empleat'>
>>> type(v)
<class '__main__.Venedor'>
>>> v = e           # legal (igual que v = 66)
>>> type(v)
<class '__main__.Empleat'>
```

---

# Tipus en Java

En Java, els objectes tenen un tipus estàtic i un tipus dinàmic:

```java
Empleat e;
e = new Venedor();
```

- El tipus estàtic d'`e` és `Empleat`.
- El tipus dinàmic d'`e` és `Venedor`.

El tipus dinàmic ha de ser un subtipus del tipus estàtic.


```java
Venedor v;
v = new Empleat();    ❌
```


---

# Tipus en C++

En C++, els objectes estàtics tenen un tipus estàtic.

```c++
Empleat e = Venedor();
```

- El tipus estàtic d'`e` és `Empleat`: quan se li assigna un `Venedor` es perd la part extra.

Els objectes dinàmics (punters i referències) tenen un tipus estàtic i un tipus dinàmic.

```c++
Empleat* e = new Venedor();
```

- El tipus estàtic de `*e` és `Empleat`.
- El tipus dinàmic de `*e` és `Venedor`.


```c++
Empleat& e = Venedor();
```

- El tipus estàtic d'`e` és referència a `Empleat`.
- El tipus dinàmic d'`e` és referència a `Venedor`.


El tipus dinàmic ha de ser un subtipus del tipus estàtic.


