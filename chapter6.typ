#import "@preview/thmbox:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#import "@preview/cetz:0.4.2": canvas, draw, tree
#import "common.typ": *
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
  _Feladat:_ *input:* $a_1, dots, a_n in NN$, *output:* $max a_i$

  $n^2$ processzorral meg tudunk adni egy $O(1)$ algoritmust.

  Csinálunk egy $b$ auxillary tömböt. Minden $i != j$ index párosra egy
  processzorral kiszámoljuk $a_i <^? a_j$-t. Ha $a_i < a_j$, akkor $b[i] = *$.
  Egy lépés alatt az $n^2$ processzor elvégzi az összes összehasonlítást. A
  végén csak a maximális elemnél nem lesz $*$.

  Csak akkor szeretne ugyanoda írni két processzor ha ugyanazt akarják írni,
  így ez nem lesz probléma.
]

#example[
  _Feladat:_ *input:* $a_1, dots, a_n in NN$, *output:* $max a_i$

  $n$ processzorral meg tudunk adni egy $O(log log n)$ algoritmust.

  Bontsuk fel az $n$ elemet $sqrt(n)$ darab $sqrt(n)$ méretű részre. Ha
  kiszámultuk mindegyik rész maximumját, akkor már csak a kapott $sqrt(n)$
  maximum maximumját kell kiszámolnunk, amit $n$ processzorral tudunk $O(1)$
  időben.

  Legyen $T(n)$, hogy mennyi idő $n$ elem maximumát kiszámolni $n$
  processzorral. Most láttuk, hogy $T(n) = T(sqrt(n)) + 1$.
  
  Tegyük fel, hogy $n = 2^k$. Ekkor $T(n) = T(2^k) = T(2^(k/2))$. Legyen $S(k)
  = T(2^k)$. Ekkor $S(k) = S(k/2) + 1$, innen már egyből látszik, hogy $S(k) =
  O(log k)$.

  Mivel $k = log n$ és $T(n) = S(k)$ ezért $T(n) = O(log log n)$.
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
  Ha egy $L$ feladatot $n^(O(1))$ processzorral $log^(O(1)) n$ időben ki tudok
  számolni, akkor az $L$ feladat $"NC"$-ben van (_Nick's Class_).
]

#example[
  Két $n$ hosszú vektor skaláris szorzata $n$ processzorral $log n$ időben.

  $a, b in NN^n$, kell $a dot b in NN$.
]

#proof[
  $a_i b_i$ szorzatok $O(1)$. Összeadások mint egy teljes bináris fa $=> log n$
]

#example[
  Mátrix-mátrix szorzás $n k m$ processzorral $O(log m)$ időben.

  $A in NN^(n times m)$, $B in NN^(m times k)$, kell $A B = C in NN^(n times k)$.
]

#proof[
  A mátrix-mátrix szorzás pontosan $n k$ darab skaláris szorzás, ahol $C_(i
  j)$-t pontosan úgy kapom, hogy $A$-nak az $i$-edik sorát és $B$-nek a
  $j$-edik oszlopát skalárisan szorzom.

  Mivel mindegyik cellájára a $C$ eredmény mátrixnak tudok szolgáltatni $m$
  darab processzort és egy cella értékét két $m$ hosszú vektor skaláris
  szorzata határozza meg, ezért $O(log m)$ időben készen vagyok.
]

#example[
  Positív élsúlyokkal rendelkző $G$ gráfban minden kezdő csúcsra és minden
  végső csúcsra a legrövidebb út keresése $n^3$ processzoral $O(log n log log
  n)$ időben. (_All Pairs Shortest Paths_)
]

