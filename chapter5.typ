#set text(size: 12pt, font: "New Computer Modern Math")
#set par(justify: true, first-line-indent: 1em)
#set page(margin: 4em, numbering: "1")

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

= Boole-hálózatok

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
  A következő ábra illusztálja, hogy hogyan képzelhetünk el egy Boole-hálót.
  Figyelem, az ábrázolt Boole-hálózat egy fa, viszont lehetnek kereszt élek is,
  azaz irányítatlan körök, csak irányított körök tilosak.

  A legalján vannak az inputok, a legtetején az output. A legalsó szinttől
  egyesével felfele számoljuk ki a szintek értékeit az előző szint
  segítségével.

  #align(center)[
  #canvas({
      import draw: *

      let encircle(i) = {
        std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[
          #move(dx: -0.33em, dy: -0.38em, $#i$)
        ])
      }

      set-style(content: (padding: 0.2em))
      tree.tree(
        ([#encircle($and$)], (
            [#encircle($not$)],
            ([#encircle($and$)], $x_1$, $x_2$),
          ),
          ([#encircle($or$)], 
            ([#encircle($and$)], $x_3$, $x_4$),
            ([#encircle($not$)], $x_5$),
          ),
        ))
    })
  ]
]


#remark[
  Angolul _Boolean-circuit_-nek hívják a Boole-hálózatokat. Létezik olyan is,
  hogy Boolean-network de az teljesen más.
]

#definition[
  A $cal(C)$ Boole-háló mérete a csúcsainak száma.
]

#definition[
  A $cal(C)$ Boole-háló mélysége a leghosszabb $s$--$t$ út hossza, ahol $s$ egy
  input csúcs és $t$ egy output csúcs.
]

#remark[
  Minden $f: {0, 1}^n -> {0, 1}$ Boole függvényt ki lehet számolni $3$ mély,
  exponenciális méretű, Boole-hálózattal, ami csak a $and, or , not$
  függvényeket alkalmazza a belső csúcsokon.
]

#proof[
  Ismert, hogy minden Boole-függvény felírható konjunktív normál forma alakba.
  Tehát, a Boole-hálózat legalsó szintjén az inputokat csoportosítjuk klózokba
  $or$ jelekkel, ahol kell beillesztünk egy $not$ jelet, ha $not x_i$ szerepel
  a klózban. Az alkotott klózokat meg behúzzuk az egyetlen output csúcsba,
  amiben egy $and$ jel szerepel, tehát _össze vagyoljuk a klózokat_.
]

#theorem[
  Adott ${0, 1}$ fölötti $L$ nyelvre $L in P\/"poly" <==> exists cal(C)_1,
  dots, cal(C)_n$ Boole-hálók, hogy $cal(C)_i$ az $i$ inputon _müködik_ és
  $exists c > 0: cal(C)_i$ mérete legfeljebb $i^c$ és $w in L$-et eldönti a
  $cal(C)_(abs(w))$ háló.
]

#proof[

  $<==$: $forall n: abs(w) = n$ a súgás legyen $C_n$. Mivel $C_n$ mérete
  polinomiál ezért $C_n$ leírása is polinomiális és tudunk alkotni egy
  Turing-gépet, amely polinomiális futásidő alatt tudja szimulálni $C_n$
  Boole-háló működését.

  $==>$: Ha $L in P$, akkor létezik olyan $T$ Turing-gép, ami $L$-et eldönti
  polinomiális időben. Feltehető, hogy $T$ egy egyszalagos Turing-gép, mert
  tudjuk, hogy minden Turing-gép szimulálható egy egyszalagossal, persze
  négyzetese lassítással, de ez még belefér a polinomiális futásidőbe.

  Csináljunk úgy, mintha a $T$ egyetlen szalagjára írt input olyan mint $C_n$ 

  Tehát minden mezőre egy lépésről a másikre egy $O(1)$ bemenetű Boole-függvény
  dönte el az új állapotot.

  Mivel $T$ polinomiálisan hosszú ideig fut, ezért legfeljebb polinomiális
  mélységű az így kapott háló.

  Ha $L in #Ppoly$, akkor az első lépésben a szalag úgy néz ki, hogy van a
  szokásos input a szalagon balról jobbra, és ettől az inputtól balra odaírjuk
  még a polinomiális súgást.
]

