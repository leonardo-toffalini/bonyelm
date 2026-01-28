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

= Pszeudovéletlen számok
#text(red)[*TODO*]

Pszeudovéletlen sorozatok

#example[Eltolás regiszter][
  Az eltolás regiszterek a következő módon vannak definiálva. Legyen $f :
  {0,1}^n -> {0,1}$ egy könnyen számolható függvény. Egy $n$ bites $a_0, a_1,
  dots, a_(n-1)$ magból kiindulva, kiszámoljuk a $a_n, a_(n+1), a_(n+2), dots$
  biteket az

  $
    a_k = f (a_(k-1), a_(k-2), dots, a_(k-n))
  $

  rekurzióval. Az „eltolás regiszter" név abból a tulajdonságból származik, hogy
  csak $n+1$ bitet kell eltárolnunk: miután eltároltuk $f (a_0, dots,
    a_{n-1})$-t $a_n$-ben, nincs szükségünk többé $a_0$-ra és eltolhatjuk
  $a_1$-t $a_0$-ba, $a_2$-t $a_1$-be stb. Legfontosabb eset, mikor $f$ egy
  lineáris függvény a $2$-elemü test felett, a továbbiakban ezzel foglalkozunk.

  Bizonyos esetekben az eltolás regiszter által generált bitek véletlennek
  látszanak, legalábbis egy darabig. Természetesen az $a_0, a_1, dots$
  sorozatban egy idő után ismétlödik valamely $n$ egymás utáni bit, és innentól
  periodikus lesz a sorozat. Ennek viszont nem kell $a_(2^n)$ elött
  bekövetkeznie, és valóban, választható olyan lineáris függvény, melyre a
  sorozat periódusa $2^n$.

  A problémát az jelenti, hogy a sorozatnak van más rejtett szerkezete is a periodicitáson kívül. Valóban, legyen

  $
    f (x_0, dots, x_(n-1)) = b_0 x_0 + b_1 x_1 + dots b_(n-1) x_(n-1)
  $

  (ahol $b_i in {0,1})$. Tegyük fel, hogy nem ismerjük a $b_0,
  dots, b_(n-1)$ együtthatókat, viszont az eredményül kapott sorozatnak
  ismerjük az első $n$ bitjét $(a_n, dots, a_(2 n-1))$. Ekkor
  tekintsük a következő, 2-elemü test feletti lineáris egyenletrendszert $n$
  egyenlettel és $n$ ismeretlennel:

$
  b_0 a_0 + b_1 a_1 + dots b_(n-1) a_(n-1) &= a_n \
  b_0 a_1 + b_1 a_2 + dots b_(n-1) a_n &= a_(n+1) \
  &dots.v \
  b_0 a_(n-1) + b_1 a_n + dots b_(n-1) a_(2 n-2) &= a_(2 n-1)
$


  Ekkor, ha egyértelmüen meghatároztuk a $b_i$-ket, akkor meg tudjuk mondani minden további $a_(2 n), a_(2 n+1), \ldots$ elemét a sorozatnak.

  Előfordulhat persze, hogy az egyenletrendszer megoldása nem egyértelmű, mert
  az egyenletek összefüggenek. Például, ha a $0, 0, dots, 0$ magból indultunk,
  akkor az egyenletek nem mondanak semmit. Megmutatható viszont, hogy egy
  véletlen magból indulva az egyenletek pozitív valószínűséggel meghatározzák a
  $b_i$-ket. Tehát a sorozat első $2 n$ elemének ismeretében a többi „nem
  látszik véletlennek” már egy olyan megfigyelő számára sem, aki egy viszonylag
  egyszerű (polinom idejű) számítást akar csak elvégezni.
]

#example[Lineáris kongruencia-generátor][
  A gyakorlatban legfontosabb pszeudovéletlenszám-generátorok a
  lineáris kongruencia generátorok. Egy ilyen generátor három pozitív egész
  paraméterrel van megadva ($a, b$ és $m$). Az $X_0$ magból kiindulva, melyre
  $0 <= X_0 <= m-1$, a generátor az $X_1, X_2, dots$ egészeket a

  $ X_i=a X_(i-1) + b quad (mod m) $

  rekurzióval számolja. Eredményként használhatjuk az $X_i$-ket, vagy pl. a
  középső bitjeiket.
]

#remark[
  Az derül ki, hogy ezen generátorok által kapott sorozatok is megjósolhatók
  polinom idejü számolással, polinom darab sorozatelem felhasználásával. Ám
  ezen algoritmusok nagyon bonyolultak, így gyorsaságuk és egyszerüségük miatt
  a lineáris kongruencia generátorok jók a legtöbb gyakorlati alkalmazásban.
]

#example[
  Utolsó példaként nézzük a kettes számrendszerbeli alakját pl. a $sqrt(5)$-nek:
  $ sqrt(5) = 10.001111000110111 dots $
]

