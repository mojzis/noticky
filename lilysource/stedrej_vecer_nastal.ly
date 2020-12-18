#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Štědrej večer nastal"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new ChordNames {
  \transpose d c
  \chordmode {
  \time 2/4
  d2 g4 a4 d2 d2 g2
  a2:7 d1 d4 a4:7 d2
}
}
\new Staff {
  \new Voice = "melody" {
    \transpose d c
    \relative {
      \easyHeadsOn
      \time 2/4
      \key d \major
      d'4 fis | g8 fis e4 | d  r4 | fis a | a8[ g] g b | \break
      e,4 g | g8[ fis] fis a | d,4 fis | g8 fis e4 | d r4 | 
      \bar "|."
    }
  }
}
\new Lyrics \with {
  \override LyricText #'font-size = #-2
} \lyricsto "melody" {
  Štěd -- rej ve -- čer nas -- tal. Štěd -- rej ve -- čer nas -- tal,
  ko -- le -- dy při -- chy -- stal, ko -- le -- dy při -- chy -- stal.
}
>>
\layout {
  #(layout-set-staff-size 40)
}
\midi {}
}
\markup {
  \vspace #0.5
  \column {
    \line { Panímámo, vstaňte. Panímámo, vstaňte,}
    \line { koledu nám dejte, koledu nám dejte. }
    \vspace #0.5
    \line { Panímáma vstala. Panímáma vstala,}
    \line { koledu nám dala, koledu nám dala.}
  }
}