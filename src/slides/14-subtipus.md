
class: center, middle


Llenguatges de Programació

# POO, herència i subtipus 

Fernando Orejas, Jordi Petit

<br/>

![:height 10em](img/subtipus.png)

<br/>

Universitat Politècnica de Catalunya, 2023



---

# Programació orientada a objectes

Elements principals de la PPO:

- Reutilització de codi

- Modularitat

- Facilitat de manteniment

- Ampliació de funcionalitats

- Abstracció

- Encapsulació

- Herència

---

# Herència i subclasses

L'herència i la relació de subclasses tenen per objectiu:

- Estructurar millor el codi.

- Reaprofitar millor el codi.

- Simplificar el disseny.

---

# Herència i subclasses

Exemple:

```typescript
class Empleat {...}

function sou(e: Empleat): number {...}

e = new Empleat()
s = sou(e)
```


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
Amb POO:

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

A cada subclasse es poden redefinir operacions de la classe base.

```typescript
class Empleat {
    function sou(): number {...}
}

class Venedor extends Empleat {
    function sou(): number {...}
}

class Comptable extends Empleat {
    function sou(): number {...}
}
```


---

# Herència i subclasses

A cada subclasse es poden definir noves operacions.


```typescript
class Empleat {
    function sou(): number {...}
}

class Venedor extends Empleat {
    function comissio(): number {...}
}

class Comptable extends Empleat {
    function fulls_de_calcul(): FullCalcul[] {...}
}
```


---

# Herència i subclasses

L'operació que es crida depèn de la (sub)classe de l'objecte en temps d'execució (*late binding*). 

```typescript
function escriure(e: Empleat) {
    print(e.nom, e.sou())
}

Empleat e = new Empleat()
Empleat v = new Venedor()
Empleta c = new Comptable()

escriure(e)         // usa el sou() d'Empleat
escriure(v)         // usa el sou() de Venedor
escriure(c)         // usa el sou() de Comptable
```


---

# Herència i subclasses


<br>
<center>
![:height 20em](img/tipus-herencia.png)
</center>


---

# Herència simple

Una classe només pot ser subclasse d'una altra classe.

<center>
![:height 10em](img/herencia-simple.svg)
</center>

---

# Herència múltiple

Una classe pot ser subclasse de més d'una classe.

<center>
![:height 10em](img/herencia-multiple.svg)
</center>

<br>

![:height 8em](img/vaixell-amb-rodes.png)

.sm[
📖  Vaixell amb Rodes d'en J. Petit: [Oasi #25](https://upcommons.upc.edu/handle/2117/127184)
]

---

# Promesa de l'OO

Si es canvia l'estructura salarial:

- En programació "clàssica" cal refer del tot la funció `sou()` (i potser més operacions).

- En programació "OO", es canvien les classes i el mètode `sou()` d'algunes.


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
interface Cotxe { ... }

interface Vaixell { ... }

class Hibrid implements Cotxe, Vaixell { ... }
```

Les interfícies de Java són com les classes de Haskell (quin embolic!).

---

# Declaració de subclasses en Python


```python
class Empleat: 
    ...

class Venedor(Empleat): 
    ...
```

Amb herència múltiple:

```python
class Hibrid(Cotxe, Vaixell): 
    ...
```

Resolució de conflictes:

- Quan a les dues classes hi ha mètodes amb el mateix nom, s'hereta el de la primera.


---

# Tipatge estàtic i tipatge dinàmic

**Tipatge estàtic**: La verificació de tipus que es realitza durant la compilació del codi. 

- El compilador comprova si les variables s'utilitzen de manera coherent amb el seu tipus  durant la compilació del codi. 

- Si hi ha un error de tipus, el compilador no genera codi. 

- Ajuda a detectar i corregir errors abans d'executar el codi, evitant problemes durant l'execució.


**Tipatge dinàmic**: La verificació de tipus que es realitza durant l'execució del codi. 

- El tipus de la variable es determina en temps d'execució

- Si hi ha un error de tipus, aquest no es detectarà fins que el codi s'executi.



---

# Late binding (vinculació)

El **late binding** és el procés pel qual es determina (en temps d'execució) quin mètode cal cridar en funció del tipus dinàmic d'un objecte.

.cols5050[
.col1[
```typescript
class Animal {
    parlar() {
        print("grr")
    }
}

