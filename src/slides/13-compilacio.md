
class: center, middle


Llenguatges de Programació

# Introducció a la compilació

Jordi Cortadella, Jordi Petit, Gerard Escudero

<br/>

![:height 10em](img/compilation.png)

<br/>

Universitat Politècnica de Catalunya, 2021


---

# Objectius


- Conèixer l'estructural general d'un compilador.

- Conèixer l'existència d'eines per ajudar a crear compiladors (usarem [ANTLR](https://www.antlr.org/)).

- A la pràctica, ens limitem a crear petits processadors de llenguatges:
    1. Definició del vocabulari,
    2. Definició de la gramàtica,
    3. Generació de l'arbre de sintàxi abstracta,
    4. Interpretació a través del recorregut de l'arbre.

- El curs de Compiladors aprofundeix molts més els continguts.
- El curs de Teoria de la Computació n'ofereix els fonaments teòrics.

---

# Crèdits

Gran part del material d'aquestes diapositives s'ha extret de
les que va elaborar el professor Stephen A. Edwards (Universitat
de Columbia) per l'assignatura COMS W4115 (Programming
Languages and Translators) i que el professor Jordi Cortadella
(UPC) va adaptar per l'assignatura de Compiladors.


---


class: center, middle

# Visió general




---

# Sintaxi

La **sintaxi** d'un llenguatge de programació és el conjunt de regles que
defineixen les combinacions de símbols que es consideren construccions
correctament estructurades.

<br>

```
Jove xef, porti whisky amb quinze glaçons d'hidrogen, coi!
```

> ➡️  frase sintàcticament correcta en català, però no és un programa en Java.

<br>

```java
class Foo {
    public int j;
    public int foo(int k) {
        return j + k;
    }
}
```

> ➡️ programa sintàcticament correcte en Java, però no és un programa en C.



---

# Sintaxi


Sovint s'especifica la sintaxi utilitzant una **gramàtica lliure de context**
(*context-free grammar*).


Exemple típic per les expressions algebràiques:

```
expr → expr + expr
     | expr - expr
     | expr * expr
     | expr / expr
     | digit
     | ( expr )
```


---

# Semàntica

La **semàntica** d'un LP descriu què significa un programa ben construit.

<br>


```python
def fib(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a + b
    return a
```

> ➡️  La semàtica d'aquesta funció en Python és el càlcul de l'`n`-èsim
nombre de Fibonacci.


---

# Semàntica

A vegades, les construccions sintàcticament correctes poden ser semànticament incorrectes.

<br>

```
L'arc de Sant Martí va saltar sobre el planeta pelut.
```

> ➡️  sintàcticament correcta en català, però sense sentit.

<br>

```java
class Foo {
    int bar(int x) { return Foo; }
}
```

> ➡️  sintàcticament correcte en Java, però sense sentit.


---

# Semàntica

A vegades, les construccions sintàcticament correctes poden ser ambigües.

<br>
<br>

```
Han posat un banc nou a la plaça.
```

> ➡️  sintàcticament correcta en català, però ambigüa.


<br>

```java
class Bar {
    public float foo() { return 0; }
    public int foo()   { return 0; }
}
```

> ➡️  sintàcticament correcte en Java, però ambigu.



---

# Semàntica

Hi ha dues bàsicament de dues maneres d'especificar formalment la semàntica:

- **Semàntica operacional:** defineix una màquina virtual i
com l'execució del programa canvia l'estat de la màquina.

- **Semàntica denotacional:** mostra com construir una
funció que representa el comportament del programa (és a dir,
una transformació d'entrades a sortides) a partir de les construccions del LP.

La majoria de definicions de semàntica per a LPs utilitzen una semàntica
operacional escrita informalment en llenguatge natural.

.center[
![:height 10em](img/compis-std-cpp.png)
&nbsp; &nbsp; &nbsp;
![:height 10em](img/compis-java-std.png)
]


---

# Processadors de llenguatges

## Intèrpret

.center[
![:width 30em](img/compis-interpret.png)
]


---

# Processadors de llenguatges

## Compilador

.center[
![:width 30em](img/compis-compilador.png)
]

---

# Processadors de llenguatges

## Compilador

Compilació en C

```c
int func(int a, int b) {
    a = a + b;
    return a;
}
```

`gcc -S prova.c`

```
_func:
    pushq   %rbp
    movq    %rsp, %rbp
    movl    %edi, -4(%rbp)
    movl    %esi, -8(%rbp)
    movl    -4(%rbp), %eax
    addl    -8(%rbp), %eax
    movl    %eax, -4(%rbp)
    movl    -4(%rbp), %eax
    popq    %rbp
    retq
```

---

# Processadors de llenguatges

## Intèrpret de bytecode

.center[
![:width 30em](img/compis-byte-code.png)
]

- El **bytecode** és un codi intermedi més abstracte que el codi màquina.
- Redueix la dependència respecte del maquinari específic i facilita la interpretació.
- Una **màquina virtual** interpreta programes en bytecode.

---

# Processadors de llenguatges

## Intèrpret de bytecode


.cols5050[
.col1[
Bytecode en Python

```python
>>> import dis  # desensamblador
>>> dis.dis("a = a + b")
  1   0 LOAD_NAME     0 (a)
      2 LOAD_NAME     1 (b)
      4 BINARY_ADD
      6 STORE_NAME    0 (a)
      8 LOAD_CONST    0 (None)
    10 RETURN_VALUE
```
]
.col2[
Bytecode en Java

```java
public static void func(int a, int b) {
    a = a + b;
}
```

`javap -v prova.class`

```
public static void func(int, int);
    descriptor: (II)V
    flags: (0x0009) ACC_PUBLIC, ACC_STATIC
    Code:
      stack=2, locals=2, args_size=2
         0: iload_0
         1: iload_1
         2: iadd
         3: istore_0
         4: return
```
]
]
---

# Processadors de llenguatges

## Compilador *just in time*

.center[
![:width 30em](img/compis-jit.png)
]


---

# Processadors de llenguatges

## Ecosistema

Els processadors de llenguatges viuen en un ecosistema gran i complex:
preprocessadors, compiladors, enllaçadors, gestors de llibreries,
ABIs (application binary interface (ABI),
formats d'executables, ...

<br>


.center[
![:width 30em](img/compis-ecosistema.png)
]


---

# Processadors de llenguatges

## Comparació velocitats

<br>

.center[
![:width 30em](img/compis-velocitats.png)
]


---

# Preprocessadors

Un **preprocessador** prepara el codi font d'un programa abans que el compilador
el vegi.

- Expansió de macros
- Inclusió de fitxers
- Compilació condicional
- Extensions de llenguatge

---

# Preprocessadors

## El preprocessador de C


```c
#include <stdio.h>
#define min(x, y) ((x)<(y))?(x):(y)
#ifdef DEFINE_BAZ
int baz();
#endif
void foo() {
    int a = 1;
    int b = 2;
    int c;
    c = min(a,b);
}
```

`cc -E programa.c`

```c
extern int printf(char*,...);
⠇
⠇ moltes més línies de stdio.h
⠇
void foo() {
    int a = 1;
    int b = 2;
    int c;
    c = ((a)<(b))?(a):(b);
}
```



---

# Flux de compilació

```c
int gcd(int a, int b) {
    while (a != b) {
        if (a > b) a -= b; else b -= a;
    }
    return a;
}
```



---

# Flux de compilació

```c
int gcd(int a, int b) {
    while (a != b) {
        if (a > b) a -= b; else b -= a;
    }
    return a;
}
```

El compilador veu una seqüència de caràcters:


```
i n t ␣ g c d ( i n t ␣ a , ␣ i n t ␣ b ) ␣ { ⏎ ␣ ␣ w h i l e ␣
( a ␣ ! = ␣ b ) ␣ { ⏎ ␣ ␣ ␣ ␣ i f ␣ ( a ␣ > ␣ b ) ␣ a ␣ - = ␣ b
; ␣ e l s e ␣ b ␣ - = ␣ a ; ⏎ ␣ ␣ } ⏎ ␣ ␣ r e t u r n ␣ a ; ⏎ } ⏎
```


---

# Flux de compilació

```c
int gcd(int a, int b) {
    while (a != b) {
        if (a > b) a -= b; else b -= a;
    }
    return a;
}
```

L'**analitzador lèxic** agrupa els caràcters en "paraules" (*tokens*) i elimina
blancs i comentaris.

.center[
![:width 30em](img/compis-tokens.png)
]




---

# Flux de compilació

```c
int gcd(int a, int b) {
    while (a != b) {
        if (a > b) a -= b; else b -= a;
    }
    return a;
}
```

L'**analitzador sintàtic** construeix un **arbre de sintàxi abstracta** a partir de la seqüència
de tokens i les regles sintàctiques
Les paraules clau, els separadors, parèntesis i blocs s'eliminen.

.center[
![:width 30em](img/compis-exemple-ast.png)
]




---

# Flux de compilació

```c
int gcd(int a, int b) {
    while (a != b) {
        if (a > b) a -= b; else b -= a;
    }
    return a;
}
```

L'**analitzador semàntic** resol els símbols i verifica els tipus.

.center[
![:width 30em](img/compis-exemple-ast-resolt.png)
]


---

# Flux de compilació

```c
int gcd(int a, int b) {
    while (a != b) {
        if (a > b) a -= b; else b -= a;
    }
    return a;
}
```

El **generador de codi** tradueix el programa a **codi de tres adreces**
(ensamblador idealitzat amb infinitat de registres).

```bash
L0:     sne $1, a, b            # signed not equal
        seq $0, $1, 0           # signed equal
        btrue $0, L1            # while a != b
        sl $3, b, a             # signed less
        seq $2, $3, 0
        btrue $2, L4            #    if a < b
        sub a, a, b             #       a -= b
        jmp L5
L4:     sub b, b, a             #       b -= a
L5:     jmp L0
L1:     ret a                   # return a
```



---

# Flux de compilació

```bash
L0:     sne $1, a, b            # signed not equal
        seq $0, $1, 0           # signed equal
        btrue $0, L1            # while a != b
        sl $3, b, a             # signed less
        seq $2, $3, 0
        btrue $2, L4            #    if a < b
        sub a, a, b             #       a -= b
        jmp L5
L4:     sub b, b, a             #       b -= a
L5:     jmp L0
L1:     ret a                   # return a
```

El **back end** tradueix i optimitza el codi de tres adreces a l'arquitectura desitjada:


```bash
gcd:    pushl %ebp              # Save FP                                    [asm 80386]
        movl %esp,%ebp
        movl 8(%ebp),%eax       # Load a from stack
        movl 12(%ebp),%edx      # Load b from stack
.L8:    cmpl %edx,%eax
        je .L3                  # while a != b
        jle .L5                 #    if (a < b)
        subl %edx,%eax          #       a -= b
        jmp .L8
.L5:    subl %eax,%edx          #       b -= a
        jmp .L8
.L3:    leave                   # Restore SP, BP
        ret                     # return a
```

---

# Flux de compilació

## Etapes

- Front end
    - preprocessador
    - analitzador lèxic (escàner)
    - analitzador sintàctic (parser)
    - analitzador semàntic
- Middle end
    - analitzador de codi intermig
    - optimitzador de codi intermig
- Back end
    - generador de codi específic
    - optimitzador de codi específic

---

# Sumari

.center[
![:height 14cm](img/compis-flux.png)
]


---


class: center, middle


# Anàlisi lèxica



---

# Anàlisi lèxica


L'**analitzador lèxic** o (**escàner**)
converteix una seqüència de caràcters en una seqüència de ***tokens***.


.center[
![:width 30em](img/compis-scanner.png)
]


---

# Objectius


- Simplificar la feina de l'analitzador sintàctic.

    > El parser no té en compte els noms dels identificadors,
    només li preocupen els *tokens* (`supercalifragilisticexpialidocious` → `ID`).

- Descartar detalls irrellevants: blancs, comentaris, ...

- Els escàners són molt més ràpids que els *parsers*.




---

# Descripció de *tokens*:


Per especificar els *tokens* s'utilitzen elements de la teoria de llenguatges:


**Alfabet:** un conjunt finit de símbols.

> Exemples: {0, 1}, {`A`, `B`, ..., `Z`}, ASCII, Unicode, ...


**Paraula:** una seqüència finita de símbols de l'alfabet.

> Exemples: ε (la paraula buida), `foo`, `αβγ`.


**Llenguatge:** Un conjunt de paraules sobre un alfabet.

> Exemples: ∅ (el llenguatge buit), { 1, 11, 111, 1111 },
> tots els mots anglesos, els identificadors (textos que comencen
> amb una lletra seguida per lletres o dígits).



---

# Operacions sobre llenguatges

> Exemple:  *L* = { ε, wo }, *M* = { man, men }

**Concatenació:** Una paraules d'un llenguatge seguida d'una paraula de l'altre llenguatge.

> *L M* = { man, men, woman, women }

**Unió:** Totes les paraules de cada llenguatge.

> *L* ∪ *M* = {ε, wo, man, men }

**Clausura de Kleene:** Zero o més concatenacions.

> *M﹡* = {ε} ∪ *M* ∪ *MM* ∪ *MMM* ∪ ... = {ε, man, men, manman, manmen, menman, menmen,
> manmanman, manmanmen, manmenman, ...}


---

# Expressions regulars

Les **expressions regulars** descriuen
llenguatges a partir de *tokens* sobre un alfabet *Σ*.

1. ε és una expressió regular que denota {ε}.

2. Si *a* ∈ *Σ*, *a* és una expressió regular que denota {*a*}.

3. Si *r* i *s* denoten els llenguatges *L(r)* i *L(s)*,

    - (*r*)|(*s*) denota *L(r)* ∪ *L(s)*

    - (*r*)(*s*) denota {*tu* : *t* ∈ *L(r)*, *u* ∈ *L(s)*}

    - (*r﹡*) denota la clausura transitiva de *L(r)*


---

# Expressions regulars

Exemple:

.center[
![:width 30em](img/compis-ers.png)
]


---

# Generadors d'escàners


Les expressions regulars s'usen en:

- eines per crear compiladors (lex, ANTLR, ...)

- comandes del SO per tractar fitxers (`grep`, `sed`, ...)

- llibreries en LPs per tractar textos (`re` en Python, directament en Javascript, ...)


---

# Generadors d'escàners

<br>

.center[

.boxed[Regles amb expressions regulars]

⬇

.boxed[Autòmats finits no determinites]

⬇

.boxed[Autòmat finit determinista]

⬇

.boxed[Taules]
]

---

# ANTLR

.cols5050[
.col1[
```antlr
RET     : 'return' ;

LPAREN  : '(' ;
RPAREN  : ')' ;

ADD     : '+' ;
SUB     : '-' ;
MUL     : '*' ;
DIV     : ';' ;

DIGIT   : '0'..'9' ;
LETTER  : [a-zA-Z] ;

NUMBER  : (DIGIT)+ ;
IDENT   : LETTER (LETTER | DIGIT)* ;

WS      : [ \t\n]+ -> skip ;
```

.xxs[
[Referència](https://github.com/antlr/antlr4/blob/master/doc/lexer-rules.md)
]
]
.col2[
- els noms dels tokens han de ser en majúscules

- textos entre cometes representen aquell text

- ajuntar indica concatenació

- `|` indica unió

- `*` indica zero o més

- `+` indica un o més

- `?` indica un o cap

- `..` indica rangs

- es poden agrupar elements amb parèntesis

- l'`skip` no reporta el token
]
]

---

# grep

La comanda `grep` (*global regular expression print*)
permet cercar patrons en texts.

```bash
grep 'jpetit'   /etc/passwd
grep '^jpetit'  /etc/passwd          # ancorar al principi de la línia
grep 'jpetit$'  /etc/passwd          # ancorar al final de la línia
grep 'j.etit'   /etc/passwd          # qualsevol caràcter
grep '[a-zA-Z]([a-zA-Z0-9])*'        # identificadors
```

.right[
.xxs[
[Referència](https://www.gnu.org/software/grep/manual/grep.html)
]
]

---

# re

El mòdul `re`
de Python proporciona
operacions sobre expressions regulars.

```python
>>> import re

>>> p = re.compile('[a-z]+')
>>> p.match("7654386732().")
None
>>> m = p.match('unicorn')
<re.Match object; span=(0, 5), match='unicorn'>
>>> m.group()
'unicorn'
>>> m.start(), m.end()
(0, 5)
>>> m.span()
(0, 5)

>>> re.search('casa', 'vaig a casa a dormir')
<re.Match object; span=(7, 11), match='casa'>

>>> re.sub('[0-9]+', 'molts', 'val 350 euros')
'val molts euros'
```

.right[
.xxs[
[Tutorial](https://docs.python.org/3/howto/regex.html)
]
]



---

# Testing d'expressions regulars


Some people, when confronted with a problem, think "*I'll use regular
expressions*". Now they have two problems.

.right[⸺ Jamie Zawinski, 1997]


.center[
![:width 25em](img/compis-regex101.png)
]

---

# Exercicis


Definiu expressions regulars pels llenguatges següents:

1. Identificadors de C++: poden contenir lletres, dígits i subratllats
però no poden començar per un dígit.

1. Nombres en coma flotant.   Si s'utilitza un punt decimal, un dígit decimal és obligatori.

    > Exemples: `3.1416`, `-3e4`, `+1.0e-5`, `.567e+8`, ...

1. Totes les paraules amb alfabet {`a`, `b`, `c`}
en les quals la primera aparició de `b` sempre és precedida per,
com a mínim, una aparició de `a`.

1. Totes les paraules amb minúscules que contenen les cinc vocals en ordre
(cada vocal només pot aparèixer un sol cop).

    > Example: `zfaehipojksuj`

1. Totes les paraules amb minúscules en les quals les lletres es troben en
ordre lexicogràfic ascendent.

    > Examples: `afhmnqsyz`, `abcdz`, `dgky`, ... Contraexemple: `bdeaz`.





---


class: center, middle


# Anàlisi sintàctica



---

# Anàlisi sintàctica


L'objectiu de l'analitzador sintàctic és convertir una seqüència de tokens
en un arbre de sintàxi abstracta que capturi la jerarquia de les construccions.

.center[
`2 * 3 + 4`

⬇

![:width 6em](img/compis-ast1.png)
]

→ Es descarta informació no rellevant com les paraules clau,
els separadors, els parèntesis i els blocs.

→ Es facilita la feina dels propers estadis.



---

# Gramàtiques

La majoria dels LPs es descriuen a través de **gramàtiques incontextuals**.

```
pgma → expr ; pgma
     | /* res */

expr → expr + expr
     | expr - expr
     | expr * expr
     | expr / expr
     | ( expr )
     | NUM
```


Les gramàtiques incontextuals permeten descriure llenguatges més amplis
que els llenguatges regulars perquè són "recursives".

> Ex: El llenguatge dels mots capicues es pot descriure amb una
gramàtica incontextual però no amb una expressió regular.

La recursivitat permet donar jerarquia i aparellar elements (parèntesis o blocs).


---

# Gramàtiques

Exemple: Gramàtica de C

<pre style='margin-left: 0em; padding: 10px; height: 32em; overflow-y: auto; background-color: #272822; border-radius: 5px; color: white; font-size: 12px;'>
translation-unit     : {external-declaration}*

external-declaration     : function-definition
                         | declaration

function-definition     : {declaration-specifier}* declarator {declaration}* compound-statement

declaration-specifier     : storage-class-specifier
                          | type-specifier
                          | type-qualifier

storage-class-specifier     : auto
                            | register
                            | static
                            | extern
                            | typedef

type-specifier     : void
                   | char
                   | short
                   | int
                   | long
                   | float
                   | double
                   | signed
                   | unsigned
                   | struct-or-union-specifier
                   | enum-specifier
                   | typedef-name

struct-or-union-specifier     : struct-or-union identifier { {struct-declaration}+ }
                              | struct-or-union { {struct-declaration}+ }
                              | struct-or-union identifier

struct-or-union     : struct
                    | union

struct-declaration     : {specifier-qualifier}* struct-declarator-list

specifier-qualifier     : type-specifier
                        | type-qualifier

struct-declarator-list     : struct-declarator
                           | struct-declarator-list , struct-declarator

struct-declarator     : declarator
                      | declarator : constant-expression
                      | : constant-expression

declarator     : {pointer}? direct-declarator

pointer     : * {type-qualifier}* {pointer}?

type-qualifier     : const
                   | volatile

direct-declarator     : identifier
                      | ( declarator )
                      | direct-declarator [ {constant-expression}? ]
                      | direct-declarator ( parameter-type-list )
                      | direct-declarator ( {identifier}* )

constant-expression     : conditional-expression

conditional-expression     : logical-or-expression
                           | logical-or-expression ? expression : conditional-expression

logical-or-expression     : logical-and-expression
                          | logical-or-expression || logical-and-expression

logical-and-expression     : inclusive-or-expression
                           | logical-and-expression && inclusive-or-expression

inclusive-or-expression     : exclusive-or-expression
                            | inclusive-or-expression | exclusive-or-expression

exclusive-or-expression     : and-expression
                            | exclusive-or-expression ^ and-expression

and-expression     : equality-expression
                   | and-expression & equality-expression

equality-expression     : relational-expression
                        | equality-expression == relational-expression
                        | equality-expression != relational-expression

relational-expression     : shift-expression
                          | relational-expression < shift-expression
                          | relational-expression > shift-expression
                          | relational-expression <= shift-expression
                          | relational-expression >= shift-expression

shift-expression     : additive-expression
                     | shift-expression << additive-expression
                     | shift-expression >> additive-expression

additive-expression     : multiplicative-expression
                        | additive-expression + multiplicative-expression
                        | additive-expression - multiplicative-expression

multiplicative-expression     : cast-expression
                              | multiplicative-expression * cast-expression
                              | multiplicative-expression / cast-expression
                              | multiplicative-expression % cast-expression

cast-expression     : unary-expression
                    | ( type-name ) cast-expression

unary-expression     : postfix-expression
                     | ++ unary-expression
                     | -- unary-expression
                     | unary-operator cast-expression
                     | sizeof unary-expression
                     | sizeof type-name

postfix-expression     : primary-expression
                       | postfix-expression [ expression ]
                       | postfix-expression ( {assignment-expression}* )
                       | postfix-expression . identifier
                       | postfix-expression - identifier
                       | postfix-expression ++
                       | postfix-expression --

primary-expression     : identifier
                       | constant
                       | string
                       | ( expression )

constant     : integer-constant
             | character-constant
             | floating-constant
             | enumeration-constant

expression     : assignment-expression
               | expression , assignment-expression

assignment-expression     : conditional-expression
                          | unary-expression assignment-operator assignment-expression

assignment-operator     : =
                        | *=
                        | /=
                        | %=
                        | +=
                        | -=
                        | <<=
                        | >>=
                        | &=
                        | ^=
                        | |=

unary-operator     : &
                   | *
                   | +
                   | -
                   | ~
                   | !

type-name     : {specifier-qualifier}+ {abstract-declarator}?

parameter-type-list     : parameter-list
                        | parameter-list , ...

parameter-list     : parameter-declaration
                   | parameter-list , parameter-declaration

parameter-declaration     : {declaration-specifier}+ declarator
                          | {declaration-specifier}+ abstract-declarator
                          | {declaration-specifier}+

abstract-declarator     : pointer
                        | pointer direct-abstract-declarator
                        | direct-abstract-declarator

direct-abstract-declarator     :  ( abstract-declarator )
                               | {direct-abstract-declarator}? [ {constant-expression}? ]
                               | {direct-abstract-declarator}? ( {parameter-type-list}? )

enum-specifier     : enum identifier { enumerator-list }
                   | enum { enumerator-list }
                   | enum identifier

enumerator-list     : enumerator
                    | enumerator-list , enumerator

enumerator     : identifier
               | identifier = constant-expression

typedef-name     : identifier

declaration     :  {declaration-specifier}+ {init-declarator}* ;

init-declarator     : declarator
                    | declarator = initializer

initializer     : assignment-expression
                | { initializer-list }
                | { initializer-list , }

initializer-list     : initializer
                     | initializer-list , initializer

compound-statement     : { {declaration}* {statement}* }

statement     : labeled-statement
              | expression-statement
              | compound-statement
              | selection-statement
              | iteration-statement
              | jump-statement

labeled-statement     : identifier : statement
                      | case constant-expression : statement
                      | default : statement

expression-statement     : {expression}? ;

selection-statement     : if ( expression ) statement
                        | if ( expression ) statement else statement
                        | switch ( expression ) statement

iteration-statement     : while ( expression ) statement
                        | do statement while ( expression ) ;
                        | for ( {expression}? ; {expression}? ; {expression}? ) statement

jump-statement     : goto identifier ;
                   | continue ;
                   | break ;
                   | return {expression}? ;
</pre>

.xxs[.right[
[Font](https://cs.wmich.edu/~gupta/teaching/cs4850/sumII06/The%20syntax%20of%20C%20in%20Backus-Naur%20form.htm)
]]

---

# Dificultats

- Gramàtiques ambigües

- Prioritat dels operadors

- Associativitat dels operadors

- Analitzadors top-down *vs.* bottom-up

- Recursivitat per la dreta / per l'esquerra



---

# Gramàtiques ambigües

Una gramàtica és **ambigüa** si un mateix text es pot derivar de diferents maneres.

Per exemple, amb

```
expr → expr + expr | expr - expr | expr * expr | NUM
```

el fragment `3 - 4 * 2 + 5` es pot derivar d'aquestes maneres:

.center[
![:width 30em](img/compis-ambigua.png)
]


---

# Prioritat i associativitat dels operadors

Associar prioritat i associativitat als operadors sol permetre eliminar ambigüitats.

- Prioritat: `1 * 2 + 3 * 4`

.cols5050[
.col1[.center[
`*` té més prioritat que `+`

![:width 5em](img/compis-ambigua1.png)
]]
.col2[.center[
`+` té més prioritat que `*`

![:width 3em](img/compis-ambigua2.png)
]
]]

- Associativitat: `1 - 2 - 3 - 4`

.cols5050[
.col1[.center[
associativitat per l'esquerra

![:width 6em](img/compis-assoc1.png)
]]
.col2[.center[
associativitat per la dreta

![:width 6em](img/compis-assoc2.png)
]
]]



---

# Desambigüació de gramàtiques

Comencem amb

```
expr → expr + expr
     | expr - expr
     | expr * expr
     | expr / expr
     | NUM
```

> ➡️ És ambigüa: no hi ha la prioritat ni associativitat habitual en matemàtiques.



---

# Desambigüació de gramàtiques

Podem assignar prioritats trencant en vàries regles, una per nivell:

```
expr → expr + expr
     | expr - expr
     | expr * expr
     | expr / expr
     | NUM
```

> ⬇

```
expr → expr + expr
     | expr - expr
     | term

term → term * term
     | term / term
     | NUM
```


> ➡️ Encara és ambigüa: falta associativitat.


---

# Desambigüació de gramàtiques

Podem fer que un costat o altre afecti el següent nivell de prioritat:

```
expr → expr + expr
     | expr - expr
     | term

term → term * term
     | term / term
     | NUM
```

> ⬇

```
expr → expr + term
     | expr - term
     | term

term → term * NUM
     | term / NUM
     | NUM
```


> ✅ La gramàtica ja no és ambigüa.





---

# Generadors d'analitzadors sintàctics

Existeixen diferents tècniques per generar analitzadors sintàctics, amb propietats
diferents.

- **Analitzadors descendents** (*top-down parsers*): reconeixen l'entrada d'esquerra
a dreta tot buscant derivacions per l'esquerra expandint la gramàtica de l'arrel
cap a les fulles.

- **Analitzadors ascendents** (bottom-up *parsers*): reconeixen primer sobre les
unitats més petites de l'entrada analitzada abans de reconèixer l'estructura
sintàctica segons la gramàtica.


.center[
![:width 35em](img/compis-parsers.png)
]
.right[.xxs[
Figura: [Wikipedia](https://en.wikipedia.org/wiki/Bottom-up_parsing)
]]



---

# Generadors d'analitzadors sintàctics

## Analitzadors descendents LL(*k*)

- LL: Left-to-right, Left-most derivation<br>
- *k*: nombre de tokens que mira endavant

Idea bàsica: mirar el següent token per poder
decidir quina producció utilitzar.

---

# Generadors d'analitzadors sintàctics

## Analitzadors descendents LL(1)

.cols5050[
.col1[
Exemple de gramàtica:

```antlr
root    : stmt *
        ;

stmt    : 'if' expr 'then' stmt
        | 'while' expr 'do' stmt
        | expr ':=' expr
        ;

expr    : NUMBER
        | '(' expr ')'
        ;
```
]
.col2[
Parser LL(1):

```python
def stmt():
    if current_token() == IF:
        next_token()
        cond = expr()
        next_token()
        then = stmt()
        return Node(IF, cond, then)
    elif current_token() == WHILE:
        next_token()
        cond = expr()
        next_token()
        loop = stmt()
        return Node(WHILE, cond, loop)
    elif current_token() in [NUMBER, LPAREN]:
        lvalue = expr()
        assert current_token() == ASSIGN, "Syntax error"
        next_token()
        rvalue = expr()
        return Node(ASSIGN, lvalue, rvalue)
    else:
        assert False, "Syntax error"
```
]
]

Exercici: Implementeu `expr()`.


---

# Generadors d'analitzadors sintàctics

## Analitzadors descendents LL(1)

Inconvenients principals:

- Les produccions no poden tenir prefixos comuns (no sabria quina triar).

    ```
    expr → ID ( expr )
         | ID = expr
    ```

- Les regles no poden tenir recursivitat per l'esquerra (es penjaria).

    ```
    expr → expr + term
         | term
    ```


---

# Generadors d'analitzadors sintàctics

## Analitzadors descendents LL(1)

Comencem amb:

```
expr  → expr '+' term                   💣 prefixos comuns
      | expr '-' term
      | term
```

> ⬇ consolidem de prefixos comuns

```
expr  → expr ('+' term | '-' term)      💣 recursivitat per l'esquerra
      | term
```

> ⬇ instroduim nova regla

```
expr  → expr2
expr2 → '+' term expr2
      | '-' term expr2
      | /* res */
```

> ✅


---

# ANTLR

ANTLR és un analitzador descendent LL(*k*).<br/>
També permet usar `*` i `+` a les regles sintàctiques.

```
expr  → expr '+' term
      | expr '-' term
      | term
```

> ⬇ s'escriu senzillament

```antlr4
expr  : term ('+' term | '-' term) * ;
```

A més, la prioritat dels operadors ve donada per l'ordre d'escriptura:

```antlr4
expr : expr '*' expr
     | expr '+' expr
     | NUM ;
```

I es pot definir fàcilment l'associativitat:


```antlr4
expr : <assoc=right> expr '^' expr
     | NUM ;
```

---

# Exercicis

**P1:** Escriviu gramàtiques no ambigües pels llenguatges següents:

1. El conjunt de tots els mots amb `a`s i `b`s que són palíndroms.

1. Mots que tenen el patró `a*b*` amb més  `a`s que `b`s.

1. Textos amb parèntesis i claudàtors ben aniuats.
<br>Exemple: `( [ [ ] ( ( ) [ ( ) ] [ ] ) ] )`.

1. El conjunt de tots els mots amb `a`s i `b`s tals que a cada `a`
li segueix immediatament per, almenys, una `b`.

1. El conjunt de tots els mots amb `a`s i `b`s amb el mateix nombre d'`a`s que `b`s.

1. El conjunt de tots els mots amb `a`s i `b`s amb un nombre diferent d'`a`s que `b`s.

1. Blocs d'instruccions separades per `;` a la Pascal. Exemple:
<br>`BEGIN instrucció ; BEGIN instrucció ; instrucció END ; instrucció END`.

1. Blocs d'instruccions acabades per `;` a la C.
<br>Exemple: `{ instrucció ; { instrucció ; instrucció ; } ; instrucció ; }`.


---

# Exercicis


**P2:** Especifiqueu les gramàtiques anteriors amb notació ANTLR, modificant la gramàtica si és necessari.


---

# Exercicis

**P3:** Sense utilitzar cap eina ni llibreria (ni `eval`!), escriviu en
Haskell, Python o C++ un analitzador descendent LL(1)
que llegeixi una seqüènica d'expressions i escrigui el resultat de cadascuna d'elles.
[TBD: problema pel Jutge! 😄]

- Entrada:

    ```
    2
    2 * 3
    2 * 3 + 1
    2 * (3 + 1)
    10 - 3 - 2
    13 / 3
    ```

- Sortida:

    ```
    2
    6
    7
    8
    5
    4
    ```


---

# Exercicis

**P4:** Sense utilitzar cap eina ni llibreria, escriviu en
Haskell, Python o C++ un analitzador descendent LL(1)
que llegeixi una seqüènica d'expressions i construeixi i escrigui l'arbre de sintàxi abstracta de cadascuna.
[TBD: problema pel Jutge! 😄]

- Entrada:

    ```
    2 * (3 + 1)
    (10 - 3 - 2) / 4
    ```

- Sortida:

    ```
    (MUL 2 (SUM 3 1))
    (DIV (SUB (SUB 10 3) 2) 4)
    ```




---


class: center, middle


# Arbres de sintàxi abstracta


---

# Accions

- En un analitzador descendent, es poden executar accions
durant el reconeixement de les regles.

    Les accions poden aparèixer en qualsevol punt de la regla:

    ```antlr4
    regla   :   { /* abans */ }
                regla1
                { /* durant */ }
                regla2
                { /* després */ }
            ;
    ```

    → La gramàtica esdevé "imperativa".<br>
    → Les accions s'entrellacen amb la gramàtica.<br>
    → És fàcil entendre què passa i quan passa.


- En un analitzador ascendent, només es poden executar accions
després de reconèixer una regla.


---

# Arbres de sintàxi

.cols5050[
.col1[
Usualment, les accions construeixen una estructura de dades que representa el programa.

→ Separa l'anàlisi de la traducció.<br>

→ Facilita les modificacions tot minimitzant les interaccions.<br>

→ Permet que diferents parts del programa s'analitzin en ordres diferents.

L'estructura de dades resultant sol ser un **arbre de sintàxi:**
]
.col2[
.center[
![:width 20em](img/compis-ast-wiki.png)
]
.right[.xxs[
Figura: [Wikipedia](https://en.wikipedia.org/wiki/Abstract_syntax_tree)
]]
]
]

---

# Arbres de sintàxi concreta *vs* abstracta

**Arbre de sintàxi concreta:** Reflecteix precisament les regles sintàctiques.

**Arbre de sintàxi abstracta** (abstract syntax tree, AST): Representa el programa fidelment, però elimina
i simplifica detalls sintàctics irrellevants.

No és difícil passar del primer al segon.

.cols5050[
.col1[
**Exemple:** Eliminar regles per desambigüar gramàtica.
```antrl
expr    : mexpr ('+' mexpr) * ;
mexpr   : atom  ('*' atom ) * ;
atom    : NUM ;
```

.center[
`3 + 5 * 4`

![:width 15em](img/compis-ast-conc-abs.png)
]
]
.col2[
**Exemple:** Aplanar llistes de paràmetres.

```c
int gcd(int a, int b, int c)
```


.center[
![:width 8em](img/compis-ast-conc-abs-1.png)
&nbsp; &nbsp; &nbsp;
![:width 8em ](img/compis-ast-conc-abs-2.png)
]
]
]


---

# Ús dels ASTs

Un cop construït l'AST, les etapes següents el recorren per a dur a terme les seves tasques:

- L'anàlisi semàntica verificarà l'ús correcte dels elements del programa.

- El generador de codi visitarà l'arbre i li aplicarà regles per generar codi intermig.

- L'intèrpret es passejarà per l'arbre per dur a termes les seves instruccions.




---

# ASTs en ANTLR

A partir de la gramàtica, ANTLR pot generar un analitzador descendent
amb accions que construeixin un AST.

L'AST es pot visitar a través de *visitors* (un patró de disseny).

ANTLR també genera la interfície dels visitadors, tot generant un esquelet
de mètodes que podem heretar.

Cada mètode s'aplica sobre un tipus de node que correspon a cada regla
de la gramàtica.



---

# Exercici

Considereu un LP molt senzill que permet escriure programes com
aquest (que implementa a l'algorisme
d'Euclides per calcular el màxim comú divisor de 105 i 252):

```
a := 105
b := 252
while a != b do
    if a < b then b := b - a
    else a := a - b
end
```

L'únic tipus de dades existent són els enters, amb operacions
aritmètiques de suma i resta. També hi ha operacions relacionals per a
diferent-de i menor-que; aquestes retornen 0 per a fals i 1 per a cert.
 Les instruccions
són l'assignació, la composició seqüèncial de diverses instruccions, el
condicional if-then-else i la iteració while.

1. Definiu, en Haskell uns tipus de dades pels ASTs d'aquest LP.

2. Escriviu l'AST corresponent al programa anterior utilitzant els vostres tipus.

3. Usant la interfície dels ABCs del problema
[P87706](https://jutge.org/problems/P87706), programeu una funció que, donat un
AST que correspon a un programa,  interpreti el programa i retorni  el valor
de cadascuna de les seves variables quan acaba l'execució.
