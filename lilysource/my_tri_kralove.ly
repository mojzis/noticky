#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "My tři králové"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \relative {
      \key g \major
      \easyHeadsOn
      \time 3/4
      s2 d'4 | g2 g4 | g2 b4 | a2 a4 | b2. |
      g4 fis e | a2 a4 | d,( e) fis | g2.
      \bar "|."
    }
  }
}
\new Lyrics \with {
  \override LyricText #'font-size = #-3
} \lyricsto "melody" {
  My tři krá -- lo -- vé jde -- me k_vám,
  štěs -- tí, zdra -- ví vin -- šu -- jem vám.
}
>>
\layout {
  #(layout-set-staff-size 50)
    \context {
    \Score
    \remove "Bar_number_engraver"
  }
}
\midi {}
}
\markup {
  \vspace #2
  \column {
    \line { Štěstí, zdraví, dlouhá léta, }
    \line { my jsme k vám přišli zdaleka. }
    \vspace #0.5
    \line { Zdaleka je cesta naše, }
    \line { do Betléma mysl naše. }
    \vspace #0.5
    \line { A co ty tam, černý, vzadu }
    \line { vystrkuješ na nás bradu. }
    \vspace #0.5
    \line { A já, černý, vystupuju }
    \line { a nový rok vám vinšuju. }
    \vspace #0.5
    \line { A my všichni vystupujem }
    \line { a nový rok vám vinšujem. }
  }
}
