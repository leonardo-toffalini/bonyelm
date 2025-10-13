#import "@preview/thmbox:0.3.0": *
// #import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
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

== Boole-hálózatok

#definition[Boole-hálózat][
  A $cal(C)$ egy _Boole-hálózat_, ha egy irányított körmentes gráf (DAG), aminek
  csúcsai címkézettek. Továbbá, a következő speciális csúcsokkal rendelkezik:
  - input csúcsok: $u : d_"in" (u) = 0$
  - output csúcsok: $u : d_"out" (u) = 0$
  - belső csúcsok: minden más.

  A belső csúcsok mindegyikén adott egy Boole függvény, melynek változói a
  beéleken keresztül kapott csúcsok értékei.

  A $cal(C)$ Boole-hálózat inputjaira írunk biteket és az kiszámolja a belső
  csúcsokon lévő Boole-függvények segítségével az értékeket, addig ameddig el
  nem érnek az értékek az output csúcsokba. Az input csúcsok értéke az input,
  az output csúcsok értéke az output.
]

#remark[
  Angolul _Boolean-circuit_-nek hívják a Boole-hálózatokat. Létezik olyan is,
  hogy Boolean-network de az teljesen más.
]

#definition[
  A $cal(C)$ mérete a csúcsainak száma.
]

#definition[
  A $cal(C)$ mélysége a leghosszabb $s$--$t$ út hossza, ahol $s$ egy input
  csúcs és $t$ egy output csúcs.
]

#remark[
  Minden $f: {0, 1}^n -> {0, 1}$ függvényt ki lehet számolni $3$ mély,
  exponenciális méretű, Boole-hálózattal, ami csak a $and, or , not$
  függvényeket alkalmazza a belső csúcsokon.
]

#proof[
  Ismert, hogy minden Boole-függvény felírható konjunktív normál forma alakba.
  Tehát, a Boole-hálózat legalsó szintjén az inputokat csoportosítjuk klózokba
  $or$ jelekkel, ahol kell beillesztünk egy $not$ jelet, ha $not x_i$ szerepel
  a klózban. Az alkozott klózokat meg behúzzuk az egyetlen output csúcsba,
  amiben egy $and$ jel szerepel, tehát _össze vagyoljuk a klózokat_.
]

#theorem[
  Adott ${0, 1}$ fölötti $L$ nyelvre $L in P\/"poly" <==> exists cal(C)_1,
  dots, cal(C)_n$ Boole-hálók, hogy $cal(C)_i$ az $i$ inputon _müködik_ és
  $exists c > 0: cal(C)_i$ mérete legfeljebb $i^c$ és $w in L$-et eldönti a
  $cal(C)_(abs(w))$ háló.
]

