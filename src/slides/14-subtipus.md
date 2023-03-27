
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

`s` és subtipus de `t` si tots els valors d'`s` són valors de `t`.

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


---

# Programació orientada a objectes


**Reutilització de codi:** Els objectes creats poden ser reutilitzats en altres aplicacions. ➡️ Estalvi de temps i diners en el desenvolupament de noves aplicacions.

**Modularitat:** El codi es divideix en mòduls i objectes independents entre si. ➡️ Facilita la organització del codi i la seva mantenibilitat.

**Facilitat de manteniment:** Els objectes són independents i poden ser modificats sense afectar gaire la resta de l'aplicació. ➡️ Facilita detecció i correcció d'errors en el codi.

**Ampliació de funcionalitats:** És fàcil afegir noves funcionalitats a través de la creació de nous objectes o la modificació dels existents.

**Abstracció:** Els objectes són una representació abstracta dels conceptes a tractar. ➡️ Millor comprensió del codi i la facilitat de treballar amb conceptes complexos.

**Encapsulació:** Les seves dades són ocultes a altres objectes.  ➡️ Millor seguretat i menys errors involuntaris en el codi.

**Herència:** La POO permet la creació de classes que hereten les propietats i funcions d'altres classes. ➡️ Millor organització i reutilització del codi.


---

# Herència i subclasses

L'herència i la relació de subclasses tenen per objectiu:

- Estructurar millor el codi.

- Reaprofitar millor el codi.

- Simplificar el disseny.

---

# Exemple:

```typescript
class Empleat {...}
function sou(e: Empleat): number {...}

e = new Empleat()
s = sou(e)
```

<br>

.cols5050[
.col1[
Amb programació "clàssica":

```typescript
function sou(e: Empleat): number {
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

```typescript
class Empleat {
    function sou(): number {...}
    ...
}

class Venedor extends Empleat {
    function sou(): number {...}
    ...
}

class Comptable extends Empleat {
    function sou(): number {...}
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

    ```typescript
    function escriu(e: Empleat) {
        print(e.nom, e.sou())
    }

    escriu(new Venedor())
    escriu(new Comptable())
    ```




---

# Promesa de l'OO:

Si es canvia l'estructura salarial:

- En programació "clàssica" cal refer del tot la funció `sou()` (i potser més operacions).

- En programació "OO", es canvien les classes i el mètode `sou()` d'algunes.


---

# Comprovació i inferència amb subtipus

- Si `e :: s` i `s <= t`, llavors `e :: t`.

- Si `e :: s`, `s <= t` i `f :: t -> t'`, llavors `f e :: t'`.


<br>

La notació `e :: t` indica que `e` és de tipus de `t`.<br>
La notació `s ≤ t` indica que `s` és un subtipus de `t`.



---

# Comprovació i inferència amb subtipus

- Si `e :: s` i `s <= t`, llavors `e :: t`.

- Si `e :: s`, `s <= t` i `f :: t -> t'`, llavors `f e :: t'`.

Per tant,

- Si `e :: s`, `s <= t` i `f :: t -> t`, llavors `f e :: t`.

Però no podem assegurar que `f e :: s`! Per exemple, si tenim

- `x :: parell`
- `parell <= int`
- `function es_positiu(int): boolean`
- `function incrementa(int): int`

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

    ```typescript
    class Animal
    class Gos extends Animal
    class Gat extends Animal

    function f(animals: List<Animal>) {
        animals.push(new Gat())     // perquè no?
    }

    gossos: List<Gos> = ...
    f(gossos)                      // ai, ai
    ```

---


# El cas dels constructors de tipus

- Si `s ≤ t`, podem assegurar que `List t ≤ List s`?

--

    No!

    ```typescript
    class Animal
    class Gos extends Animal {
        function borda() {...}
    }
    class Gat extends Animal;

    function f(gossos: List<Gos>) {
        for (var gos: Gos of gossos) gos.borda()
    }

    List<Animal> animals = [new Gos(), new Animal, new Gat()]
    f(animals)                  // alguns animals no borden 🙀
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

Resolució de conflictes:

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

Resolució de conflictes:

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


