#import "@preview/thmbox:0.3.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#import "@preview/cetz:0.4.2": canvas, draw, tree
#import "common.typ": *

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

= Véletlen bonyolultság osztályok

Volt, hogy $L in #NP$ pontosan akkor, ha létezik polinomiális tanu minden $w
in L$-re.

#definition[RP][
  $L in #RP <==> exists T$ Turing gép amely $w in L$ esetén legalább $1\/2$
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
  Ha $L in #RP$, akkor feltehető, hogy polinomiális ideig működik az őt
  elfogadó Turing-gép.
]<proof-expected-poly-to-poly>

#proof[Megjegyzés][
  RP definíciójából a várható lépésszám polinomiális, tehát $EE(t(w)) <=
  abs(w)^c$ valamilyen $c > 0$-ra.

  A Markov egyenlőtlenség alapján:
  $
    PP(t(w) >= 8 abs(w)^c) < 1/8.
  $

  Kezdjük el futtatni a $T$ Turing-gépet mely a definícióban szerepel. Ha $T$
  leáll $8 dot abs(w)^c$ lépésen belül, akkor azt válaszoljuk amit $T$. Ha
  viszont több mint $8 dot abs(w)^c$ lépésig fut, akkor elutasítunk.

  Figyeljük meg, hogy ha $w in.not L$, akkor nem tudunk tévedni, mivel vagy
  leáll az adott idő alatt és elutasítunk, vagy nem áll le és akkor is
  elutasítunk.

  Ha viszont $w in L$, akkor bajban vagyunk, ezért kétszer futtatjuk $T$-t az
  előző feltételekkel és csak akkor utasítjuk el $w$-t, ha mindkétszer
  elutasítanánk. Annak a valószínűsége, hogy elfogadjuk $w$-t a fenti logika
  szerint legfeljebb $1/2 - 1/8 = 3/8$, mert ha kevesebb mint $8 abs(w)^c$ ideig fut,
  akkor $1/2$ eséllyel elfogadjuk, ha tovább fut akkor elutasítjuk, aminek az
  esélye legfeljebb $1/8$.

  Tehát annak az esélye, hogy egyszer futtatva elfogadjuk $1 - 3/8 = 5/8$. Ha kétszer futtatjuk, akkor 
  $
    (5/8)^2 < 1/2.
  $
]

#remark[
  Az a sejtés, hogy $#RP = #P$. Ezt még nem sikerült bizonyítani, de nem
  sokan lepődnének meg ha valóban így lenne.
]

#remark[
  Érthetően $#P subset.eq #RP subset.eq #NP$.
]

#definition[$#P\/f$][
  $#P\/f$ azon nyelveket jelöli, melyekre létezik egy Turing-gép, ami
  elfogadja a $(w, a)$ párt polinomiális időben, ahol $a$ egy legfeljebb $f(abs(w))$ méretű szó amit
  megsúgunk és csak az input hosszától függ.
]

#remark[
  Az előző definícióban fontos, hogy a súgás kizárólag az input hosszától függ, tehát minden $k$ hosszú inputra ugyanazt a súgást adjuk meg a Turing-gépnek.
]

#remark[
  $#P\/ 1 =^? #P$, ahol $#P\/1$ azt jelenti, hogy mindegyik input hosszhoz
  kizárólag egy betűt/bitet súghatunk.

  A válasz negatív, sőt $#P\/1$-ben nem is mindegyik nyelv rekurzív, nem hogy
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

  Ez a nyelv nyilván nem rekurzív, mert $L$ sem az. Viszont a hossza az
  inputnak egyértelműen meghatározza $x$-et, így az egy bites súgás $x in^? L$
  kérdésre a válasz.
]

#definition[$#P\/"poly"$][
  $
    #P\/"poly" = union.big_(k=1)^infinity #P\/n^k
  $
]

#definition[$#P\/log$][
  $
    #P\/log = union.big_(k=1)^infinity #P\/k dot log n
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
    #RP subset.eq #P \/ "poly"
  $
]

