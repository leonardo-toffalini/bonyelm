#set page(numbering: "i")

#set text(font: "Times New Roman")

#show heading.where(level: 1): set text(size: 18pt)
#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt) 
#show heading.where(level: 1): set block(below: 1em)
#show heading.where(level: 2): set block(below: 1em)

#align(center+horizon, text(22pt)[
  *Bonyolultságelmélet jegyzet*

  #text(12pt)[
    Készítették Grolmusz Vince előadásai alapján a 2025/26. évi hallgatók
  ]

  #text(12pt)[
    (Nem hivatalos lektorálatlan verzió)
  ]

  #text(12pt)[
    #datetime.today().year()-#datetime.today().month()-#datetime.today().day()
  ]
])

#pagebreak()

#outline()
#pagebreak()

#set page(numbering: "1")
#include "chapter1.typ"

#include "chapter2.typ"

#include "chapter3.typ"

#include "chapter4.typ"

#include "chapter5.typ"

#include "chapter6.typ"

#include "chapter7.typ"

#include "chapter8.typ"

#include "chapter9.typ"

#include "chapter10.typ"

#include "chapter11.typ"