class Gat extends Animal {
    parlar() {
        print("mèu")
    }
}

class Gos extends Animal {
    parlar() {
        print("bub")
    }
}

function parlarN(animal: Animal, n: number) {
    repeat (n) {
        animal.parlar()    ⬅️ late binding
    }
}
```
]
.col2[
```typescript
animal: Animal = new Animal()
gat: Gat = new Gat()
gos: Gos = new Gos()

animal.parlar()      👉 grr            
gat.parlar()         👉 mèu
gos.parlar()         👉 bub

parlarN(animal, 3)   👉 grr grr grr
parlarN(gat, 3)      👉 mèu mèu mèu
parlarN(gos, 3)      👉 bub bub bub
```
]]



---

# Vinculació en Java

En Java, els objectes tenen un tipus estàtic i un tipus dinàmic:

```java
Animal animal;
animal = new Gat();
```

- El tipus estàtic d'`animal` és `Animal`.

- El tipus dinàmic d'`animal` és `Gat`.

El tipus dinàmic ha de ser un subtipus del tipus estàtic.

En temps de compilació, es comprova que les crides es puguin aplicar al tipus estàtic.

En temps d'execució, la vinculació es fa en funció del tipus dinàmic.


---

# Vinculació en Java

Donada una declaració `C c;` i una operació `c.m()`:

- En temps de compilació, es verifica que la classe C tingui el mètode `m` (directament o a través d'herència).

- En temps d'execució, es crida al `m` de la classe corresponent al tipus dinàmic de `c` o de la seva superclasse més propera que l'implementi.

---

# Vinculació en Java


.cols5050[
.col1[
```java
class Animal {
    void parlar() {
        print("grr");
    }
}

class Gat extends Animal {
    void parlar() {
        print("mèu");
    }
    void filar() {
        print("rum-rum");
    }
}

void parlarN(Animal animal, int n) {
    for (int i = 0; i < n; ++i) {
        animal.parlar(); 
    }
}
```
]
.col2[
```java
Animal animal = new Animal();
Gat gat = new Gat();

animal.parlar();       👉 grr            
gat.parlar();          👉 mèu

parlarN(animal, 3);    👉 grr grr grr
parlarN(gat, 3);       👉 mèu mèu mèu

gat.filar();      👉 rum-rum
animal.filar()    ❌ error compilació
```
]]



---

# Vinculació en Python

En Python, el tipus dels objectes és dinàmic.

```python
>>> e = Empleat()
>>> v = Venedor()
>>> type(e)
<class '__main__.Empleat'>
>>> type(v)
<class '__main__.Venedor'>
>>> v = e     
>>> type(v)
<class '__main__.Empleat'>
```


Donada una operació `c.m()`:

- En temps d'execució, es crida al `m` de la classe corresponent al tipus dinàmic de `c` o de la seva superclasse més propera que l'implementi.


---

# Vinculació en Python


.cols5050[
.col1[
```python
class Animal:
    def parlar(self):
        print("grr")

class Gat(Animal):
    def parlar(self):
        print("mèu")
    def filar(self):
        print("rum-rum")

def parlarN(animal, n):
   n * [animal.parlar()]
```
]
.col2[
```python
animal = Animal()
gat = Gat()

animal.parlar()       👉 grr            
gat.parlar()          👉 mèu

parlarN(animal, 3)    👉 grr grr grr
parlarN(gat, 3)       👉 mèu mèu mèu