#remark[
  Ez a sorozat eléggé véletlenszerünek látszik. Természetesen nem használhatjuk
  mindig ugyanazt a számot, de választhatunk mondjuk egy $n$-bites $a$ egészet
  és ekkor legyen a kimenet $sqrt(a) - floor(sqrt(a))$.

  Sajnos ez a módszer is "feltörhetó" nagyon bonyolult (viszont polinom idejǘ)
  algoritmikus számelméleti módszerekkel.
]

#definition[$#NEGL\(n)$][
  Azt mondjuk, hogy egy $f: ZZ^+ -> RR$ függvény elhanyagolható, ha minden fix
  $k$-ra $n -> infinity$ esetén $n^k f(n) -> 0$.
]

#remark[
  Szavakkal, $f$ gyorsabban tart $0$-hoz mint bármelyik polinom reciproka.

  Jelöljük ezt (a nagy $O$-hoz hasonlóan) úgy, hogy $ f(n) = #NEGL\(n). $

  Figyeljük meg, hogy egy elhanyagolható függvény bármilyen polinommal megszorozva elhanyagolható marad, azaz
  $
    n^r dot #NEGL\(n) = #NEGL\(n)
  $
  minden fix $r$ esetén.
]

#definition[Generátor][
  Tekintsünk egy polinom időben számítható $G : {0,1}^∗ -> {0,1}^∗$ függvényt,
  melyre feltesszük, hogy $abs(G(x))$ csak $abs(x)$-től függ és $abs(x) <
  abs(G(x)) < abs(x)^c$ egy $c$ konstansra. Egy ilyen függvényt hívunk
  _generátornak_.
]

#definition[Teszt][
  Legyen $cal(A)$ egy polinom idejű randomizált algoritmus (Turing-gép), amely
  bármely $z$ bemenetre kiszámít belőle egy $cal(A)(z)$ bitet (a kimenetnél a
  $0$ jelentése, hogy „nem véletlen”, míg az $1$ jelentése, hogy „véletlen”
  volt a bemenet).
]

#definition[Sikeres teszt][
  Rögzítsünk le egy $n >= 1$ számot. Válasszuk $x$-et egyenletesen
  ${0,1}^n$-ből és $y$-t egyenletesen ${0,1}^N$-ből, ahol $N = abs(G(x))$. Feldobunk
  egy érmét és az eredménytől függően vagy $G(x)$-et vagy $y$-t adjuk meg $cal(A)$-nak
  bemenetként. Akkor hívjuk $cal(A)$-t sikeresnek (ezekre a véletlen választásokra
  nézve), ha vagy $G(x)$ volt a bemenet és $0$ a kimenet, vagy pedig $y$ volt a
  bemenet és $1$ a kimenet.

  Tehát helyesen felismerte a teszt, hogy a valódi véletlen számot adtuk-e vagy a generáltat.
]

#definition[Biztonságos véletlenszám-generátor][
  Egy $G$ generátor (biztonságos) pszeudovéletlenszám-generátor, ha minden
  polinom idejű randomizált $cal(A)$ algoritmusra, melynek bemenete egy $z$ 0-1
  sorozat és kimenete egy $cal(A)(z)$ bit, annak valószínűsége, hogy $cal(A)$
  sikeres, legfeljebb $1/2 + #NEGL\(n)$.
]

#remark[
  Ez a feltétel azt jelenti, hogy $G(x)$ átmegy minden „értelmes” (polinom
  időben számolható) teszten abban az értelemben, hogy annak valószínűsége,
  hogy a teszt felismeri, hogy $G(x)$ nem valódi véletlen, elhanyagolhatóan
  nagyobb csak $1/2$-nél.
]

#proposition[
  Ha $#P = #NP$, akkor nincs biztonságos polinomiális idejű véletlenszám-generátor.
]

#definition[Egyirányú függvény][
  Egy $f : {0,1}^* -> {0,1}^*$ függvényt egyirányúnak nevezünk, ha
  + létezik egy $c >= 1$ konstans, melyre $abs(x)^(1/c) < abs(f(x)) < abs(x)^c$;
  + $f(x)$ számolható polinom időben;
  + minden $cal(A)$ polinom idejű randomizált algoritmusra, mely 0-1
    sorozatokat számol 0-1 sorozatokból, és egy véletlen y sorozatra, mely
    egyenletesen véletlenül van választva $\{0,1\}^n$-ból, teljesül:
    $
      PP [ f( cal(A)(f(y)) ) = f(y) ] = #NEGL\(n).
    $
]

#definition[Egyirányú permutáció][
  Az egyirányú permutáció egy olyan egyirányú függvény, mely bijekció és
  $abs(f(x)) = abs(x)$ minden $x$ esetén.
]

#theorem[
  Tegyük fel, hogy $f$ egyirányú permutáció. Ekkor ebből alkothatő egy $g$
  biztonságos véletlenszám-generátor.
]

Kandidátusok egyirányú függvényre

Négyzetgyökvonás prím és összetett modulussal, szorzás

#pagebreak()

