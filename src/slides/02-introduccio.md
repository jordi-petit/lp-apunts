q
class: center, middle


Llenguatges de Programació

# Conceptes bàsics

Albert Rubio, Jordi Petit, Fernando Orejas

<br/>

![:height 10em](img/programming-languages-cloud.png)

<br/>

Universitat Politècnica de Catalunya, 2021

---

# Introducció

Un **llenguatge de programació** (LP) és un llenguatge formal utilitzat per
controlar el comportament d'un computador tot implementant un algorisme.

Cada llenguatge té una sèrie de regles estrictes:

- **Regles sintàctiques**: descriuen l'estructura dels programes vàlids.

- **Regles semàntiques**: descriuen el seu significat.

Cada llenguatge té (hauria de tenir) una especificació:

- un document estàndard (Ansi C) o
- una implementació de referència (CPython).


---

# Característiques bàsiques d'un LP

- Tipus de dades: amb quins dades i objectes treballem.

- Sistema de tipus.

- Control de seqüència: en quin ordre s'executen les operacions.

- Control de dades. Com s'accedeix a les dades i als objectes.

- Entrada / Sortida.

---

# Qualitats dels llenguatges de programació

- Llegibilitat

- Eficiència

- Fiabilitat

- Expressivitat

- Simplicitat

- Nivell d'abstracció

- Adequació als problemes a tractar

- Facilitat d'ús

- Ortogonalitat



---

# Història

