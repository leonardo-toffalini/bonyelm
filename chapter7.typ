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

  #text(red)[*TODO*]
]

#pagebreak()

