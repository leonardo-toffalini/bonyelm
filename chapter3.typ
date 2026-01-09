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

= Interaktív bizonyítások
#example[
  Interaktív protokoll gráf _nem_ izomorfizmusra.

  Artúrnak vagy két gráfja $G$ és $G'$ melyekről el szeretné dönteni, hogy
  izomorfak-e. Artúr csak egy buta halandó ember, akkor is ha király, csak
  polinomiális idejű algoritmust tud lefuttatni a fejében. Szerncsére Merlin
  okosabb mint Artúr és a saját mágiájával bármit ki tud számolni a fejében egy
  lépés alatt, viszont nem feltétlenül mond mindig igazat.

  Artúr a két gráf közül kiválaszt egy gráfot, permutálja a csúcsok számozását,
  és megkérdezi Merlintől, hogy melyik gráfot mutatja most éppen. Amire Merlin
  megmondja, hogy $G$ vagy $G'$ a mutatott gráf.

  Ha a két gráf izomorf, akkor Merlinnek sincs esélye kitalálni melyik gráfot
  mutatja éppen Artúr, és így legfeljebb tippelhet.

  Tehát Artúr megkérdezi Merlint a fent leírt módon $100$-szor, hogy a jelenleg
  mutatott gráf melyik. Ha Merlin mindegyik alkalommal jól válaszolt akkor vagy
  nem izomorf a két gráf és így Merlinnek egyértelmű melyik mutatja Artúr, vagy
  végig tippelt és így $1/2^100$ eséllyel mindig pont jót mondott.

  Azaz, a gráf _nem_ izomorfizmusra a fent leírt protokoll egy interaktív
  bizonyítás.
]

#definition[Interaktív protokoll][
  Azt szeretnénk eldönteni, hogy egy adott $w$ szóra és $L$ nyelvre $w in^? L$.

  A bizonyítást Merlin és Artúr együtt fogják végezni. Merlin bizonyít, míg
  Artúr ellenőrzi Merlin bizonyításait. Artúr egy randomizált Turing-gép, míg
  Merlin bármit ki tud számolni az input alapján egy lépés alatt.

  Először Merlin szól és mond egy polinomiális hosszú üzenetet. Erre Artúr
  Merlin üzenete és $w$ függvényében polinomiálisan sok véletlen számot
  felhasználva válaszol. Ezt az interakciót megismételi a két fél amíg Artúr el
  nem szánja magát és vagy elfogadja a $w$ szót vagy elutasítja.

  Azt mondjuk, hogy a protokoll elfogadja az $L$ nyelvet, ha $w in L$ esetén
  van olyan Merlin, hogy Artúr legalább $1 - 1/2^abs(w)$ valószínűséggel
  elfogadja $w$-t, és $w in.not L$ esetén minden Merlin esetén Artúr legfeljebb
  $1/2^abs(w)$ valószínűséggel fogadja el $w$-t, azaz téved.
]

#definition[IP osztály][
  $
    "IP" := { L: quad w in L"-et interaktív protokollal lehet bizonyítani" }
  $
]

#example[
  $"NP" subset.eq "IP"$
]

#proof[példa][
  $w in L in "NP"$, tehát létezik egy polinomiális tanu $w in L$-re. Ha pont
  ezt a polinomiális tanut válaszolja Merlin akkor az egy jó egylépéses protokoll.
]

#theorem[
  $
    "IP" subset.eq "PSPACE"
  $
] <ip-in-pspace>

A bizonyítás előtt bevezjük a következő segítő fogalmat.

#definition[Protokoll fa][
  A protokoll fa egy fix $L$ nyelvre és fix $w$ szóra az összes lehetséges
  Artúr--Merlin interakciót ábrázolja egy faként a következő módon.

