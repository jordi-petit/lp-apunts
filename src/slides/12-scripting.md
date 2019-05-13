
class: center, middle


Llenguatges de Programació

# Llenguatges de Scripting

Jordi Petit i Albert Rubio

<br/>

![:height 10em](img/scripting.png)

<br/>

Universitat Politècnica de Catalunya, 2019


---

# Llenguatges de scripting

Un llenguatge de *scripting* (de guions) és un llenguatge de programació
destinat a escriure programes que s'integrin i es comuniquin amb altres
programes.


## Continguts

1. Història

1. Motivació

1. Característiques

1. Dominis d'aplicació

1. Exemples



---

# Motivació

L'any 1986, Donald Knuth escriu una contribució
per la columna *Programming Pearls* de la revista *Communications of the ACM*.

Tasca: Escriure un programa per llegir un fitxer de text, determinar les
*n* paraules més freqüents, i escriure una llista d'aquestes paraules en ordre
alfabètic juntament amb la seva freqüencia. .right[👉 Feu-ho en Haskell i Python!]

Knuth va presentar una [solució](https://homepages.cwi.nl/~storm/teaching/reader/BentleyEtAl86.pdf)
en Pascal de 10 pàgines
(ben dissenyada, perfectament comentada usant
*programació literària*
i introduint una nova estrutura de dades).

--

En resposta, Douglas McIlroy va escriure aquest script:

.cols5050[
.col1[
```bash
tr -cs A-Za-z '\n' |
tr A-Z a-z |
sort |
uniq -c |
sort -rn |
sed ${1}q
```
]
.col2[
.sepimg[].sepimg[].sepimg[]
![:height 5em](img/knuth.jpg)
.sepimg[]
![:height 5em](img/mcilroy.jpg)

.sepimg[].sepimg[].sepimg[]
.xxs[Fotos: Domini public]
]]

---

# Història

## Ancestres

- *shell*s: programari que proporciona una interfície al sistema operatiu.

    Exemples: JCL (IBM, 1962), shells de Unix (1970s).

- Processadors de textos i/o generadors d'informes.

    Exemples: RPG (IBM, 1959), sed o awk (Unix, 1974 i 1977).


## Evolucions

-  Rexx (IBM, 1979) o Perl (1987).

-  Altres de propòsit general: Tcl, Python, Ruby, VBScript (Windows)
  i AppleScript (Mac).


---

# Història

## World Wide Web (1990s):

-  Perl més usat per scripting als servidors web.

-  Scripts en Perl van evolucionar a PHP (1995).

-  Perl també va influir el desenvolupament de Python (1991). També
  influït per molts llenguatges de programació.

-  Altres competidors de Perl, PHP i Python (codi obert) són JSP
  (Java Server Pages; per HTML o XML; SUN) i VBScript (Microsoft, 1996).


---

# Característiques

## LSs *vs* LPs tradicionals:

-  Els LS estan pensats per crear aplicacions combinant components.

-  Desenvolupar amb LSs és de 5 a 10 vegades més ràpid.

-  Executar amb LSs és de 10 a 20 vegades més lent.

-  Els LS són normalment interpretats, amb compilació
   *just-in-time* o les dues.

-  Molts LSs són feblement tipats (Excepció: Python).

-  Molts LS tenen tipat dinàmic (Excepció: RPG).

Alguns llenguatges de scripting han evolucionat i poden ser usats com a
llenguatges tradicionals (amb menys eficiència).


---

# Característiques

Compilació *just-in-time* (JIT):

-   Es compila el codi en temps d'execució (a codi màquina o a algun tipus de bytecode)

-   Pot aplicar optimizacions que depenen del context d'execució.

-   Positiu: el codi resultant pot ser molt més eficient.

-   Negatiu: la compilació en execució és ineficient.

-   Es pot aplicar parcialment: només en certes construcions

    Per exemple: expressions regulars (matching).

-   Pot combinar-se amb la compilació (estàtica) a bytecode:

    - Primer es compila el llenguatge a bytecode.
    - S'aplica JIT al bytecode per obtenir codi màquina més eficient.

---

# Característiques

## Característiques principals

-   Permeten tant ús en batch com interactiu.

-   La majoria tracten l'entrada línia a línia.

    Excepció: Perl és dels pocs que usen un compilador just-in-time que
    requereix llegir tot el programa abans de tractar-lo.

-   Altres accepten instruccions per línia de comandes (ex: Rexx,
    Python, Tcl i Ruby).

    Han de poder ser interpretats (sense compilació just-in-time).

    Python, Tcl i Ruby admeten les dues possibilitats.


---

# Característiques

-   Economia d'expressions

    - Afavorir el desenvolupament ràpid i l'ús interactiu.
    - Fort ús de símbols de puntuació i identificadors molt curts (Perl).
    - Més paraules en anglès i menys puntuació (Rexx, Tcl,...).
    - Eviten les declaracions extenses i les estructures de nivell superior

.cols5050[
.col1[
.xxs[Java]
```java
class Hello {
  public static void main(String[] args){
    System.out.println("Hello, world");
  }
}
```
]
.col2[
.xxs[Python]
```python
print("Hello, world!")
```

.xxs[PHP]
```php
Hello, world!
```
]]


---

# Característiques

-   Absència de declaracions. Regles simples d'establiment d'àmbit (*scoping*).

    Declaracions:

    - En molts LS no hi ha declaracions.
    - Per exemple, l'assignació dóna el tipus.

    Àmbit:

    -  En alguns tot és global per defecte (Perl).
    -  En alguns tot és local per defecte (PHP, Tcl).
    -  Pot haver-hi regles com ara que l'assignació defineix la localitat.


---

# Característiques

-   Tipat dinàmic flexible

    Relacionat amb l'absència de declaracions, la majoria dels LS
    són tipats dinàmicament.

    -   En alguns, el tipus d'una variable es comprova just abans de
        ser usada. Ex: PHP, Python, Ruby.

    -   En altres es pot interpretar diferent en diferents àmbits.
        Ex: Rexx, Perl, Tcl.

---

# Característiques

-   Fàcil comunicació amb altres programes

    Donen moltes opcions predefinides per executar programes o
    operacions directament sobre el SO.

    -  entrada/sortida
    -  manipulació de fitxer i directoris
    -  manipulació de processos
    -  accés a bases de dades
    -  sockets (APIs) per comunicacions entre processos
    -  sincronització i comunicació entre processos
    -  protecció i autorització
    -  comunicació en xarxa

---

# Característiques

-  Pattern matching i manipulació de strings sofisticada

    És una de les aplicacions més antigues.

    - Facilita la manipulació de l'extrada i la sortida textual de
    programes externs.

    - Tendeixen a tenir facilitats molt riques per fer pattern
    matching, cerca i manipulació de strings.

    - Normalment és basen en formes esteses de les expressions
    regulars.

---

# Característiques

-  Tipus de dades d'alt nivell

    - S'inclouen com predefinits tipus d'alt nivell com ara:
    sets, bags, maps, lists, tuples,...

    - No es troben en llibreries, sinó que fan part del llenguatge.

    - Per exemple, és habitual tenir arrays indexats per strings com
    part del llenguatge (que s'implementen amb taules de hash).

    -  S'utilitzen *garbagge collectors* per gestionar l'espai.


---

# Dominis d'aplicació

-  Llenguatges de comandes shell.

    Ex: JCL, csh, tcsh, ksh, bash...

    -  Us interactiu.

    -  Processament batch (no molt sofisticats).

    -  manipulació de noms de fitxers, arguments i comandes.

    -  enganxar (*glue*) diversos programes.


---

# Dominis d'aplicació

-  Llenguatges de comandes shell.

    - Exemple bash:

        ```bash
        for f in *.ps
        do
            ps2pdf $f
        done
        ```

    - Exemple bash:

        ```bash
        for arg in "$@"
        do
            index=$(echo $arg | cut -f1 -d=)
            val=$(echo $arg | cut -f2 -d=)
            case $index in
                X) x=$val;;
                Y) y=$val;;
            esac
        done
        ((result=x+y))
        echo "X+Y=$result"
        ```

        `bash exemple.sh X=45 Y=30` dóna `X+Y=75`.

---

# Dominis d'aplicació

-  Processament de textos i generació d'informes.

    Ex: sed, awk, Perl...

    -  Els LS estan fortament orientats al tractament de strings.

    -  Les comandes són strings que es divideixen en paraules.

    -  Els valors de les variables són strings.

    -  se'ns permet extreure substrings.

    -  concatenar i moltes més opcions...

---

# Dominis d'aplicació

-  Processament de textos i generació d'informes.

    - Exemple awk:

        `awk '{print 💲1 " " 💲2 " " (💲1 + 💲2)/2} < notes.txt'`

    - Exemple awk:

        ```awk
        BEGIN {
            print "user\thome"
            FS=":"
        }

        {
            print $1 "\t" $6
        }

        END {
            print "end"
        }
        ```

        `awk -f exemple.awk < /etc/passwd`


---

# Dominis d'aplicació

-  Matemàtiques i estadístiques

    -  Llenguatges com Maple, Mathematica i Matlab.

        -  gran suport pels mètodes numèrics
        -  manipulació simbòlica de formules
        -  visualització de dades
        -  modelat matemàtic.

    Orientats a aplicacions científiques i en l'enginyeria


-  Llenguatges com S i R per computació estadística

    -  Inclou arrays i llistes multidimensionals
    -  funcions de primera classe
    -  laziness (call-by-need)
    -  operacions de selecció (slice) sobre arrays
    -  extensió il$\cdot$limitada (noms, objectes,...)


---

# Dominis d'aplicació

-  Exemple Matlab:

    ```matlab
    % Create and plot a sphere with radius r.
    [x,y,z] = sphere;       % Create a unit sphere.
    r = 2;
    surf(x*r,y*r,z*r)       % Adjust each dimension and plot.
    axis equal              % Use the same scale for each axis.

    % Find the surface area and volume.
    A = 4*pi*r^2;
    V = (4/3)*pi*r^3;
    ```

- Exemple R: Multiplica `[1,2,3]` per `[[3,1,2], [2,1,3], [3,2,1]]`.

    ```
    v1 <- c(1,2,3)
    v2 <- matrix(c(3,1,2,2,1,3,3,2,1), ncol = 3, byrow = TRUE)
    v1 %*% t(v2)
    ```

---

# Dominis d'aplicació

-  Scripting de propòsit general: Perl, Tcl, Python, Ruby


---

# Dominis d'aplicació

-  Llenguatges d'extensió

    Són llenguatges de scripting que permeten fer scripts per una
    determinada aplicació. Exemples:

    -  Per grafics d'Adobe (ex: Photoshop) és poden fer scripts
    JavaScript, Visual Basic (a Windows) o AppleScript (a un Mac).

    -  Per GIMP és poden fer scripts en Scheme, Tcl, Python i Perl.

    -  Per emacs hi ha un dialecte de Lisp anomenat Emacs Lisp (veure
    exemple)

---


# Dominis d'aplicació

-  Exemple: Cridant LUA des de C.

.cols5050[
.col1[
```lua
print "Start"
for i = 1,10 do
    print(i)
end
print "End"
```

]
.col2[
```c
#include <lua.h>

int main() {
    lua_State* L = lua_open();
    lua_baselibopen(L);
    lua_dofile(L, "exemple.lua");
    lua_close(L);
}
```
]]

---

# Dominis d'aplicació


-  Web scripting: Perl, PHP, Python, JavaScript, Cold Fusion, ...

    - Exemple PHP: Pàgina de registre a Jutge.org:

        ```php
        function registration_page () {
            extract(vars());

            $pag->use_captcha = true;

            if (isset($_POST[submit])) {

                $record = array(
                    name            => trim($_POST[name]),
                    email           => trim($_POST[email]),
                    parent_email    => trim($_POST[parent_email]),
                    birth_year      => trim($_POST[birth_year]),
                    country_id      => trim($_POST[country]),
                    agreement       => trim($_POST[agreement]),
                    captcha         => $_POST['g-recaptcha-response'],
                );
                ⋮
            } else {
                $countries = $dbc->Countries->select(country_id, eng_name);
                ⋮
            }
        }
        ```