#corollary[
  Ha kiderülne, hogy $"G3C"$-re nincs őt felismeről polinomiális méretű
  Boole-háló, akkor $#P != #NP$. Mivel így $Ppoly != #NP$ és $#P subset.eq
  #Ppoly$.
]

#definition[
  $
    "PARITY"(x_1, x_2, dots, x_n) = sum_(i=1)^(n) x_i quad (mod 2)
  $

  $
    "MAJORITY"(x_1, x_2, dots, x_n) = cases(
      1 quad "ha " sum x_i > n\/2,
      0 quad "különben"
    )
  $

  $
    "THRESHOLD"_k (x_1, x_2, dots, x_n) = cases(
      1 quad "ha " sum x_i > k,
      0 quad "különben"
    )
  $

  $
    "MOD"_m (x_1, x_2, dots, x_n) = cases(
      1 quad "ha " sum x_i equiv.not 0 quad (mod m),
      0 quad "különben"
    )
  $
]

#remark[
  $2$-mély Boole-hálókra exponenciális méret kell a $"PARITY"$ kiszámolására.
]

#proof[
  Mivel a $"PARITY"$ egy Boole-függvény ezért fel lehet írni konjunktív normál
  formába, így ezt a konjunktív normál formát ki tudjuk számolni Boole-hálóval.
  A következő ábra illusztálja hogy hogyan nézhet ki egy CNF hálója.

  #align(center)[
  #canvas({
      import draw: *
      let encircle(i) = {
        std.box(baseline: 2pt, std.circle(stroke: .5pt, radius: .6em)[
          #move(dx: -0.33em, dy: -0.38em, $#i$)
        ])
      }

      set-style(content: (padding: 0.2em))
      tree.tree(
        ([#encircle($or$)], 
          ([#encircle($and$)], $x_1$, $dots$, $x_(k_1)$),
          ([#encircle($and$)], $x_i$, $dots$, $x_(k_2)$),
          ([#encircle($and$)], $x_j$, $dots$, $x_(k_n)$),
        ))
    })
  ]


  Mivel azon $n$ hosszú bemenetek száma melyekre $1$-et ad a $"PARITY"$-t kiszámoló
  háló $2^(n-1)$, azaz
  $
    abs("PARITY"^(-1)_n (1)) = 2^(n-1),
  $
  ezért nem lehet kevesebb mint $2^n$ csúcsa a hálónak.
]

#remark[
  A $"PARITY"$ nyelvre $log n$-nél mélyebb Boole-hálóra nem megy a
  szuper-polinomiális alsó becslés.
]

#proof[
  Jelöljük a $mod 2$ összeadást $xor$-al, azaz a bináris XOR műveletet. Ekkor,
  ezekkel a $xor$ kapukkal tudunk alkotni egy $log n$ mély Boole-hálót, aminek
  a mérete $O(n)$ a következő módon:

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
          ($xor$, 
            ($xor$,
              ($xor$, $x_1$, $x_2$),
              ($xor$, $x_3$, $x_4$)
            ),
            ([$xor$],
              ($xor$, $x_5$, $x_6$),
              ($xor$, $x_7$, $x_8$),
            ),
          ),
        )
    })
  ]
]

#remark[
  A $"PARITY"$ nyelvet $log n \/ log log n$ mélységben is ki lehet számolni a
  $and, or, not$ jelekkel.
]

#proof[
  TODO
]

#proposition[
  $ log_(log n) n = (log n)/(log log n) $
]

#proof[
  A logaritmus alap átváltás formula révén
  $
    log_a b = (log_c a)/(log_c b) ==> log_(log n) n = (log n)/(log log n).
  $
]

#theorem[Yao--Håstad--Smolensky][
  A $"PARITY"$-t kisszámoló $and, or, not$ kapukat használó $k$-mély Boole-háló
  mérete legalább $ 2^(1/2 n^(1/(2k))). $
]

#proof[
  #text(red)[*TODO*]
]

#remark[
  A bizonyítás a következő cikk alapján hangzott el előadáson:
  #link("https://dl.acm.org/doi/pdf/10.1145/28395.28404")
]

#theorem[
  $ #BPP subset.eq #Ppoly $
]

#proof[
  #text(red)[*TODO*]
]

#pagebreak()