#align(center)[
  #let nodes = (
    (0, 0),
    (0.5, 1),
    (1, 1),
    (1.5, 1),
    (0, 1),
    (-0.5, 1),
    (-1, 1),
    (-1.5, 1),
    (-0.5, 2),
    (0, 2),
    (-1, 2),
  )
  #let edges = (
    (0, 1),
    (0, 2),
    (0, 3),
    (0, 4),
    (0, 5),
    (0, 6),
    (0, 7),
    (5, 8),
    (5, 9),
    (5, 10),
  )

  #diagram({
    for (i, n) in nodes.enumerate() {
      node(n, "", stroke: 0.5pt, name: str(i), radius: 5pt)
    }

    for (from, to) in edges {
      let bend = if (to, from) in edges { 10deg } else { 0deg }
      // refer to nodes by label, e.g., <1>
      edge(label(str(from)), label(str(to)), "-|>", bend: bend)
    }

    node((-1.1, 0.3), "Merlin", stroke: 0.0pt, radius: 5pt)
    node((-1.4, 1.4), "Artúr", stroke: 0.0pt, radius: 5pt)
    node((-1.4, 1.4), "Artúr", stroke: 0.0pt, radius: 5pt)
    node((-0.5, 4.7), "elutasít vagy elfogad", stroke: 0.0pt, radius: 5pt)
    node((3.4, 1.4), "üzenetek", stroke: 0.0pt, radius: 5pt)
    node((2.9, 1.45), "", stroke: 0.0pt, radius: 5pt, name: str(98))
    node((-0.5, 4), "", stroke: 0.5pt, radius: 5pt, name: str(99))
    edge(label(str(8)), label(str(99)), "--", stroke: 0.2pt)
    edge(label(str(98)), label(str(9)), "-->", stroke: 0.5pt)
    edge(label(str(98)), label(str(3)), "-->", stroke: 0.5pt)
  })
  ] \
]

#remark[
  Habár egy szinten exponenciálisan sok csúcs lehet, ezt a gráfot be tudjuk
  járni polinomiális tárban, mert polinomiális mélységű.
]

#proof[#ref(<ip-in-pspace>)][
  Képzeljük el az interaktív bizonyítást protokoll fáját. Tudjuk, hogy minden
  levélben Artúr elfogad vagy elútasít, mert végetért a bizonyítás.

  Az a célunk, hogy kiszámoljuk, hogy a gyökérben mekkora valószínűséggel
  fogadja el Artúr az adott bizonyítást a protokoll mentén. Ehhez az összes
  csúcsra kiszámoljuk, hogy onnan mekkora valószínűséggel fogadja el Artúr a
  bizonyítást.

  A levelekben tudjuk, hogy $0$ vagy $1$ a valószínűség, mert ott már vagy elfogadta vagy elutasította.

  Merlinnek az a célja, hogy maximalizálja az elfogadási valószínűséget, míg
  Artúr súlyozottan átlagolja valószínűségeket, mivel Artúr válaszai egy
  érmedobás után szólnak.

  Ezért, ha Artúr válaszol akkor vegyük a súlyozott átlagát a lehetséges
  válaszoknak az efogadási valószínűségét, ha viszont Merlin válaszol akkor a
  maximális elfogadási valószínűséget adjuk meg.

  Bár egy csúcsnak lehet exponenciálisan sok gyereke, a protokoll fa mélysége
  polinomiális. Ezért rekurzívan ki tudjuk számolni a gyökér elfogadási
  valószínűségét a gyökerelktől kezdve polinomiálist tárban.
]

#theorem[Shamir][
  $
    "IP" = "PSPACE"
  $
] <shamir>

A bizonyításhoz először bevezetünk pár segédfogalmat és bizonyítunk valamit
róluk. A tétel bizonyítása és segéd állítások az eredeti cikk alapján lettek
feldolgozva, ami elérhető a következő linken:
#link("https://dl.acm.org/doi/pdf/10.1145/146585.146609")

#definition[Egyszerű tqbf][
  Azt mondjuk, hogy a $phi$ teljesen kvantifikált Boole-formula _egyszerű_, ha minden $x_i$ változójára igaz, hogy $x_i$ kvantálásának helye és előfordulásának helye között legfeljebb egy darab univerzális kvantor ($forall$) van.
]

