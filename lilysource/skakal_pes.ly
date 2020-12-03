#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Skákal pes"
  section = "lidovky"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \relative {
      \easyHeadsOn
      g' g e2 | g4 g e2 | g4 g a g | g2 f \break
      f4 f d2 | f4 f d2 | f4 f g f | f2 e
      \bar "|."
    }
  }
}
\new Lyrics \with {
      \override LyricText #'font-size = #-3
    } \lyricsto "melody" {
  Ská -- kal pes přes o -- ves přes ze -- le -- nou lou -- ku
  Šel za ním my -- sli -- vec pé -- ro na klo -- bou -- ku
}
>>
\layout {
  #(layout-set-staff-size 56)
}
}
\markup {
  \column {
    \line {Pejsku náš, co děláš}
    \line { žes tak vesel stále? }
    \line { Řek bych vám, nevím sám }
    \line { hop, a skákal dále. }
  }
}