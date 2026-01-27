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

= Döntési fák
#text(red)[*TODO*]

definicio

Döntési fa rendezésre $>= n log n$ mély

algo konvex burok keresesre

algebrai dontesi fa def

$n$ csucs kozul konvex burkat megkeresni linearis teszt fv-el $Omega(n log n)$ mely algebrai dontesi faval

Milnor--Thom tetel

Egyszeru dontesi fa def

zarkozott Boole fv def

graf of eldontese zarkozott

teljes csucs letese zarkozott

$D(f), D_0(f), D_1(f)$ def

peldak ezek ertekeire: OR, teljes csucs

Tardos tetel: $D(f) <= D_0(f) dot D_1(f)$

Ha f egy N elemű halmazon veszi fel az 1 értéket, és N=2^k M, ahol M már páratlan, akkor az f-et
kiszámoló bármely egyszerű döntési fa mélysége legalább n-k.

Szimmetrikus Boole fv

Minden nem konstans szimmetrikus Boole fv zarkozott

Gyenge szimmetria

Aanderaa--Karp--Rosenberg sejtes: Minden nem konstns monoton gyengen szimmetrikus Boole fv zarkozott


#pagebreak()

