#import "@preview/thmbox:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#show: thmbox-init()

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

== Zero Knowledge Proofs
#definition[Zero Knowledge Proof][
  Egy zero knowledge proof (ZK) két szereplő interakcója: Merlin (a bizonyító)
  és Artúr (az ellenörző).

  Egy ZK-nak a következő három tulajdonságot kell teljesítenie:
  + Ha a bizonyítandó állítás igaz, akkor egy őszinte Artúrt meg tudja győzni
    egy őszinte Merlin.

  + Ha az állítás hamis, akkor még csalással sem tudja Merlin meggyőzni Artúrt,
    legfeljebb egy kis valószínűséggel téved Artúr.

  + Ha az állítás igaz, akkor Artúr nem tud meg semmi extra információt azon
    kívül hogy igaz az állítás Merlin bizonyításából.
]

#remark[
  Az első két feltétel tehát csak annyit jelent, hogy ez egy interaktív
  bizonyítás. A lényeg pont az hogy Artúr nem tud meg semmi mást azon kívül
  hogy igaz az állítás.
]

#example[Gráf nem izomorfizmus][
  Adott két gráf $G_1, G_2$ és el szeretnénk dönteni, hogy $G_1 tilde.eq.not G_2$.

  Artúr újra címezi a csúcsokat és megmutatja az egyik gráfot. Erre Merlinnek
  meg kell mondania, hogy $G_1$-et vagy $G_2$-t mutatta fel Artúr.
]

#example[Hamilton kör létezése][
  Adott egy $G$ gráf, mely ismert Merlin és Artúr számára is. Merlinnek be kell
  bizonyítania, hogy ő ismer egy Hamilton-kört $G$-ben.

  + Merlin újra címezi $G$ csúcsait egy permutációval, ezzel létrehoz egy $H$
    gráfot, mely persze izomorf $G$-vel.
  + Fölírja $H$ éleit egy-egy lapra és fejjel lefelé elhelyezi őket az asztalra
    és mostmár nem nyúlhat hozzájük addig amíg Artúr meg nem engedi.
  + Most Artúr a következő kettő eset közül választ: \
    - Merlin, bizonyítsd be, hogy $H$ valóban izomorf $G$-vel.
    - Merlin mutasd meg a Hamilton-körödet $H$-ban.

  1. Ha azt kell bizonyítania Merlinnek, hogy $G tilde.eq H$, akkor felfordítja
     az összes lapot és elmondja a permutációt amivel újra cimkézte a
  csúcsokat. Ezzel Artúr meg tud győződni, hogy valóban izomorf a két gráf.

  2. Ha viszont $H$-ban kell mutatnia Merlinnek egy Hamilton-kört, akkor felfedi csak azokat az éleket amik Hamilton-kört alkotnak.
]

#proof[
  Az előző bizonyítás valóban egy zero knowledge proof, mivel ha Merlin ismert
  egy Hamilton-kört $G$-ben, akkor erről meggyőződött Artúr. Ha Merlin nem
  ismert egy Hamilton-kört $G$-ben, akkor még Artúr kérdése előtt el kellett
  döntenie, hogy vagy egy valid izomorf gráfot kreál vagy egy valid Hamilton
  kört, ami nem izomorf $G$-vel. Mivel Merlin nem tudja előre Artúr kérdését
  ezért mindig $1 \/ 2$ eséllyel lebukik.

  Másrészről, Artúr nem tudott meg semmi többet a Hamilton körről mint, hogy létezik, mivel akkor is amikor Merlin mutat neki egy Hamilton-kört akkor is csak $H$-ban mutat fel $n$ élet ami $n$ csúcsot tartalmaz, de ezt már eddig is tudta Artúr.
]

#pagebreak()
= Véletlen bonyolultság osztályok

Volt, hogy $L in "NP"$ pontosan akkor, ha létezik polinomiális tanu minden $w
in L$-re.

#definition[RP][
  $L in "RP" <==> exists T$ Turing gép amely $w in L$ esetén legalább $1\/2$
  eséllyel elfogad és $w in.not L$ esetén $1$ valószínűséggel elutasít.

  Ezt mind várhatóan polinomiális időben.
]

#remark[
  A következő táblázat ilusztrálja az esetek valószínűségét:

  // You can also import those.
#import table: cell, header
#let green = rgb(200, 255, 200)
#let red = rgb(255, 200, 200)