#proof[
  Legyen $L in #RP$, azt kell belátnunk, hogy $L in #P \/ "poly"$. Legyen
  továbbá $n = abs(w)$ és tegyük fel, hogy $Sigma_0 = {0, 1}$.

  Ugye azt kell belátnunk, hogy van polinomiális hosszú súgás, amivel már el
  tudja dönteni egy Turing-gép egy szó tagságát, legyen ez a polinom $p$.
  Így feltehetjük, hogy $L$-et ($#RP$ értelemben) felismerő $T$ Turing-gép egy
  $p(n)$ hosszú véletlen bitsorozatot használ.

  Tehát egy $r in Sigma_0^p(n)$ véletlen bitsorozat meghatározza $T$ működését.

  Azt mondjuk, hogy $S$ _jó_ $L^(=n)$-re, ha $forall w in L^(=n)$-re $exists r
  in S$ úgy, hogy $T$ elfogadja a $(w, r)$ párost. Szavakban annyit jelent,
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
  Ha létezik egy ritka $L$ nyelv ami $#NP$-teljes, akkor $#P = #NP$.
]

#definition[Unáris nyelv][
  Azt mondjuk, hogy az $L$ nyelv unáris, ha $L subset.eq {1}^*$, azaz olyan szavakból áll melyekben csak $1$-es szerepel. (pl.: $1111$ vagy $11$)
]

#theorem[Berman][
  Ha létezik egy unáris $L$ nyelv ami $#NP$-teljes, akkor $#P = #NP$.
]<berman-thm>

#proof[
  #text(red)[*TODO*]

  Mivel $L in #NPC$ ezért a $"SAT"$ nyelv visszavezethető $L$-re.

  Legyen $phi$ egy CNF, mivel $#SAT prop L$, ezért $exists f: phi mapsto
  f(phi)$ leképezés.

  Játszuk azt a játékot, hogy minden lépésben az egyik változóját a $phi$
  CNF-nek lefixáljuk, például az első lépésben lefixáljuk az első változóját
  $phi$-nek úgy, hogy $phi_(x_1 = 1) = phi_1$ avagy $phi_(x_1 = 0) = phi_0$.
  Hasonlóképpen a következő szinteken a következő változókat fixáljuk.

  Ezzel a játékkal a következő fát alkotjuk. Itt minden levélben már csak egy
  $0$ vagy $1$ érték szerepel. Ennek a fának a mélysége $n$ ha $n$ változós a
  $phi$ CNF.

  Figyelem, hogy lehet egy közbülső csúcsnak is már fix az értéke, például ha
  már lefixáltunk egy-egy változót mindegyik klózban igazra.

  #align(center)[
  #canvas({
      import draw: *
      let encircle(i) = {
        std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[
          #move(dx: -0.36em, dy: -1.1em, $#i$)
        ])
      }

      set-style(content: (padding: 0.2em))
      tree.tree(
        ([$phi$], 
          ([$phi_0$], 
            ([$phi_(00)$], $phi_(000)$, $phi_(001)$),
            ([$phi_(01)$], $phi_(010)$, $phi_(011)$)
          ),
          ([$phi_1$], 
            ([$phi_(10)$], $phi_(100)$, $phi_(101)$),
            ([$phi_(11)$], $phi_(110)$, $phi_(111)$)
          ),
        ))
    })
  ]

  Érthetően $phi in #SAT$, ha van igaz értékadása, azaz a fenti fában van olyan
  levél melynek értéke $1$.

  Azt mondom, hogy egy csúcs kielégíthető a CNF fában, ha van $1$-es csúcs az
  alatta lévő részfában.
]

#lemma[
  Ha mélységi bejárást (DFS) végzek a CNF fában, azaz addig megyek ameddig nem találok $1$-es vagy bejárom az egész fát, akkor megállásig vagy $<=n$ darab kielégíthető csúcson mentem át vagy egyen sem.
]