#example[
  A következő formula egy egyszerű tqbf:
  $
    phi = forall x_1 forall x_2 exists x_3 [(x_1 or x_2) and forall x_3 (x_2
  and x_3 and x_3)].
  $

  A következő formula nem egy egyszerű tqbf, mivel a kékkel jelölt
  $text(fill: #blue, x_1)$ változó kvantálása és második használata (negáltja)
  között kettő pirossal jelölt univerzális kvantor ($text(fill: #red, forall)$) is van.
  $
    phi = forall text(fill: #blue, x_1) text(fill: #red, forall) x_2 [(x_1 and
  x_2) and text(fill: #red, forall) x_3 (text(fill: #blue, overline(x)_1) and
  x_3)]
  $
]

#lemma[
  Minden teljesen kvantifikált Boole-formula egyszerű alakra hozható polinomiális időben.
]

#proof[
  Ha az eredeti tqbf nem egyszerű akkor van egy első $x_i$ változó melynek
  a kvantálása és használata között több mint egy univerzális kvantor van.
  Ebben az esetben nézzük meg az első használatát $x_i$, mely már sérti a
  feltételt és cseréljük le $x_i$-t $exists x_i^1 [(x_i and x_i^1) or
  (overline(x)_i and overline(x)_i^1)]$.

  Tehát $x_i$ kvantálása utáni első univerzális kvantor után létrehozunk egy új
  változót, $x_i^1$, mely értéke pont $x_i$.

  Ezeket a módosításokat addig csináljuk amíg egyszerű formulához nem jutunk .
]

#definition[Formula aritmetizáltja][
  Egy teljesen kvantifikált Boole-formulához rendelt aritmetizáltja egy
  aritmetikai kifejezés, melyet úgy kapunk, hogy a formulában a következő
  előfordulásokat a megadott párjukra cseréljük le:
  $
    &"True" |-> 1,     quad &"False" |-> 0,       quad &x |-> x \
    &x or y |-> x + y, quad &x and y |-> x dot y, quad &overline(x) |-> (1 - x) \
  $
  A kvantorok viszont a következőképpen cseréljük le:
  $
    forall x (dots) |-> product_(x in {0, 1}) (dots) quad exists x (dots) |->
  sum_(x in {0, 1}) (dots)
  $
]

#remark[
  Az aritmetizált értéke egy egész szám.

  Nyilván látszik, hogy a teljesen kvantifikált Boole-formula pontosan akkor
  igaz, ha az aritmetizáltja nem nulla.
]

#example[
  $
    phi = forall x_1 exists x_2 [(x_1 and x_2) or exists x_3 (overline(x)_2 and
  x_3)].
  $

  Ennek a tqbf-nek aritmetizáltja a következő:
  $
    f = product_(x_1 in {0, 1}) sum_(x_2 in {0, 1}) [(x_1 dot x_2) + sum_(x_3
  in {0, 1})(1 - x_2) dot x_3].
  $
]

Figyeljük meg, hogy $phi$ aritmetizáltja nem feltétlenül egy polinomiális
méretű szám, a következő példa mutatja hogy $2^2^n$ nagyságú is lehet:
$
  product product ... product (dots) >= 2^2^n,
$
ahol a belső $(dots)$ kifejezés $>= 2$ és $n$ darab produktum szerepel egymás
mellett.

#proposition[
  Ha $0 < f < 2^2^n$, $f in ZZ$, akkor $exists p$ prím úgy, hogy $2^n < p < 2^(2n)$és $f equiv.not 0 (mod p)$.
]

