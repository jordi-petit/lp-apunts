
class: center, middle


Llenguatges de Programació

# Elements de Programació Funcional en C++

Jordi Petit

<br/>

![:height 10em](img/c++.png)

<br/>

Universitat Politècnica de Catalunya, 2019

---

# Inferència de tipus

`auto`: crea una variable del tipus
de l'expressió que l'inicialitza.

```c++
auto i = 3;
```

```c++
for (auto x : C) ...
```

```c++
for (auto it = C.begin(); it != C.end(); ++it) ...
```

<br>

`decltype`: denota el tipus d'una expressió.

```c++
int  fun1() { return 10; }
char fun2() { return 'g'; }

decltype(fun1()) x;
decltype(fun2()) y;
```

No s'usa gaire, només en programació genèrica, quan és
impossible expressar tipus que depènen de paràmetres genèrics.

---

# Funcions d'ordre superior

En C + i C++ sempre s'han pogut usar funcions
d'ordre superior:

```c
void qsort(void *v, size_t n, size_t sze, int (*cmp)(const void *, const void*));

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int v[] = {4, 6, 2, 3, 8, 4, 7, 1, 9};
qsort(v, 9, sizeof(int), &cmp);
```

```c++
template <class RandomAccessIterator, class Compare>
void sort (RandomAccessIterator first, RandomAccessIterator last, Compare cmp);

bool cmp(int a, int y) {
    return x > y;
}

vector<int> v = {4, 6, 2, 3, 8, 4, 7, 1, 9};
sort(v.begin(), v.end(), cmp);
```

---

# λ-funcions

```c++
vector<int> v = {4, 6, 2, 3, 8, 4, 7, 1, 9};

sort(v.begin(), v.end(), [](int a, int b) {return a > b;});
```

El tipus del retorn de la funció s'infereix automàticament:

```c++
auto suma = [](double a, double b) {
    return a + b;
};
```

o es pot donar explícitament:

```c++
auto suma = [](double a, double b) -> double {
    return a + b;
};
```

Els paràmetres també es poden inferir, donant lloc a genericitat:

```c++
auto doble = [](auto x) { return x + x; };

cout << doble(66) << endl;
cout << doble(3.1416) << endl;
```

---

# λ-funcions: Captures

**Capturar** consisteix en utilitzar variables de fora de l'àmbit
d'una λ-funció dins la λ-funció:

Es pot capturar per valor o per referència:

|Notació  |  Significat |
|:--------|:------------|
|`[]`|No captura res|
|`[=]`|Captura tot per valor|
|`[&]`|Captura tot per referència|
|`[&a, =b]`|Captura `a` per referència i `b` per valor|
|`[=, &a]`|Captura tot epr valor, excepte `a` per referència|

A més, una λ-funció pot ser `mutable`
per permetre que pugui modificar la seva captura per còpia
(per defecte és `const`).

---

# λ-funcions: Captures

.cols5050[
.col1[
```c++
string salut = "Hola";

auto miss = [=](string nom) {
    cout << salut << ' ' << nom << endl;
}

miss("Jana");
salut = "Eo";
miss("Laia");
```

```bash
Hola Jana
Hola Laia
```
]
.col2[
```c++
string salut = "Hola";

auto miss = [&](string nom) {
    cout << salut << ' ' << nom << endl;
}

miss("Jana");
salut = "Eo";
miss("Laia");
```

```bash
Hola Jana
Eo Laia
```
]
]

--

```c++
int ordena_i_compta_comparacions (vector<int>& v) {

    int c = 0;

    auto cmp = [&](int x, int y) mutable {
        ++c;
        return x < y;
    }

    sort(v.begin(), v.end(), cmp);

    return c;
}
```


---

# El tipus `function`

Un *callable* és qualsevol cosa que es pot invocar:

- funcions de sempre,
- funcions anònimes,
- functors (mètode `()`).

Amb el tipus genèric `function` es poden
envolcallar totes aquestes possibilitats:

```c++
#include <functional>

int suma1(int a, int b) { return a + b; }

auto suma2 = [](int a, int b) { return a + b; };

struct suma3 {
    int operator() (int a, int b) { return a + b; };
};

suma3 sumador;

function<int(int, int)> f;                  // f :: int, int -> in

f = suma1;      cout << f(2, 3) << endl;    // utilitza una funció de sempre
f = suma2;      cout << f(2, 3) << endl;    // utilitza una λ-funció
f = sumador;    cout << f(2, 3) << endl;    // utilitza un functor
```





---

# HOF per PD amb memoització


```c++
#include <iostream>
#include <map>
#include <functional>

using namespace std;

template<class Entrada, class Sortida>
function<Sortida(Entrada)> memoize(function<Sortida(Entrada)> f) {
    map<Entrada, Sortida> m;
    return [=](Entrada x) mutable -> Sortida {   // [=] és important!
        auto it = m.find(x);
        if (it == m.end()) return m[x] = f(x);
        else return it->second;
    };
};

int main(int argc, char** argv) {

    // fibonacci
    function<int(int)> fib = [&](int n) {
        if (n < 2) return n;
        return fib(n - 1) + fib(n - 2);
    };

    fib = memoize(fib);
    for (int i = 0; i < 100; ++i) cout << i << ": " << fib(i) << endl;
}
```

---

# HOFs de std

-   `for_each`

    ```c++
    vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8};
    for_each(v.begin(), v.end(), [](const int&x) { cout << x << endl; });
    ```

-   `transform`

    ```c++
    string s("Marta");
    transform(s.begin(), s.end(), s.begin(), [](char c) { return toupper(c); });
    ```

-   `copy_if`

    ```c++
    vector<int> src = {1, 2, 3, 4, 5, 6, 7, 8};
    vector<int> dst;
    copy_if(src.begin(), src.end(), back_inserter(dst), [](int n) {return n%2 != 0; });
    ```


-   `reduce`

    ```c++
    vector<int> v = {1, 2, 3, 4, 5};
    cout << reduce(v.begin(), v.end(), 1, [](int x, int y) {return x*y;}) << endl;
    ```

- ...



---

# Polítiques d'execució

Les **polítiques d'execució** permeten especificar la paral·lelització
d'algorismes:

- `execution::seq`: no paral·lelitzar
- `execution::par`: paral·lelitzar
- `execution::par_unseq`: paral·lelitzar i vectoritzar


.cols5050[
.col1[
```c++
reduce(execution::seq, v.begin(), v.end());
```

![:height 10em](img/reduce-fig1.png)
]
.col2[
```c++
reduce(execution::par, v.begin(), v.end());
```

![:height 10em](img/reduce-fig2.png)
]
]



.xxs[Imatges: https://blog.tartanllama.xyz/accumulate-vs-reduce/]


---

# Tipus a la Haskell

En C++17, `optional<a>` és el `Maybe a` de Haskell.

```c++
#include <optional>
using namespace std;

optional<string> user_name(int user_id) {
    if (...) return "the name";
    else return {};             // o també nullopt
}

int main() {
    optional<string> name = user_name(1234);
    if (name) cout << *name << endl;
}
```



---

# Tipus a la Haskell

En C++17, `variant<a,b>` és el `Either a b` de Haskell.

Més útil que les `union` de C que no encaixen massa amb el C++.

```c++
#include <variant>
using namespace std;

variant<int, float> num1 = 3;
variant<int, float> num2 = 3.5;

cout << num1.index();           // 0
cout << num1.get<int>;          // 3
cout << num1.get<0>;            // 3
cout << num1.get<float>;        // indefinit
cout << num1.get<1>;            // indefinit
```