#proof[
  Ha bejártam az egész fát akkor nem találtam egy $1$-es csúcsot sem, tehát
  egyik csúcs sem kielégíthető az egész fában tehát nem járhattam be egyet sem.

  Ha viszont találtam egy $1$-es csúcsot akkor az $1$-es csúcs szülein
  végigmentem, ezek mind kielégíthetők. Mivel DFS-t végzek ezért nem is mentem
  át másik kielégíthető csúcson, mert akkor lementem volna egészen addig a
  csúcsig alatta ami $1$-es.
]

#proof[Berman folytatása][
  Minden $phi$ CNF-hez hozzárendelek egy $f(phi)$ színt. A szíeneim két
  csoportba fognak tartozni: $f(phi) in L$ vagy $f(phi) in.not L$.

  Miközben járom be a CNF-fát DFS-el, számolom a $f(phi)$ színeket. Ha egy
  színt már $(n+1)$-szer láttam, akkor az előző lemmából tudom, hogy ott már
  nem lehet $1$-es csúcs alatta, ezért nem megyek tovább.

  Mivel polinomiálisan sok szín van, mert a visszavezetés polinomiális, és
  mindegyik színt legfeljebb $n$-szer látogatok meg, ezért legfeljebb $n dot
  "poly"(n)$ csúcson mentem át.

  Ennyi cúscs látogatása után már meg agyok győződve, hogy $phi in #SAT$ vagy
  sem. Tehát adtam egy polinomiális algoritmust $#SAT$-ra, tehát $#P = #NP$.
]

#theorem[Fortune][
  Ha létezik egy ritka $A$ nyelv és $overline("SAT") prop A$, akkor $#P = #NP$. \
  Itt a $overline("SAT")$ azt a nyelvet jelöli amiben azon konjunktív normál
  formák vannak, melyeket nem lehet kielégíteni.
]

#proof[
  Mondjuk, hogy $abs(A^(=n)) <= n^c$, ekkor ugyanazt az érvelést követve, mint a
  @berman-thm bizonyításában, ha nem találtunk kielégítő értékadást a fában
  DFS-el, akkor legfeljebb $n dot n^c$ lépést tettünk. Ha viszont találtunk
  kielégítő értékadást, akkor még gyorsabban megtaláltuk mint az előző esetben.
]

#definition[
  Azt mondjuk, hogy a $B$ nyelv $P\/ c log n$ időben visszevezethető az $A$
  nyelvre, ha van olyan Turing-gép, mely $c log n$ méretű súgással $abs(w)$-ben
  polinomiális időben ki tudja számolni $f(w)$, amelyre $w in B <==> f(w) in A$.

  Jelölésben $B prop_(P\/ c log n) A$.
]

#corollary[
  Ha létezik egy ritka $A$ nyelv és $overline("SAT") prop_(P\/c log n) A$, akkor $#P = #NP$.
]<corr-sat-comp-sugas>

#proof[
  A $T$ Turing-gép tippelje meg az $a_(abs(w))$ súgást, ha a $T$ gépg több mint
  $(n+1) abs(A^(=n))$ lépést tesz meg akkor leállítjuk és tippelünk egy új
  súgást.
]

#definition[
  $#NP\/f(n)$ azon $L$ nyelvek osztályát jelöli, melyekre van egy olyan $T$
  nem determinisztikus Turing-gép, mely $w in L$-et egy $f(abs(w))$ méretű
  súgással elfogadja.
]

#lemma[
  Ha létezik egy ritka $A$ nyelv és $A in #NP$, akkor $overline(A) in #NP\/c log n$.
]<lemma-sparse-prop-np-over-clogn>

