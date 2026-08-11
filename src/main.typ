#import "@preview/ilm:1.1.2": *
#import "@preview/mousse-notes:1.1.0":*



#import "@preview/ctheorems:1.1.3": *
#show: thmrules

//#set enum(numbering: "(a)")

#set heading(numbering: (..nums) => {
  let vals = nums.pos()
  if vals.len() == 1 {
    // Level 1 (Parts): Roman Numerals
    return numbering("I", vals.first())
  } else if vals.len() == 2 {
    // Level 2 (Sections): Standard integers, ignoring the Part number
    return str(vals.last()) 
  } else {
    // Level 3+ (Subsections): Standard 1.1, 1.2 formatting
    return numbering("1.1", ..vals.slice(1))
  }
})


#show heading.where(level: 1): it => {
  // Force a new page for each Part
  pagebreak(weak: true)
  
  // Vertically center the content
  v(1fr)
  align(center)[
    // Display "Part I", "Part II", etc.
    #text(size: 2em, weight: "regular")[Part #counter(heading).display("I")]
    #v(1em)
    // Display the actual title (e.g., "Quantum Field Theory")
    #text(size: 3em, weight: "bold")[#it.body]
  ]
  v(1fr)
  
  // Force a page break after the title page
  pagebreak(weak: true)
}



// Define the Solution block




#show: ilm.with(
  title: "QFT",
  author: "Chance Emrich",
  date: datetime(year: 2026, day: 26, month: 05),
)


#include("chapters/math/math_toolkit.typ")

#include("chapters/scalar/scalar.typ")
#include("chapters/classical/cft/cft.typ")
#include("chapters/classical/lagrangians/lagrangians.typ")
#include("chapters/classical/noether/classical_symmetries.typ")
#include("chapters/scalar/Quantization and Fock/quantization_and_fock.typ")
#include "chapters/misc/Cross Sections/cross-sect.typ"
#include "chapters/scalar/Propagators/propagators.typ"
#include "chapters/feynman_diagrams/feynman_diagrams.typ"

#include("chapters/vector/scalarqed.typ")

#include("chapters/qed/Lorentz/lorentz_and_spinors.typ")
#include("chapters/qed/QED.typ")



#include("chapters/qcd/non_abelian.typ")

#include("chapters/ew/electroweak.typ")
#include("chapters/renorm/renorm.typ")
#bibliography("chapters/Citations/works.bib", full:true)
