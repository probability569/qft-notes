#import "@preview/ctheorems:1.1.3": *
// macros.typ

#import "@preview/feyndrawgram:1.0.0": feyndrawgram

#import "@preview/mitex:0.2.7":*

#import "@preview/physica:0.9.8": *

//#import "@preview/inknertia:0.1.0": feynman
//#import feynman: *

//#import "@preview/showybox:2.0.4": showybox
#import "@preview/mannot:0.2.2": markrect

#import "@preview/colorful-boxes:1.4.3":*
//#let ket(x) = $|#x chevron.r$
//#let bra(x) = $chevron.l #x|$



#let html-setup(body) = {
  let is-html = sys.inputs.at("target", default: "") == "html"

  // 2. Put your show rules inside the function
  show figure.where(kind: "thmenv"): it => {
    if is-html {
      html.elem("div", attrs: (class: "theorem-box " + it.supplement), [
        #html.elem("strong", attrs: (class: "theorem-head"), [
          #it.supplement #it.counter.display() #if it.caption != none [ (#it.caption) ]
        ])
        #it.body
      ])
    } else {
      it
    }
  }

  // 3. Return the modified body
  body
}
// In your document:
#let my-box(..args, body) = {
  if sys.inputs.at("target", default: "") == "html" {
    html.elem("div", attrs: (class: "colorful-box-wrapper"), body)
  } else {
    slanted-colorbox(..args, body)
  }
}

// Map LaTeX commands to your physica functions
#let qft-macros = ```tex

\newcommand{\bra}[1]{\langle #1 \vert}
\newcommand{\ket}[1]{\vert #1 \rangle}
\newcommand{\braket}[2]{\langle #1 \vert #2 \rangle}
\newcommand{\mel}[3]{\langle #1 \vert #2 \vert #3 \rangle}
\newcommand{\ev}[1]{\langle #1 \rangle}
```

// 2. Stitch the preamble and the OCR math together
#let qft(body) = mitex(qft-macros.text + "\n" + body.text)


// Define the mapping dictionary
// Create the custom wrapper, passing the macros directly


// Create a custom block parser so you don't have to type config: physica-conf every time


#let feynman(body) = math.cancel(angle: 15deg, body)
#let psibar = $macron(psi)$
custom function `feynman`: $feynman(x)$

#let munu = $mu nu$

#let pphi = $phi.alt$
#let lag = $cal(L)$

#let diff(x,y) = $(dif^#x #y)/(2 pi)^#x$

#let fquant(n,p,x) = $integral diff(#n,#p) 1/sqrt(2 omega_#p) (a_#p e^(- i #p #x) + a^dagger_(#p) e^(i #p #x) ) $


#let ddelta(x,y) = $(2 pi)^#x op(delta^#x)(#y)$

#let proof = thmproof("proof","Proof")
#let theorem = thmbox("theorem", "Theorem", stroke: (left: 3pt + rgb("#e8f8f5")))
#let definition = thmbox("definition", "Definition", stroke:( left: 3pt + rgb("#fcf3cf")))
#let note = thmbox("note", "Note", stroke: (left: 3pt + rgb("#e67e22")), inset: (x: 10pt, y: 5pt)).with(numbering: none)
//#let physics = thmbox("physics", "Principle", fill: rgb("#ebf5fb"))

#let example = thmbox("example","Example")

#let rules(title,body) = my-box(
  title:title,
  color: "red",
  radius: 0pt,
  width: auto,
  body
)
 // 2. Key Results & Core Theorems (Blue)
#let result(title: "Key Result", body) = my-box(
  title: [  #title],
  color: "blue",
  radius: 0pt,
  width: auto,
  body
)

// 3. Physical & Algebraic Tricks (Amber / Gold)
#let trick(title: "Trick", body) = my-box(
  title: [#title  (_Mildly Useful Insight_)],
  color: "gold",
  radius: 0pt,
  width: auto,
  body
)

// 4. Definitions & Field Setups (Emerald / Green)

// 5. Pitfalls & Validity Limits (Purple / Violet)
#let pitfall(title: "Pitfall", body) = my-box(
  title: [#title _(Common Misconception)_],
  color: "purple",
  radius: 0pt,
  width: auto,
  body
)


#let derivation(title, body) = block(width: 100%, breakable: true)[
  // Weak vertical spacing ensures it doesn't double up on margins
  #v(1em, weak: true) 
  
  // The subtle divider line
  #line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))
  
  #v(0.5em, weak: true)
  
  // Muted, slightly smaller text for the entire block
  #text(size: 0.85em, fill: rgb("#475569"))[
    *Algebra: #title* \
    #body
  ]
  
  #v(1em, weak: true)
]

#let blue(x) = $#text(fill: rgb("72BAB5"))[#x]$
#let red(x) = $#text(fill: rgb("8A0E0E"))[#x]$
#let endingline = line(length: 100%, stroke: 0.5pt + rgb("#cbd5e1"))