#proof[
  Legyen a $w$ inputra a $abs(w)$ hosszú szavak száma $A$-ban a súgás, azaz $l
  = abs(A^(=abs(w)))$ és ezt az $l$-et súgjuk, ami $c dot log n$ méretű, mert
  $A$ ritka.

  A $T$ nem determinisztikus Turing-gép (nem determinisztikusan)
  legenerálja az összes $abs(w)$ hosszú szót és mindegyikre leelenörzi, hogy
  eleme-e $A$-nak, így megkapjuk $A^(=abs(w))$-t.

  Ezután végigmegy $A^(=abs(w))$ összes $w_i$ elemén és leelenőrzi, hogy $w_i
  =^? w$. Ha van olyan $i$, melyre $w_i = w$, akkor $w in A => w in.not
  overline(A)$, különben $w in overline(A)$. Ezzel így akkor felismertük
  $overline(A)$-t a súgással.
]

#proof[Mahaney][
  Ha $A in #NPC$ és $A$ ritka, akkor $"SAT" prop A$ és $overline("SAT") prop
  overline(A)$, sőt ez a két visszavezetés ugyanazzal az $f$-el megy.

  A @lemma-sparse-prop-np-over-clogn miatt, ha $A$ ritka és $A in #NP$, akkor
  $overline(A) in #NP\/ c log n$. Tehát $overline("SAT") prop overline(A) in
  #NP\/ c log n$, ami miatt $overline("SAT") in #NP\/c log n$.

  Mivel $A in #NPC$, ezért $overline("SAT") prop_(P\/c log n) A$ és így a
  @corr-sat-comp-sugas miatt $#P = #NP$.
]

#definition[BPP][
  BPP azon $L$ nyelvek osztályát jelöli, melyekre létezik egy randomizált $T$
  Turing-gépt, hogy $w in L$ esetén $> 2/3$ eséllyel elfogad és $w in.not L$
  esetén $< 1/3$ eséllyel fogad el. És a futásidő várhatóan polinomiális.

  A nevét a _Bounded error Probabilistic Polynomial_ kifejezésből kapja.
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
  [$>= 2\/3$],
  [$<= 1\/3$],
  [*Hamis*],
  [$<= 1\/3$],
  [$>= 2\/3$],
)
]

#remark[
  A BPP definíciójában is hasonlóan le lehet cserélni a _várhatóan_
  polinomiális időt konkrét polinomiális időre a @proof-expected-poly-to-poly
  érvelésével.
]

#remark[
  A sejtés az, hogy $#P = #BPP$.
]

#remark[
  Nyilván $#P subset.eq #RP subset.eq #BPP$.
]

#definition[ZPP][
  $
    "ZPP" = #RP inter #coRP
  $
]

#remark[
  A fenti definíció ekvivalens azzal, hogy olyan $L$ nyelvek vannak
  $"ZPP"$-ben, melyekre van olyan $T$ probabilisztikus Turing-gép, mely hiba
  nélkül felismeri $L$-et. És ezt mind várhatóan polinomiális időben teszi meg.

  Az osztály a nevét a _Zero (error) Probabilistic Polynomial_ kifejezésből
  kapja.
]

#remark[
  A tanult Schwartz-Zippel lemma érvén azt kapjuk, hogy a polinom különbség
  feladat $#coRP$-beli. Azaz, azon $L$ nyelv, melyben $(p, q)$ polinom
  párosok vannak, ahol $p equiv.not q$.
]

#proposition[
  Ha a $T$ probabilisztikus Turing-gép azonosan egyenletes eloszlású független
  biteket használ, akkor ekvivalens definíciókat kapunk az előzőkkel.
]

#proof[
  Nem bizonyítjuk.
]

#theorem[Sipser-Gács][
  $
    #BPP in Sigma_2 inter Pi_2
  $
]

#proof[
  #text(red)[*TODO*]
]

#proposition[
  $FF_2^m$ $S_X$ _kevés_ eltolásával fedhető, ha $x in L$. \
  Azaz $abs(S_X) >= (1 - 2^(-n))2^m$. \
  Azaz $exists r_1, dots, r_k in FF_2^m$, ahol $k = ceil(m/n)+1$
  úgy, hogy
  $
    union.big_(i=1)^k (S_X + r_i) = FF_2^m.
  $
]

#proof[
  #text(red)[*TODO*]
]

#pagebreak()