#proof[
  Tegyük fel, hogy $f != 0$. Ha $f equiv 0 (mod p_i)$ minden $2^n < p_i <
  2^(2n)$, akkor a Kínai maradék tétel miatt $f equiv 0 (mod Pi p_i)$.

  A prímszám tétel azt állítja hogy ha $pi(x)$ jelöli a az $x$-ig terjedő prímszámok számát, akkor
  $
    pi(x) tilde x/log(x).
  $

  A mi esetünkben $2^n$ és $2^(2n)$ közé eső prímek száma a következő:
  $
    2^(2n)/log(2^(2n)) - 2^n/log(2^n) = 2^(2n)/(2n) - 2^n/n >= 2^n.
  $

  Ebből az következik, hogy a $2^n$ és $2^(2n)$ közötti prímek szorzata
  legalább $(2^n)^2^n = 2^(n 2^n) >= 2^2^n$. Viszont $f <= 2^2^n$, ezért nem
  lehet $0$ modulo egy nagyobb szám mint $2^2^n$. \
  Ezzel ellentmondásra jutottunk és emiatt valóban létezik egy ilyen prím.

  Ha viszont $f = 0$, akkor bármilyen prím jó, mert $f equiv 0 (mod p)$ bármilyen $p$-re.
]

#definition[
  Azt mondjuk, hogy $f$ aritmetizáltnak a funkcionális formája $f(x_1)$, amit
  úgy kapunk, hogy $f$-ben szereplő első $Pi_x_1$ avagy $Sigma_x_i$ jelet
  eltörlünk és így már a kifejezés függ $x_1$ értékétől és egy függvényt
  kapunk.
]

#example[
  Tekintsük a következő igaz tqbf-et:
  $
    phi = forall x_i [overline(x)_1 or exists x_2 forall x_3 (x_1 and x_2) or x_3].
  $
  Ennek a tqbf-nek az aritmetizáltja a következő:
  $
    f = product_(x_1 in {0, 1}) [(1 - x_1) + sum_(x_2 in {0, 1}) product_(x_3 in {0, 1}) (x_1 dot x_2 + x_3)],
  $
  melynek értéke $2$. Ezen aritmetizált funkcionális formája a következő:
  $
    f(x_1) = [(1 - x_1) + sum_(x_2 in {0, 1}) product_(x_3 in {0, 1}) (x_1 dot x_2 + x_3)].
  $

  Egy mindenható Merlin persze egyből megmondja, hogy $f(x_1) = x_1^2 + 1$.
]

Egy tqbf aritmetizáltja exponenciálisan nagy fokszámú polinom is lehet, például
$
  phi = forall x_1 forall x_2 dots forall x_n (x_1 or x_2 or dots or x_n)
$
aritmetizáltja
$
  f = product_(x_1 in {0, 1}) product_(x_2 in {0, 1}) dots product_(x_n in {0, 1}) (x_1 + x_2 + dots x_n),
$
melynek funkcionális formájában $2^(n-1)$-ed fokon fog szerepelni $(x_1 + c)$ tag. Nyilván ilyen komplikált polinomokat Artúr nem tud kezelni.

#proposition[
  Ha $phi$ egy egyszerű tqbf, akkor az aritmetizáltjának a funkcionális formája $f(x_1)$ egy polinom melynek foka legfeljebb lináris $phi$ méretében.
]

#proof[
  Mivel $phi$ egy egyszerű tqbf, ezért $x_1$ kvantálása és használata között legfeljebb egy univerzális kvantor lehet. A polinom fokát csak a szorzások befolyásolják és ebből legfeljebb egy lehet $x_1$ előtt ami duplázza $x_1$ fokát.
]