#table(
  columns: (1fr, 1fr, 1fr),
  align: center,
  header(
    [#align(right)[*Válasz*]#align(left)[*Valóság*]],
    [*Igaz*],
    [*Hamis*],
  ),
  [*Igaz*],
  [$>= 1\/2$],
  [$<= 1\/2$],
  [*Hamis*],
  [$0$],
  [$1$],
)
]

#remark[
  Ha $L in "RP"$, akkor feltehető, hogy polinomiális ideig működik az őt
  elfogadó Turing-gép.
]

#proof[Megjegyzés][
  RP definíciójából a várható lépésszám polinomiális, tehát $EE(t(w)) <=
  abs(w)^c$ valamilyen $c > 0$-ra.

  A Markov egyenlőtlenség alapján:
  $
    PP(t(w) >= 8 abs(w)^c) < 1/8.
  $

  Kezdjük el futtatni a $T$ Turing-gépet mely a definícióban szerepel. Ha $T$
  leáll $8 dot abs(w)^c$ lépésen belül, akkor azt válaszoljuk, amit $T$. Ha
  viszont több mint $8 dot abs(w)^c$ lépésig fut, akkor elutasítunk.

  Figyeljük meg, hogy a $w in.not L$, akkor nem tudunk tévedni, mivel vagy
  leáll az adott idő alatt és elutasítunk, vagy nem áll le és akkor is
  elutasítunk.

  Ha viszont $w in L$, akkor kétszer futtatjuk $T$-t az előző feltételekkel és csak akkor utasítjuk el $w$-t, ha mindkétszer elutasítanánk. Ekkor annak az esélye, hogy így is elutasítjuk, az
  $
    (5/8)^2 < 1/2.
  $

]

#remark[
  Az a sejtés, hogy $"RP" = "P"$. Ezt még nem sikerült bizonyítani, de nem
  sokan lepődnének meg ha valóban így lenne.
]

#remark[
  Érthetően $"P" subset.eq "RP" subset.eq "NP"$.
]

#definition[$"P"\/f$][
  $"P"\/f$ azon nyelveket jelöli, melyekre létezik egy Turing-gép, ami
  elfogadja a $w, a$ párt polinomiális időben, ahol $a$ egy legfeljebb $f(abs(w))$ méretű szó amit
  megsúgunk és csak az input hosszától függ.
]

#remark[
  Az előző definícióban fontos, hogy a súgás kizárólag az input hosszától függ, tehát minden $k$ hosszú inputra ugyanazt a súgást adjuk meg a Turing-gépnek.
]

#remark[
  $"P"\/ 1 =^? "P"$, ahol $"P"\/1$ azt jelenti, hogy mindegyik input hosszhoz
  kizárólag egy betűt/bitet súghatunk.

  A válasz negatív, sőt $"P"\/1$-ben nem is mindegyik nyelv rekurzív, nem hogy
  polinomiális időben felismerhető nyelvek.

  A bizonyításhoz tekintsünk egy tetszőleges nem rekurzív nyelvet a ${0, 1}$
  ábécé fölött, ilyen nyilván van mert majdnem mindegyik nyelv nem rekurzív.
  Mivel megszámlálhatóan sok Turing-gép van és mindegyik Turing-gép legfeljebb
  egy nyelvet ismer fel és megszámlálhatatlanul sok nyelv van adott ábécé
  fölött, ezért madjnem minden nyelv _nem_ rekurzív.

  A ${0, 1}$ ábécé fölötti $L$ nyelvet felfoghatjuk úgy mint a természetes
  számok egy részhalmazát $L subset.eq NN$, ahol egy szó egy természetes szám
  bináris alakja. Eltekintve attól hogy mit kezdünk a kezdő nullásokkal...

  Legyen $K$ az a nyelv, amiben a $overbrace(1 1 1 1 1 dots dots 1 1 1 1 1, x)$
  szavak vannak, ahol $x in L$. Tehát $K$ egy unáris nyelv ahol pontosan az $x$
  hosszú szavak vannak, ahol $x in L$.

  Ez a nyelv nyilván nem rekurzív, mert $L$ sem az.
]

#definition[$"P"\/"poly"$][
  $
    "P"\/"poly" = union.big_(k=1)^infinity "P"\/n^k
  $
]

#definition[$"P"\/log$][
  $
    "P"\/log = union.big_(k=1)^infinity "P"\/k dot log n
  $
]

#definition[$L^(=n)$][
  $
    L^(=n) = L inter Sigma_0^n
  $
  Tehát $L$-nek a pontosan $n$ hosszú szavai.
]

#theorem[Adleman][
  $
    "RP" subset.eq "P" \/ "poly"
  $
]