gat.filar();     👉 rum-rum
animal.filar()   ❌ error execució
```
]]



---

# Vinculació en C++

En C++, els objectes estàtics tenen un tipus estàtic.

```c++
Animal a = Gat();
```

- El tipus estàtic d'`a` és `Animal`: quan se li assigna un `Gat` es perd la part extra.
- (Recordeu: El pas per còpia fa una assignació)

Els objectes dinàmics (punters i referències) tenen un tipus estàtic i un tipus dinàmic.

```c++
Animal* a = new Gat();
```

- El tipus estàtic d'`a` és punter a `Animal`.
- El tipus dinàmic d'`a` és punter a `Gat`.


```c++
Animal& a = Gat();
```

- El tipus estàtic d'`a` és referència a `Animal`.
- El tipus dinàmic d'`a` és referència a `Gat`.


---

# Vinculació en C++

Per a objectes estàtics, la vinculació és estàtica.

El tipus dinàmic ha de ser un subtipus del tipus estàtic.

En temps de compilació, es comprova que les crides es puguin aplicar al tipus estàtic.

En temps d'execució, la vinculació es fa en funció del tipus dinàmic, sobre els mètodes marcats `virtual`.


---

# Vinculació en C++

.cols5050[
.col1[
```c++
class Animal {
    virtual void parlar() {
        print("grr");
    }
}

class Gat: Animal {
    virtual void parlar() {
        print("mèu");
    }
    virtual void filar() {
        print("rum-rum");
    }
}

void parlarN(Animal animal, n: int) {
    for (int i = 0; i <n; ++i) {
        animal.parlar(); 
    }
}
```
]
.col2[
```c++
Animal animal;
Gat gat;

animal.parlar();       👉 grr            
gat.parlar();          👉 mèu

parlarN(animal, 3);    👉 grr grr grr
parlarN(gat, 3);       👉 grr grr grr *️⃣

gat.filar();      👉 rum-rum
animal.filar()    ❌ error compilació
```

*️⃣ Com que `parlarN` reb un `Animal` per còpia, al cridar `parlarN(gat, 3)` es perd la part de gat.

]]


---

# Vinculació en C++

.cols5050[
.col1[
```c++
class Animal {
    virtual void parlar() {
        print("grr");
    }
}

class Gat: Animal {
    virtual void parlar() {
        print("mèu");
    }
    virtual void filar() {
        print("rum-rum");
    }
}

void parlarN(Animal* animal, n: int) {
    for (int i = 0; i <n; ++i) {
        animal->parlar(); 
    }
}
```
]
.col2[
```c++
Animal animal;
Gat gat;

animal.parlar();       👉 grr            
gat.parlar();          👉 mèu

parlarN(animal, 3);    👉 grr grr grr
parlarN(&gat, 3);      👉 mèu mèu mèu *️⃣

gat.filar();      👉 rum-rum
animal.filar()    ❌ error compilació
```

*️⃣ Com que `parlarN` reb un punter a `Animal`, al cridar `parlarN(gat, 3)` el tipus dinàmic continua sent `Gat`.

]]

---

# Vinculació en C++

.cols5050[
.col1[
```c++
class Animal {
    virtual void parlar() {
        print("grr");
    }
}

class Gat: Animal {
    virtual void parlar() {
        print("mèu");
    }
    virtual void filar() {
        print("rum-rum");
    }
}

void parlarN(Animal& animal, n: int) {
    for (int i = 0; i <n; ++i) {
        animal.parlar(); 
    }
}
```
]
.col2[
```c++
Animal animal;
Gat gat;

animal.parlar();       👉 grr            
gat.parlar();          👉 mèu

parlarN(animal, 3);    👉 grr grr grr
parlarN(gat, 3);       👉 mèu mèu mèu *️⃣

gat.filar();      👉 rum-rum
animal.filar()    ❌ error compilació
```

*️⃣ Com que `parlarN` reb un `Animal` per referència, al cridar `parlarN(gat, 3)` el tipus dinàmic continua sent `Gat`.

]]




---

# Vinculació en C++

.cols5050[
.col1[
```c++
class Animal {
    void parlar() {
        print("grr");
    }
}

class Gat: Animal {
    void parlar() {
        print("mèu");
    }
}

void parlarN(Animal& animal, n: int) {
    for (int i = 0; i <n; ++i) {
        animal.parlar(); 
    }
}
```
]
.col2[
```c++
Animal animal;
Gat gat;

