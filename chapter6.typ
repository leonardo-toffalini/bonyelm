#import "@preview/thmbox:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#import "@preview/cetz:0.4.2": canvas, draw, tree
#show: thmbox-init()

#let P = $"P"$
#let NP = $"NP"$
#let Ppoly = $"P"\/"poly"$

#let definition = definition.with(
  variant: "Definíció"
)

#let theorem = theorem.with(
  variant: "Tétel"
)

#let remark = remark.with(
  variant: "Megjegyzés"
)

#let corollary = corollary.with(
  variant: "Következmény"
)

#let example = example.with(
  variant: "Példa"
)

#let proposition = proposition.with(
  variant: "Állítás"
)

= Párhuzamos algoritmusok

#example[
  Feladat: *input:* $a_1, dots, a_n in NN$, *output:* $max a_i$

  $n^2$ processzorral meg tudunk adni egy $O(1)$ algoritmust.

  Csinálunk egy $b$ auxillary tömböt. Minden $i != j$ index párosra egy
  processzorral kiszámoljuk $a_i <^? a_j$-t. Ha $a_i < a_j$, akkor $b[i] = *$.
  Egy lépés alatt az $n^2$ processzor elvégzi az összes összehasonlítást. A
  végén csak a maximális elemnél nem lesz $*$.

  Csak akkor szeretne ugyanoda írni két processzor ha ugyanazt akarják írni,
  így ez nem lesz probléma.
]

#example[
  Feladat: *input:* $a_1, dots, a_n in NN$, *output:* $max a_i$

  $n$ processzorral meg tudunk adni egy $O(log log n)$ algoritmust.

  Bontsuk fel az $n$ elemet $sqrt(n)$ darab $sqrt(n)$ méretű részre. Ha
  kiszámultuk mindegyik rész maximumját, akkor már csak a kapott $sqrt(n)$
  maximum maximumját kell kiszámolnunk, amit $n$ processzorral tudunk $O(1)$
  időben.

  Legyen $t(n)$, hogy mennyi idő $n$ elem maximumát kiszámolni $n$
  processzorral. Most láttuk, hogy $t(n) = t(sqrt(n)) + 1$. Ezt a rekurziót
  kifejtve azt kapjuk, hogy $t(n) = t(n^(1/(2^i))) + i$.

  Ha $i = log log n$, akkor $n^(1/(2^i)) = 1$. Tehát $t(n) = O(log log n)$.

]

#definition[PRAM][
  A PRAM-nek van $n$ processzora és mindegyik processzor egy külön RAM, amit
  processzornak hívunk, és van egy közös (globális) memóriája. A közös memóriát
  egész számokkal indexelünk és $M$-nek jelöljük, tehát a memória cellái:
  $dots, M[-2], M[-1], M[0], M[1]1, M[2], dots$

  A közös memóriába tetszőleges egész számok írhatóak, tehát $forall i M[i] in ZZ$.

  Egy számítási lépés a következő három szakaszból áll:
  1. Mindegyik processzor olvashat legfeljebb $1$ cellát $M$-ből.
  2. Mindegyik processzor számolhat.
  3. Mindegyik processzor írhat legfeljebb $1$ cellát $m$-be.

  A közös memóriába konkurrens írásokat hogyan oldunk fel?
  - Illegális egyszerre több processzornak ugyanabba a globális memória címbe
    írnia.
  - Csak akkor megengedett ha a konkurrens írások megegyeznek.
  - Mindegyik processzornak van egy prioritása és a konkurrens írásoknál a
    legmagasabb prioritású processzor írása marad.

  A PRAM inputja $M$-ben adott és ide is várjuk az output-ot.

  A PRAM egy lépését annak számoljuk, hogy a processzorok párhuzamosan olvasnak, számítanak, és írnak egyet.
]

#remark[
  Jelölje egy adott feladat megoldására szükséges időt $p$ processzorral $t_p$. Ekkor $t_1/p <= t_p$.
]

#proof[
  Tegyük fel, hogy $p t_p < t_1$, ez azt jelenti, hogy ha egy processzorral
  szimuláljuk $p$ processzor párhuzamos működését az gyorsabb lenne mint $t_1$,
  de pont úgy definiáltuk $t_1$-et, hogy ez a minimális idő hogy $1$
  processzorral megoldjuk a feladatot.
]

#corollary[
  Az előző miatt egy exponenciális algoritmushoz legalább exponenciálisan sok
  processzor kell, hogy polinomiális idejű algoritmust kapjunk.
]

#definition[NC][
  Ha egy $L$ feladatot $n^(O(1))$ processzorral $log^(O(1)) n$ időben ki tudok számolni, akkor az $L$ feladat $"NC"$-ben van (Nick's Class).
]

#example[
  Két $n$ hosszú vektor skaláris szorzata $n$ processzorral $log n$ időben.

  $a, b in NN^n$, kell $a dot b in NN$.
]

#proof[
  $a_i b_i$ szorzatok $O(1)$. Összeadások mint egy teljes bináris fa $=> log n$
]

#example[
  Mátrix-mátrix szorzás

  $A in NN^(n times m)$, $B in NN^(m times k)$, kell $A B = C in NN^(n times k)$.
]

