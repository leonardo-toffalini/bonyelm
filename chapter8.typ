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

= Rendező hálózatok

#definition[Rendező hálózatok][
  #text(red)[*TODO*]
]

#lemma[0--1 lemma][
  Egy rendező háló pontosan akkor rendez jól, ha minden ${0,1}^n$ sorozatot jól rendezi.
]<lemma:01-lemma>

#proof[
  #text(red)[*TODO*]
]

#theorem[Batcher][
  Tudunk adni egy rendező hálót, ami $O(log^2 n)$ párhuzamos időben és $O(n log^2
  n)$ összehasonlítással rendez egy $n$ hosszú sorozatot.
]

#proof[
  Az összefésülő rendezést fogjuk megvalósítani rendező hálózattal és egy kis trükkel.

  + Rekurzívan rendezzük az első és második felét külön-külön az inputnak.
  + Rendezzük a páros indexű elemeket és a páratlan indexűeket külön-külön.
  + Rakjuk helyre a $(2 k - 1, 2k)$ párokat $k = 1, dots, n/2$ -re.

  Nézzük meg a következő ábrát jobb intuícióért.

#figure(
    canvas({
      import draw: *

      scale(x: 20%, y: -20%)

      for x in (0, 2) {
        for y in (0, 2, 4, 6, 8, 10, 12, 14) {
          rect((x, y), (x+2, y+2), fill: none, stroke: 0.5pt)
          content((x+1, y+1), text(8pt)[#{str(x / 2 + y)}])
        }
      }

      rect((10, 6), (12, 4), stroke: 0.5pt, fill: gray)
      rect((8, 8), (12, 6), stroke: 0.5pt, fill: gray)
      rect((8, 16), (12, 12), stroke: 0.5pt, fill: gray)
      rect((10, 12), (12, 10), stroke: 0.5pt, fill: gray)

      rect((8, 16), (12, 0), stroke: 0.5pt)
      line((8, 8),  (12, 8))
      line((10, 0),  (10, 16), stroke: 0.3pt)


      rect((18, 16), (20, 6), stroke: 0.3pt, fill: gray)
      rect((16, 16), (20, 10), stroke: 0.3pt, fill: gray)

      rect((16, 16), (20, 0), stroke: 0.5pt)
      line((16, 8),  (20, 8))
      line((18, 0),  (18, 16), stroke: 0.3pt)


      rect((26, 16), (28, 6), stroke: 0.3pt, fill: gray)
      rect((24, 16), (28, 10), stroke: 0.3pt, fill: gray)

      rect((24, 16), (28, 0), stroke: 0.5pt)
      line((24, 8),  (28, 8))
      line((26, 0),  (26, 16), stroke: 0.3pt)

      for y in (0, 2, 4, 6, 8, 10, 12) {
        line((27, y+1), (25, y+3), mark: (end: ">", scale: 0.5), stroke: 0.75pt)
      }


      rect((32, 16), (36, 8), stroke: 0pt, fill: gray)

      rect((32, 16), (36, 0), stroke: 0.5pt)
      line((32, 8),  (36, 8))
      line((34, 0),  (34, 16), stroke: 0.3pt)
      
    }),
    caption: [Batcher sort sematikus ábra]
  ) <fig:batcher-sort>

  Ha megértettük hogy hogyan működik a Batcher sort, akkor már csak azt kell
  belátnunk hogy valóban jól rendez és elemeznük a futásidejét.

  Kezdjük korrektséggel. A @lemma:01-lemma értelmében elég ${0, 1}^n$
  sorozatokra elemezni. Szerencsére valaki pont úgy rajzolta fel a sematikus
  ábrát, hogy a szürke cellák reprezentálják az $1$-es elemeket, míg a világos
  cellák a $0$-ás elemeket.

  A rendező háló korrektsége praktikusan adja magát az ábrából. Az első két
  lépés után már majdnem jól van rendezve a sorozat, annyi diszkrepanciával,
  hogy a páratlan elemeknél legfeljebb $2$-vel több $1$-es lehet, mint a
  párosoknál. Ezért még végigmegyünk az összes egymás melletti páros-páratlan
  páron és helyre rakjuk őket és készen vagyunk.

  A futásideje a hálónak is könnyen látható. Legyen $T(n)$ az $n$ hosszú
  inputon használt összehasonlításoknak a száma. Ekkor $T(n) = 2 T(n/2) +
  S(n)$, ahol $S(n)$ azt jelöli, hogy hány összehasonlítás kell kettő rendezett
  tömb rendezésére.

  Látszik, hogy $S(n) = 2 S(n/2) + n$, amiről tudjuk, hogy $S(n) = O(n log n)$.

  Innen már evidens, hogy $T(n) = O(n log^2 n)$.

]

#remark[AKS][
  Létezik egy úgynevezett Ajtai--Kolmós--Szemerédi rendező háló, ami $O(log n)$
  párhuzamos időben és $O(n log n)$ összehasonlítással rendez egy $n$ hosszú
  sorozatot.
]

#pagebreak()