#proof[
  Definiáljuk a következő műveletet két mátrix között $A plus.circle B$, ahol
  $
    (A plus.circle B)_(i, j) := min_(k = 1, dots n) {a_(i k) + b_(k j)}.
  $

  Nyilvánvaló, hogy egy ilyen műveletet ki tudunk számolni $O(log log n)$
  időben, ha van $n^3$ processzorunk, mert minden eredmény cellára adunk $n$
  processzort és ott már $n$ elem minimumát $n$ processzorral $O(log log n)$
  időben el tudjuk végezni.

  Vegyük észre, hogy $A^(n) := overbrace(A plus.circle A plus.circle dots
    plus.circle A, n)$ pont azt adja meg, hogy milyen hosszú két csúcs között a
  legrövidebb út. Ezt már láttuk algoritmuselméleten a Floyd--Warshal algoritmusnál.

  Figyeljük meg, hogy $A^(n)$-et ki tudjuk számolni $O(log n)$ művelettel úgy
  hogy kiszámoljuk a kettő hatványokat sorrendben: $A^(1), A^(2), A^(4), A^(8),
  dots, A^(n)$.

  Tehát összesen $O(log n)$ darab műveletet kell elvégeznünk, melyek mind
  $O(log log n)$ időben mennek, tehát $O(log n log log n)$ a végső idő.
]

Emlékezzünk vissza, hogy $2$ mély és exponenciális méretű Boole hálózattal ki
tudunk számolni bármilyen Boole függvényt. Ennek a következménye, hogy
exponenciálisan sok processzorral minden Boole függvényt ki tudunk számolni
$O(1)$ időben.

#theorem[Csánky--Berkowitz][
  Egy $A in RR^(n times n)$ mátrix determinánsát ki lehet számolni $n^5$
  processzorral $log^2 n$ időben, csak összeadásokkal és szorzásokkal.
]

#proof[
  Ez a bizonyítás Csisztovtól származik. \ segédanyag: #link("https://www.cs.cornell.edu/courses/cs6820/2022fa/Handouts/Chistov.pdf")

  #text(red)[*TODO*]
]

#corollary[
  Páros gráfban teljes párosítás létezését el tudjuk dönteni ugyanannyi
  erőforrással amennyi kell determináns számoláshoz.
]

#proof[
  Legyen
  $
    C_(i,j) := cases(x_(i,j) &quad "ha" (v_i v_j) in E, 0 &quad "különben")
  $

  Tehát az adjecencia mátrix, csak ahelyett hogy $1$-et írnánk az élek helyére
  egy változót írunk. Ha ennek a mátrixnak kiszámoljuk a determinánsát, akkor
  kapunk egy többváltozós függvényt. Ez a függvény pontosan akkor nem lesz
  azonosan nulla függvény, ha van teljes párosítás a gráfban.

  Azt, hogy egy függvény nem azonosan nulla le tudjuk tesztelni $#RP$
  értelemben a Schwartz lemmával.
]

#proposition[
  Adott $n$ számot tudunk rendezni $n$ processzorral $O(log^2 n)$ időben.
]

#proof[
  Az összefésülő rendezést fogjuk párhuzamosan megcsinálni. Tehát $m$ elemet
  úgy rendezek, hogy az első felét és a második felét külön-külön rendezem és utána összefésülöm.

  Hogyan fésülök össze két $m$ hosszú rendezet sorozatot $O(log m)$ időben $O(m)$ processzorral?

  Állítsunk egy-egy processzort minden elemre a két $m$ hosszú sorozatból.
  Mindegyik processzor megkeresi, hogy a hozzá rendelt elem hol lenne a másik
  tömbben bináris kereséssel. Ha az egyik sorozatban az $i$-edik elem a másik
  sorozatban a $j$-edik elem lenne, akkor az összefésült sorozatban az $(i + j
  - 1)$-edik lesz. Tehát be is szúrjuk a megfelelő helyére az elemet.

  Tehát minden elemet be tudok szúrni egyszerre $O(log m)$ időben az összefésült sorozatba.

  Továbbá az összefésülő rendezés mindig felez és így $O(log n)$ szintje lesz,
  és minden szinten összesen $n$ elemet kell összefésülni, tehát az
  összefésülések költsége $O(log n)$ minden szinten. Tehát eredményként
  $O(log^2 n)$ lépés alatt tudtunk rendezni egy sorozatot $n$ processzorral.

]

#pagebreak()
