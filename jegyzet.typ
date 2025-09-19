#set page(numbering: "i")

#show heading.where(level: 1): set text(size: 18pt)
#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt) 
#show heading.where(level: 1): set block(below: 1em)
#show heading.where(level: 2): set block(below: 1em)

#align(center+horizon, text(22pt)[
  *Bonyolultságelmélet jegyzet*

  #text(12pt)[
    Készítették Grolmusz Vince előadásai alapján a 2025/25. évi hallgatók
  ]

  #text(12pt)[
    (Nem hivatalos lektorálatlan verzió)
  ]

  #text(12pt)[
    2025. ősz
  ]
])
#pagebreak()

#outline()
#pagebreak()

#set page(numbering: "1")
#include "chapter1.typ"
#pagebreak()

#include "chapter2.typ"