[O'Reilly History of Programming Languages](https://www.cs.toronto.edu/~gpenn/csc324/PLhistory.pdf)

.center[![](img/programming-history.png)]

.center.xs[Font: O'Reilly]




---

class: split-6040

# Història: Orígens

## Tauletes babilòniques (2000ac)

.cols6040[
.col1[
.xs[
A [rectangular] cistern.

The height is 3, 20, and a volume of 27, 46, 40 has been excavated.
The length exceeds the width by 50.
You should take the reciprocal of the height, 3, 20, obtaining 18.
Multiply this by the volume, 27, 46, 40, obtaining 8, 20.
Take half of 50 and square it, obtaining 10, 25.
Add 8, 20, and you get 8, 30, 25
The square root is 2, 55.
Make two copies of this, adding [25] to the one and subtracting from the other.
You find that 3, 20 [i.e., 3 1/3] is the length and 2, 30 [i.e., 2 1/2] is the width.

This is the procedure.

<br>

[![:height 2em](img/icones/youtube.png)](https://www.youtube.com/watch?v=Rx-5dCXx1SI)

.xxs[Vídeo: Math whizzes of ancient Babylon figured out forerunner of calculus]

]]
.col2[
![:height 20em](img/babilonic-tablet.png)
]
]


*[Ancient Babylonian Algorithms](http://steiner.math.nthu.edu.tw/disk5/js/computer/1.pdf)*. D.E. Knuth, Communications ACM 1972.



---

# Història: Orígens

## Teler de Jacquard (1804)


![:height 15em](img/jacquard1.png)
.sepimg[]
![:height 15em](img/jacquard2.png)

.xxs[Fotos: http://www.revolutionfabrics.com/blog/2018/9/26/the-jacquard-loom-and-the-binary-code]

[![:height 2em](img/icones/youtube.png)](https://www.youtube.com/watch?v=MQzpLLhN0fY)

.xxs[Vídeo: How an 1803 Jacquard Loom Lead to Computer Technology]




---

# Història: Orígens

## Màquina analítica de Charles Babbage (1842)

Es considera que Ada Lovelace és la primera programadora.

![:height 10em](img/differential-engine.png)
.sepimg[]
![:height 10em](img/charles-babbage.png)
.sepimg[]
![:height 10em](img/ada-lovelace.png)

.xxs[Fotos: Domini públic]

<br>

[![:height 2em](img/icones/youtube.png)](https://www.youtube.com/watch?v=lLOAuYv87uU)

.xxs[Vídeo:  Ada Lovelace, The World’s First Computer Nerd?]


---

# Història: Ensabladors

Kathleen Booth va escriure el
primer llenguatge ensamblador (per un ordinador ARC al 1947).

![:height 10em](img/kathleen-booth.png)
.sepimg[]
![:height 10em](img/assembly-code.png)

.xxs[Fotos: Domini públic]

<br>


.xxxl[[📖](https://hackaday.com/2018/08/21/kathleen-booth-assembling-early-computers-while-inventing-assembly/)]

.xxs[Lectura: Kathleen Booth, Assembling Early Computers While Inventing Assembly]

---

# Història: Plankalkül

Primer LP d'alt nivell dissenyat per Konrad Zuse (1942-1945) pel seu
ordinador a relés Z4. Implementat al 1990.

![:height 10em](img/konrad-suze.png)
.sepimg[]
![:height 10em](img/computer-z4.png)
.sepimg[]
![:height 10em](img/plankalkul.png)

.xxs[Fotos: Domini públic]

---

# Història: Fortran

**FORmula TRANslator (1954-1957)**.
Desenvolupat per John Bakus a IBM per a computació científica.

Es volia generar codi comparable al programat en ensamblador.

Idees principals:

- Variables amb noms (6 caràcters)
- Bucles i condicionals aritmètics
- E/S amb format
- Subrutines
- Taules

![:height 8em](img/john-backus.jpg)
.sepimg[]
![:height 8em](img/punch-card.png)

.xxs[Fotos: Domini públic i Wikipedia]

---

# Història: Fortran

```fortran
C AREA OF A TRIANGLE WITH A STANDARD SQUARE ROOT FUNCTION
      READ INPUT TAPE 5, 501, IA, IB, IC
  501 FORMAT (3I5)
C IA, IB, AND IC MAY NOT BE NEGATIVE OR ZERO
C FURTHERMORE, THE SUM OF TWO SIDES OF A TRIANGLE
C MUST BE GREATER THAN THE THIRD SIDE, SO WE CHECK FOR THAT, TOO
      IF (IA) 777, 777, 701
  701 IF (IB) 777, 777, 702
  702 IF (IC) 777, 777, 703
  703 IF (IA+IB-IC) 777, 777, 704
  704 IF (IA+IC-IB) 777, 777, 705
  705 IF (IB+IC-IA) 777, 777, 799
  777 STOP 1
C USING HERON'S FORMULA WE CALCULATE THE
C AREA OF THE TRIANGLE
  799 S = FLOATF (IA + IB + IC) / 2.0
      AREA = SQRTF( S * (S - FLOATF(IA)) * (S - FLOATF(IB)) *
     +     (S - FLOATF(IC)))
      WRITE OUTPUT TAPE 6, 601, IA, IB, IC, AREA
  601 FORMAT (4H A= ,I5,5H  B= ,I5,5H  C= ,I5,8H  AREA= ,F10.2,
     +        13H SQUARE UNITS)
      STOP
      END
```

---

# Història: Fortran

.center[
![:height 25em](img/primer-programa-fortran.png)
]

.xxs[Font: [J.A.N. Lee, Twenty Five Years of Fortran](https://eprints.cs.vt.edu/archive/00000875/01/CS82010-R.pdf)]


---

# Història: COBOL

**COmmon Business Oriented Language  (1959).** Desenvolupat per Grace Hopper
pel DoD i fabricants per a aplicacions de gestió.

Idees principals:

- Vol semblar idioma anglès, sense símbols
- Macros
- Registres
- Fitxers
- Identificadors llargs (30 caràcters)

![:height 8em](img/grace-hopper.jpg)
.sepimg[]
![:height 8em](img/cobol-sheet.jpg)

.xxs[Foto: Domini públic]

---

# Història: COBOL

```cobol
IDENTIFICATION DIVISION.
PROGRAM-ID.  Multiplier.
AUTHOR.  Michael Coughlan.
* Example program using ACCEPT, DISPLAY and MULTIPLY to
* get two single digit numbers from the user and multiply them together

DATA DIVISION.

WORKING-STORAGE SECTION.
01  Num1                                PIC 9  VALUE ZEROS.
01  Num2                                PIC 9  VALUE ZEROS.
01  Result                              PIC 99 VALUE ZEROS.

PROCEDURE DIVISION.
    DISPLAY "Enter first number  (1 digit) : " WITH NO ADVANCING.
    ACCEPT Num1.
    DISPLAY "Enter second number (1 digit) : " WITH NO ADVANCING.
    ACCEPT Num2.
    MULTIPLY Num1 BY Num2 GIVING Result.
    DISPLAY "Result is = ", Result.
    STOP RUN.
```

---

# Història: LISP

**LISt Processing (1958)**.
Desenvolupat per John McCarthy al MIT per a recerca en IA.

Idees principals:

- Sintàxi uniforme
- Funcions (composició i recursivitat)
- Llistes
- Expressions simbòliques
- Recol·lector de brossa

![:height 8em](img/john-mccarthy.jpg)

.xxs[Foto: Wikipedia]

---

# Història: LISP

```lisp
(defun factorial (N)
    "Compute the factorial of N."
    (if (= N 1)
        1
        (* N (factorial (- N 1)))))
```


```lisp
(defun first-name (name)
    "Select the first name from a name represented as a list."
    (first name))

(setf names '((John Q Public) (Malcolm X)
              (Admiral Grace Murray Hopper) (Spot)
              (Aristotle) (A A Milne) (Z Z Top)
              (Sir Larry Olivier) (Miss Scarlet)))
```


---

# Història: Algol

**ALGOrithmic Language (1958)**.
Dissenyat com un llenguatge universal per computació científica.
No gaire popular, però dóna lloc a LPs com Pascal, C, C++, and Java.

Idees principals:

- Blocs amb àmbits de variables
- Pas per valor i pas per nom (≠ pas per referència)
- Recursivitat
- Gramàtica formal (Backus-Naur Form or BNF)



```algol
procedure Absmax(a) Size:(n, m) Result:(y) Subscripts:(i, k);
    value n, m; array a; integer n, m, i, k; real y;
begin
    integer p, q;
    y := 0; i := k := 1;
    for p := 1 step 1 until n do
        for q := 1 step 1 until m do
            if abs(a[p, q]) > y then
                begin y := abs(a[p, q]);
                    i := p; k := q
                end
end Absmax
```

---

# Història: altres llenguatges



- Basic (Orientat a l'ensenyament de la programació) - 1964

- Pascal/Algol 68 (els hereus directes d'Algol 60) - 1970/1968

- C (Definit per programar Unix) - 1972

- Prolog (Primer llenguatge de programació lògica) - 1972

- Simula 67/Smalltalk  80 (primers llenguatges OO)

- Ada (LP creat per ser utilitzat pel Departament de Defensa Americà) - 1980

- ML/Miranda (primers llenguatges funcionals moderns) - 1983/1986

- C++ (llenguatge dinàmic i flexible compatible amb C) - 1983

- Java (llenguatge orientat a objectes per a torradores) - 1990

- Python (llenguatge llegible d'alt nivell de propòsit general) - 1991

- ...

---

# Ús dels LPs

Com mesurar la popularitat dels LPs?

- TIOBE Programming Community Index

  ![:height 15em](img/tiobe.png)

  .xxs[Font: https://www.tiobe.com/tiobe-index/ (2021)]


---

# Ús dels LPs

Com mesurar la popularitat dels LPs?

- Estadístiques de GitHub

  ![:height 14em](img/github.png)
  ![:height 14em](img/github2.png)

  .xxs[Fonts: https://github.com i https://www.benfrederickson.com/ranking-programming-languages-by-github-users/]


---

# Ús dels LPs

Quins LPs estudiar/evitar?

  ![:height 12em](img/popularitat-1.png)
  ![:height 12em](img/popularitat-2.png)


.xxs[Font: https://www.benfrederickson.com/ranking-programming-languages-by-github-users/]


---

# Ús dels LPs

Quins LPs estudiar/evitar?

  ![:height 20em](img/popularitat-3.png)


.xxs[Font: https://www.codeplatoon.org/the-best-paying-and-most-in-demand-programming-languages-in-2019/]



---

# Ús dels LPs 1965 - 2019

<iframe width="640" height="360" src="https://www.youtube.com/embed/Og847HVwRSI" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


---

# Paradigmes de LPs

Els **paradigmes de programació** classifiquen els LPs segons les
seves característiques.

<br>

.center[
![:height 15em](img/paradigms-floyd.png)
]

*[The paradigms of programming.](https://dl.acm.org/doi/pdf/10.1145/359138.359140)* R. Floyd, Communications ACM 1979.




---

# Paradigmes de LPs


Paradigmes comuns:

- **Imperatiu**: Les instruccions precisen els canvis d'estat.

  ```c++
  f = 1;
  while (--n) f *= n;
  ```

- **Declaratiu**: Es caracteritza el resultat, però no com calcular-lo.

  ```sql
  select full_name, order_date, order_amount
  from customers inner join orders
  on customers.customer_id = orders.customer_id
  ```

- **Funcional**: El resultat és el valor d'una sèrie d'aplicacions de funcions.

  ```haskell
  cincMesGrans :: [a] -> [a]
  cincMesGrans = take 5 . reverse . sort
  ```



---

# Paradigma imperatiu

Caràcteristiques:

- Noció d'estat

- Instruccions per canviar l'estat

- Efectes laterals

Exemples:

- C/C++, Python, Java, Ensamblador, ...

Útils quan, per exemple, l'eficiència és clau.


---

# Paradigma imperatiu

Subclassificacions:

- **Procedural**: Les instruccions s'agrupen en procediments.

  ```pascal
  PROCEDURE swap (VAR a, b: INTEGER)
  VAR c: INTEGER;
  BEGIN
        c := a;  b := a;  a := c;
  END;
  ```

- **Orientat a objectes**: Les instruccions s'agrupen amb l'estat dels objectes
  sobre les quals operen.

  ```smalltalk
  Point»dist: aPoint
        dx := aPoint x - x.
        dy := aPoint y - y.
        ↑ ((dx * dx) + (dy * dy)) sqrt
  ```



---

# Paradigma declaratiu

Caràcteristiques:

- Llenguatges descriptius.

- El programa diu què s'ha de fer, però no necessariament com.


Utilitat:

- Prototipat d'aplicacions amb forta component simbòlica, problemes
combinatoris, etc.

- Consultes en bases de dades relacionals o lògiques.

- Per especificació i raonament automàtic.

Exemples:

- SQL (consultes relacionals) / GraphQL (consultes en grafs, amb tipus)
 / Prolog (lògica de primer ordre) / Matemàtiques



---

# Paradigma declaratiu

Subclasificacions:


- **Matemàtic**: El resultat es declara com a la solució d'un problema d'optimització.

  ```bash
  Maximize
      x1 + 2 x2 + 3 x3 + x4
  Subject To
      - x1 + x2 + x3 + 10 x4 ≤ 20
      x1 - 3 x2 + x3 ≤ 30
      x2 - 3.5 x4 = 0
  ```

- **Consultes**: Resposta a consultes a una base de dades.

  ```sql
  SELECT full_name, order_date, order_amount
  FROM customers INNER JOIN orders
  ON customers.customer_id = orders.customer_id
  ```

- **Lògic**: Resposta a una pregunta amb fets i regles.

  ```prolog
  human(socrates).
  mortal(X) :- human(X).
  ?- mortal(socrates).
  ```


---

# Paradigma funcional

Caràcteristiques:

- Procedural

- Sense noció d'estat i sense efectes laterals

- Més fàcil de raonar (sobre correctesa o sobre transformacions)

Utilitat:

- Útils per al prototipat, fases inicials de desenvolupament
(especificacions executables i transformables).

- Tractament simbòlic.

- Sistemes de tipus potents (incloent polimorfisme paramètric i
  inferència de tipus)

Exemples: Haskell, ML (Caml, OCaml), Erlang, XSLT (tractament XML),...

---

# Paradigma funcional

Conceptes clau:

- **Recursivitat:**

  ```scheme
  (define (fib n)
      (cond
        ((= n 0) 0)
        ((= n 1) 1)
        (else
          (+ (fib (- n 1))
             (fib (- n 2))))))
  ```

- **Funcions d'ordre superior**: funcions que reben o retornen funcions.

  ```python
  map(lambda x: 2*x, [1,2,3,4])
  ```

- **Aplicació parcial (currying)**:

  ```haskell
  doble = (*2)
  ```


---

# Paradigma funcional

Conceptes clau:

- **Funcions pures**: Amb els mateixos arguments, les funcions sempre retornen
  el mateix resultat. No hi ha efectes laterals.

- **Mecanismes d'avaluació**: Avaluació estricta *vs* avaluació mandrosa.

- Sistemes de tipus


---

# Paradigma OO

Caràcteristiques:

- Es basa en *objectes* (atributs + mètodes) i potser *classes*.

- Inclou principalment *polimorfisme (subtipat)* i *herència*.

- Poden tenir sistemes de tipus complexos.


Exemples: Smalltalk, Simula, C++, Java...






---

# Llenguatges multiparadigma

Molts LPs combinen diferents paradigmes. Per exemple:

- Python, Perl: **imperatiu** + orientat a objectes + funcional

- OCaml: **funcional** + imperatiu + orientat a objectes


Alguns LPs incorporen caràcteristiques d'altres paradigmes:

- Prolog: **lògic** (+ imperatiu + funcional)


Altres combinacions:

- Erlang: **funcional** + concurrent + distribuït


---

# Llenguatges esotèrics

- **Brainfuck:** Basat en màquines de Turing, només té 8 instruccions. Exemple:

  ```bash
  ,>++++++[<-------->-],[<+>-],<.>.
  ```

- **Whitespace**: Només té espais en blanc i tabuladors. Exemple:

  ```bash

  ```

  (indenteu-lo bé quan el copieu 😛)


- **Shakespeare**: Amaga un programa dins d'una obra de teatre.

<pre style='margin-left: 3em; padding: 10px; height: 16em; overflow-y: auto; background-color: #272822; border-radius: 5px; color: white; font-size: 12px;'>
The Infamous Hello World Program.

Romeo, a young man with a remarkable patience.
Juliet, a likewise young woman of remarkable grace.
Ophelia, a remarkable woman much in dispute with Hamlet.
Hamlet, the flatterer of Andersen Insulting A/S.


                    Act I: Hamlet's insults and flattery.

                    Scene I: The insulting of Romeo.

[Enter Hamlet and Romeo]

Hamlet:
 You lying stupid fatherless big smelly half-witted coward!
 You are as stupid as the difference between a handsome rich brave
 hero and thyself! Speak your mind!

 You are as brave as the sum of your fat little stuffed misused dusty
 old rotten codpiece and a beautiful fair warm peaceful sunny summer's
 day. You are as healthy as the difference between the sum of the
 sweetest reddest rose and my father and yourself! Speak your mind!

 You are as cowardly as the sum of yourself and the difference
 between a big mighty proud kingdom and a horse. Speak your mind.

 Speak your mind!

[Exit Romeo]

                    Scene II: The praising of Juliet.

[Enter Juliet]

Hamlet:
 Thou art as sweet as the sum of the sum of Romeo and his horse and his
 black cat! Speak thy mind!

[Exit Juliet]

                    Scene III: The praising of Ophelia.

[Enter Ophelia]

Hamlet:
 Thou art as lovely as the product of a large rural town and my amazing
 bottomless embroidered purse. Speak thy mind!

 Thou art as loving as the product of the bluest clearest sweetest sky
 and the sum of a squirrel and a white horse. Thou art as beautiful as
 the difference between Juliet and thyself. Speak thy mind!

[Exeunt Ophelia and Hamlet]


                    Act II: Behind Hamlet's back.

                    Scene I: Romeo and Juliet's conversation.

[Enter Romeo and Juliet]

Romeo:
 Speak your mind. You are as worried as the sum of yourself and the
 difference between my small smooth hamster and my nose. Speak your
 mind!

Juliet:
 Speak YOUR mind! You are as bad as Hamlet! You are as small as the
 difference between the square of the difference between my little pony
 and your big hairy hound and the cube of your sorry little
 codpiece. Speak your mind!

[Exit Romeo]

                    Scene II: Juliet and Ophelia's conversation.

[Enter Ophelia]

Juliet:
 Thou art as good as the quotient between Romeo and the sum of a small
 furry animal and a leech. Speak your mind!

Ophelia:
 Thou art as disgusting as the quotient between Romeo and twice the
 difference between a mistletoe and an oozing infected blister! Speak
 your mind!

[Exeunt]
</pre>

---

class: split-5050

# Turing completesa


.cols5050[
.col1[
**Màquina de Turing**: Model matemàtic de càlcul imperatiu molt simple.<br/> (Allan Turing, 1936)

![:height 8em](img/alan-turing.jpg)
.sepimg[]
![:height 8em](img/turing-machine.png)

- Cinta infinita amb un capçal mòvil per llegir/escriure símbols
- Conjunt finit d'estats
- Funció de transició (estat, símbol ⟶ estat, símbol, moviment)
]
.col2[
**λ-càlcul**: Model matemàtic de càlcul funcional molt simple. <br/> (Alonzo Church, 1936).

![:height 8em](img/lambda2.png)
![:height 8em](img/alonzo-church.jpg)

- Sistema de reescriptura
- basat en abstracció i aplicació de funcions.
]
]

**Tesi de Church-Turing**: "Tot algorisme és
computable amb una Màquina de Turing o amb una funció en λ-càlcul".


.xxs[Fotos: Wikipedia, Fair Use, [Lambda Calculus for Absolute Dummies](http://palmstroem.blogspot.com/2012/05/lambda-calculus-for-absolute-dummies.html)]

---

# Turing completesa

Un LP és **Turing complet** si pot implementar qualsevol càlcul
que un computador digital pugui realitzar.





Alguns autors consideren només com a LPs els
llenguatges Turing complets.


- LPs Turing complets:

    - LPs de programació de propòsit general (C/C++, Python, Haskell...)
    - automàts cel·lulars (Joc de la vida, ...)
    - alguns jocs (Minecraft, Buscamines...)

  Per ser Turing complet només cal tenir salts condicionals (bàsicament,
  `if` i `goto`) i memòria arbitràriament gran.

- LPs no Turing complets:

    - expressions regulars (a Perl o a AWK)
    - ANSI SQL




---

# Sistemes d'execució

- **Compilat**: el codi és transforma en codi objecte i després es monta en
  un executable. Sol ser eficient. Es distribueix l'executable.

  Exemples: C, C++, Ada, Haskell, ...

- **Interpretat**: el codi s'executa directament o el codi es transforma en
  codi d'una màquina virtual, que l'executa. Es distribueix el codi font.

  Aumenten la portabilitat i l'expressabilitat (es poden fer més coses
  en temps d'execució) però disminueix l'eficiència.

  Exemples: Python, JavaScript, Prolog (WAM), Java (JVM), ...


Sistemes mixtes:

- **Just in Time compilation**: Es compila (parcialment) en temps d'execució.

- Alguns interpretats, poden ser també compilats (per exemple, Prolog).
- i al revés (Haskell).


---

# Sistemes de tipus

Un **sistema de tipus** és un conjunt de regles que assignen *tipus*  als
elements d'un programa (com ara variables, expressions, funcions...) per
evitar errors.

La comprovació de tipus verifica que les diferents parts d'un programa
es comuniquin adequadament en funció dels seus tipus.

Per exemple, amb

```c++
class Persona;
class Forma;
class Rectangle :Forma;
class Triangle  :Forma;

double area (const Forma&);
```

- cridar a `area` amb un `Rectangle` o un `Triangle` és correcte,
- cridar a `area` amb una `Persona` o un enter és un error de tipus.



---

# Sistemes de tipus: Errors de tipus

Un **error de tipus** consisteix en aplicar a les dades una operació
que el seu tipus no suporta.

- Type Cast: usar un valor d'un tipus en un altre tipus.

  👉 En C, un enter pot ser usat com a funció (com a adreça), però pot
  saltar on no hi ha una funció i pot provocant un error.

  👉 En C, `printf("%s", 42);`.

- Aritmètica de punters.

  👉 En C++, si tenim `A p[10];` llavors `p[15]` té tipus `A`, però el que
  hi ha a `p[15]` pot ser qualsevol altra cosa i pot provocar un error de tipus.

- Alliberament explícit de memòria (deallocate/delete).

  Exemple: En Pascal usar un apuntador alliberat pot donar errors de
  tipus.

- En llenguatges OO (antics), no existència d'un mètode (degut a
  l'herència).



---

# Sistemes de tipus: Seguretat de tipus

La **seguretat de tipus** (*type safety*) és la mesura de com de fàcil/difícil és cometre errors
de tipus en un LP.

Exemples:

- C té reputació de ser un LP sense gaire seguretat de tipus (unions, enumerats, `void*`, ...).

- C++ hereta C però proporciona més seguretat de tipus:
    els enumerats no es poden convertr implícitament amb els enters o altres enumerats,
    el *dynamic casting* pot comprovar errors de tipus en temps execució, ...

- Java és dissenyat per a proporcionar seguretat de tipus. Però es pot abusar
del *classloader*.

- Python, igual que Java, està dissenyat per donar seguretat de tipus, malgrat que
el tipatge sigui dinàmic.

- Es creu que Haskell és *type safe* si no s'sabusen algunes construccions com
`unsafePerformIO`.


---

# Sistemes de tipus: Tipat fort/feble

Els llenguatges amb **tipat fort** imposen restriccions que
eviten barrejar valors de diferents tipus (per exemple, amb conversions implícites).


Per exemple, amb un tipat feble podem tenir:

```javascript
a = 2
b = "2"

a + b      # JavaScript retorna "22"
a + b      # Perl retorna 4
```

<br/>
Exemples de llenguatges:

- Tipat fort: C++, Java, Python, Haskell, ...

- Tipat feble: Basic, JavaScript, Perl, ...


---

# Sistemes de tipus: Comprovació

La comprovació de tipus pot ser:

- **Estàtica**: en temps de compilació.

- **Dinàmica**: en temps d'execució.

- **Mixta**.



<br/>
Exemples de llenguatges:

- Comprovació estàtica: Haskell, C++, Java, ...

- Comprovació dinàmica: Python, Ruby, ...