parlarN(animal, 3);    👉 grr grr grr
parlarN(gat, 3);       👉 grr grr grr *️⃣
```

*️⃣ Com que `parlar` no és `virtual`, `parlarN` no fa late binding.

]]




---

# Visibilitat dels membres

Els LPs limiten la visibilitat dels membres (atributs i mètodes) de les classes:

Ajuda a:

- Encapsular els objectes en POO.

- Definir una interfície clara i independent de la implementació.

- Prevenir errors en el codi.


---

# Visibilitat en C++

Els **especificadors d'accés** defineixen la visibilitat dels membres d'una classe.

```c++
class Classe {
    public:
        ...
    protected:
        ...
    private:
        ...
};
```

- **public**: els membres són visibles des de fora de la classe

- **privat**: no es pot accedir (ni veure) als membres des de fora de la classe

- **protegit**: no es pot accedir als membres des de fora de la classe, <br>però s'hi pot accedir des de classes heretades. 

<br>

.cols5050[
.col1[
```c++
class Classe {
    // privat per defecte
};
```
]
.col2[
```c++
struct Estructura {
    // public per defecte
};
```
]]



---

# Visibilitat en C++

Els **especificadors d'accés** també defineixen la visibilitat dels membres quan es deriva una classe:

```c++
class SubClasse: public Classe { ... };
```

- Els membres protegits de `Classe` són membres protegits de `SubClasse`.<br>
- Els membres públics de `Classe` són membres públics de `SubClasse`.


```c++
class SubClasse: protected Classe { ... };
```

- Els membres protegits i públics de `Classe` són membres protegits de `SubClasse`.


```c++
class SubClasse: private Classe { ... };
class SubClasse: Classe { ... };            // 'private' per defecte en classes
```

- Els membres públics i protegits de `Classe` són membres privats de `SubClasse`.


---

# Visibilitat en C++

```c++
class A {
    public:
       int x;
    protected:
       int y;
    private:
       int z;
};

class B : public A {
    // x és public
    // y és protegit
    // z no és visible des de B
};

class C : protected A {
    // x és protegit
    // y és protegit
    // z no és visible des de C
};

class D : private A {           
    // x és privat
    // y és privat
    // z no és visible des de D
};
```



---

# Visibilitat en Java

Els **nivells d'accés** defineixen la visibilitat dels membres (atributs i mètodes) d'una classe.

```java
class Classe {
    public ...
    protected ...
    private ...
    ...
}
```

- **public**: aquest membre és accessible des de fora de la classe

- **privat**: no es pot accedir (ni veure) en aquest membre des de fora de la classe

- **protegit**: no es pot accedir en aquest membre des de fora de la classe, <br>però s'hi pot accedir des de classes heretades. 

- *res*: només el codi en el `package` actual pot accedir aquest membre. 




---

# Visibilitat en Java

En Java no es pot limitar la visibilitat heretant classes (sempre és "`public`").

```java
class SubClasse extends Classe { ... }
```

- Els membres protegits de `Classe` són membres protegits de `SubClasse`.<br>
- Els membres públics de `Classe` són membres públics de `SubClasse`.

---

# Visibilitat en Java

.cols5050[
.col1[
```java
package p;

public class A {
    public int a;
    protected int b;
    private int c;
    int d;
}

class B extends A {
    // a és visible des de B
    // b és visible des de B
    // c no és visible des de B
    // d és visible des de B
}

// A.a és visible des de p
// A.b és visible des de p
// A.c no és visible des de p
// A.d és visible des de p
```
]
.col2[
```java
package q;

import p.*;






class C extends p.A {
    // a és visible des de C
    // b és visible des de C
    // c no és visible des de C
    // d no és visible des de C
}

// A.a és visible des de q
// A.b no és visible des de q
// A.c no és visible des de q
// A.d no és visible des de q
```
]]


---

# Visibilitat en Python

En Python no hi ha restriccions de visibilitat.

Tot és visible.

Per *convenció*, els membres que comencen per `_` (però no per `__`) són privats.




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
        animals.push(new Gat())             // perquè no?
    }

    gossos: List<Gos> = ...
    f(gossos)                              // ai, ai
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