#proof[$" IP" = "PSPACE"$][
  Azt bizonyítjuk hogy interaktív protokollt tudunk adni a TQBF nyelv
  felismerésére. Az előbb láttuk hogy minden tqbf hozható _egyszerű_ tqbf
  alakra, továbbá azt is hogy egy tqbf pontosan akkor igaz, ha aritmetizáltja
  nem nulla. Azt is láttuk, hogy ha $f != 0$, akkor van egy intervallumon egy
  prím amire $f equiv.not 0 (mod p)$.

  Tehát a következőben csak arra adunk interaktív protokollt, hogy egy egyszerű
  tqbf aritmetizáltja $f equiv.not 0 (mod p)$.

  *Interaktív protokoll*

  A protokoll azt fogja bizonyítani, hogy $f equiv.not 0 (mod p)$, ahol $f$ már
  $phi$-nek az aritmetizáltja.

  1. Először Merlin elküldi $f (mod p)$ értékét Artúrnak és a funkcionális
     formáját egyszerű polinom alakra hozva $f(x_1)$.

  2. Ha Merlin egy $product$ törlésével kapta a függvényt, akkor Artúr ellenőrzi,
     hogy $f(0) dot f(1) equiv f (mod p)$, ha viszont $sum$ törlésével kapta
     akkor azt ellenőrzi, hogy $f(0) + f(1) equiv f (mod p)$.

    Miután Artúr ellenőrizte $f$-et és $f(x)$-et, véletlenül választ $xi in {0,
    1, ..., p-1}$ számot és behelyettesíti $xi$-t és megkapja az $f(xi)$
    kifejezést. Merlinnek elküldi $f(xi)$-t miután leszedte az első kvantort.

  3. Erre Merlinnek meg kell adnia egyszerű polinom alakra hozva a funkcionális formáját.

  4. Artúr ellenőrzi, hogy visszakapja-e $f(xi)$-t a $0-1$ behelyettsítéssel és
     összeggel/szorzattal, a letörölt kvantortól függően.

  5. A protokoll így folytatódik tovább míg ki nem ürül a kifejezés.


  Ha Merlin becsületesen játszik, akkor Artúr mindig elfogad. 

  Ha viszont Merlin csal, akkor csak ott van értelme csalnia hogy $f$
  értékéről hazudik. Ekkor viszont $f(x)$ polinomot is meg kell hamisítani vagy
  különben egyből lebukna Artúr egyszerű ellenörzésével. Tehát Merlin $f$
  helyett $f'$-t mond.

  Feltéve hogy $f equiv.not f' (mod p)$, akkor
  $
    PP((f - f')(xi) = 0) approx 1/2^n,
  $
  azaz annak a valószínűsége, hogy a két polinom értéke pont megegyezik
  $xi$-ben exponenciálisan kicsi. Mivel $p > 2^n$  különböző szám lehet $xi$ és
  $f - f'$ fokszáma lineáris $n$-ben.

  Következik, hogy annak a valószínűsége, hogy a sok csalás után megússza
  Merlin $1/2^n$.
]


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

  +
    - Ha azt kell bizonyítania Merlinnek, hogy $G tilde.eq H$, akkor felfordítja
       az összes lapot és elmondja a permutációt amivel újra cimkézte a
       csúcsokat. Ezzel Artúr meg tud győződni, hogy valóban izomorf a két gráf.

    - Ha viszont $H$-ban kell mutatnia Merlinnek egy Hamilton-kört, akkor felfedi csak azokat az éleket amik Hamilton-kört alkotnak.
]

#proof[
  Az előző bizonyítás valóban egy zero knowledge proof, mivel ha Merlin ismert
  egy Hamilton-kört $G$-ben, akkor erről meggyőződött Artúr. Ha Merlin nem
  ismert egy Hamilton-kört $G$-ben, akkor még Artúr kérdése előtt el kellett
  döntenie, hogy vagy egy valid izomorf gráfot kreál vagy egy valid Hamilton
  kört, ami nem izomorf $G$-vel. Mivel Merlin nem tudja előre Artúr kérdését
  ezért mindig $1 \/ 2$ eséllyel lebukik.

  Másrészről, Artúr nem tudott meg semmi többet a Hamilton körről mint, hogy
  létezik, mivel akkor is amikor Merlin mutat neki egy Hamilton-kört akkor is
  csak $H$-ban mutat fel $n$ élet ami $n$ csúcsot tartalmaz, de azt még a
  halandó Artúr is tudja, hogy egy Hamilton kör $n$ élből és $n$ csúcsból áll.
]

#pagebreak()