#proof[
  Legyen $L in "RP"$, azt kell belátnunk, hogy $L in "P" \/ "poly"$. Legyen
  továbbá $n = abs(w)$ és tegyük fel, hogy $Sigma_0 = {0, 1}$.

  Ugye azt kell belátnunk, hogy van polinomiális hoszzú súgás, amivel már el
  tudja dönteni egy Turing-gép egy szó tagságát, legyen ez a polinom $p$.
  Így feltehetjük, hogy $L$-et ($"RP"$ értelemben) felismerő $T$ Turing-gép egy
  $p(n)$ hosszú véletlen bitsorozatot használ.

  Tehát egy $r in Sigma_0^p(n)$ véletlen bitsorozat meghatározza $T$ működését.

  Azt mondjuk, hogy $S$ _jó_ $L^(=n)$-re, ha $forall w in L^(=n)$-re $exists r
  in S$ úgy, hogy $T$ lefogadja a $(w, r)$ párost. Szavakban annyit jelent,
  hogy $S$ bitsorozatok halmaza, melyben van olyan bitsorozat amellyel $T$
  elfogadja $w$-t.

  Nyilván $S = Sigma_0^(p(n))$ jó, mivel ebben benne van az összes $p(n)$
  hosszú bitsorozat. A továbbiakban ezt a halmazt szeretnénk szűkíteni.

  Tudjuk, hogy adott $w in L^(=n)$-re annak a valószínűsége, hogy $T$
  elutasítja $w$-t véletlen $r$-el az legfeljebb $1 \/ 2$.

  Ha $S$ pontosan $k$ darab véletlen $p(n)$ hosszú bitsorozatból áll, akkor
  annak a valószínűsége, hogy $T$ elutasítja $w$-t minden $r in S$ bitsorozatra
  az legfeljebb $1 \/ 2^k$.

  Így annak a valószínűsége, hogy $exists w in L^(=n)$, hogy $T$ elutasítja
  $w$-t minden $r in S$ bitsorozatra, az
  $
    < abs(L^(=n))/2^k <= 2^n/2^k.
  $
  Ha $k = n + 1$, akkor az előző legfeljebb $1\/2$. Mivel ez a valószínűség
  kisebb $1$-nél ezért kell léteznie egy olyan bitsorozatnak a $k$ közül ami jó
  az összes $w$-re.

  Tehát adott $n$ hosszú $w$ inputra súgni fogunk egy $k$ bitsorozatból álló
  $S$ halmazt, amit képzelhetünk úgy mint $k$ darab $p(n)$ bitsorozat
  konkatenálva, mert az osztály definíciójában csak egy bitsorozatot súghatunk.
  Látjuk, hogy a súgás mérete $k dot p(n)$, ami polinomiális $n$-ben.

  Végül lefuttatjuk mind a $k$ darab $p(n)$ hosszú bitsorozatra $T$-t.
]

#definition[Ritka nyelv][
  Azt mondjuk, hogy $L$ ritka, ha $exists c > 0$ úgy, hogy $forall n$
  $abs(L^(=n)) <= n^c$.
]

#theorem[Mahaney][
  Ha $L$ ritka és $"NP"$-teljes, akkor $"P" = "NP"$.
]

#definition[Unáris nyelv][
  Azt mondjuk, hogy az $L$ nyelv unáris, ha $L subset.eq {1}^*$, azaz olyan szavakból áll melyekben csak $1$-es szerepel. (pl.: $1111$ vagy $11$)
]

#theorem[Berman][
  Ha $L$ unáris és $"NP"$-teljes, akkor $"P" = "NP"$.
]<berman-thm>

#proof[
  #text(red)[*TODO*]
]

#lemma[
  DFS a CNF fában, akkor megállásig vegy $n$ darab kielégíthető csúcson mentem át vagy nullán... #text(red)[*TODO*]
]
#proof[kinda trivi.]

#theorem[Fortune][
  Ha $A$ egy ritka nyelv és $overline("SAT") prop A$, akkor $"P" = "NP"$. \
  Itt a $overline("SAT")$ azt a nyelvet jelöli amiben azon konjunktív normál
  formák vannak, melyeket nem lehet kielégíteni.
]

#proof[
  Mondjuk, hogy $abs(A) <= n^c$, ekkor ugyanazt az érvelést követve, mint a
  @berman-thm bizonyításában, ha nem találtunk kielégítő értékadást a fában
  DFS-el, akkor legfeljebb $n dot n^c$ lépést tettünk. Ha viszont találtunk
  kielégítő értékadást, akkor még gyorsabban megtaláltuk mint az előző esetben.
]

