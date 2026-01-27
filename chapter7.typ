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

= VLSI chip tervezés

#remark[
  VLSI = Very Large Scale Integration
]

#definition[VLSI chip][
  A VLSI chip egy négyzetrácson van definiálva a következő tulajdonságokkal:
  - a drótok legalább 1 távolságra vannak egymástól
  - csak négyzetrács vonalait követhetik a drótok
  - egy dróton, egy lépésben, egy bit mehet
  - a drótok Boole függvényeket kiszámoló kapukat kötnek össze
  - a drótok akár processzorokat is összeköthetnek
  - egy kapun áthaladás egy időegységet vesz igénybe
  - a kapuk a csomópontokban vannak
]

#theorem[Thompson][
  Ha $A$ jelöli a chip területét és $T$ a számoláshoz szükséges időt, akkor $A
  dot T >= n^2$ az $"ID"(x, y)$ célfüggvény kiszámolásához.
]<thm-thompson>

#example[
  $O(n)$ időben $O(n)$ területen

  #text(red)[*TODO*]
]

#example[
  $O(log n)$ időben $O(n^2)$ területen

  #text(red)[*TODO*]
]

#proof[@thm-thompson][
  #figure(
    canvas({
      import draw: *

      scale(x: 20%, y: 20%)

      line((0,0), (40,0))
      for x in (0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20) {
        line((x, -0.5), (x, 0.5))
        content((x, -1), text(8pt)[$x_#{str(x/2)}$])
      }

      for x in (22, 24, 26, 28, 30, 32, 34, 36, 38, 40) {
        line((x, -0.5), (x, 0.5))
        content((x, -1), text(8pt)[$y_#{str((x - 20)/2)}$])
      }

      rect((0, 0), (40, 20), stroke: (dash: "dotted"))
      rect((20, 0), (22, 20), fill: gray.transparentize(20%), stroke: 0pt)
      line((21, -4), (21, 24), stroke: (dash: "dashed"))
    }),
    caption: [Thompson segédábra]
  ) <fig:thompson>

  A /*@thm-mehlhorn-schmidt*/ Mehlhorn--Schmidt tétel miatt tudjuk, hogy
  $"ID"(x, y)$ kiszámolásához kell legalább $n$ bit közlés. Tehát a
  segédábrában jelzett középső szaggatott vonalat az egész számítás alatt
  összesen legalább $n$ bitnek kell kereszteznie.
  
  Jelölje $d$ a drótok számát amik keresztezik az ábrában szürkével satírozott
  területet. Az egész számítás alatt összesen $d dot T$ bitet tudunk akkor
  közölni ennyi dróton. Az előbb tárgyaltuk, hogy ennek legalább $n$-nek kell
  lennie, szóval $d dot T >= n$, azaz legalább $n/T$ drót keresztezi ezt a
  területet.

  Hasonló meggondolással állíthatjuk, hogy az $x_9$ és $x_10$ közötti területet
  legalább $(n-1)/T$ drót keresztezi, mert a köztük húzható vonalat legalább
  $n-1$ bit keresztezi, hogy ki lehessen számolni $"ID"(x_1 dots x_(n-1), y_1
  dots y_(n-1))$ -et.

  A keresztezó drótok alsó becslését felírva az összes ilyen csíkra és
  összegezve azt kapjuk, hogy az egész alaptrerületet legalább
  $
    2 sum_(i=0)^n (n - i)/T = 2 (n (n-1))/(2 T) = (n (n - 1))/T
  $
  drót keresztezi. Továbbá az alaptrerület legalább annyi mint ahány drót
  keresztezi, így beláttuk, hogy
  $
    A >= (n (n - 1))/T ==> A dot T >= n^2.
  $

]

#pagebreak()

