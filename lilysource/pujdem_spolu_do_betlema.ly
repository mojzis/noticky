#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Půjdem spolu do Betléma"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \relative {
    \easyHeadsOn
    \time 2/4
    \key f \major
    \autoBeamOff
    f'8 f c c | a' a f f | b16([ c]) d([ c]) bes([ c]) d([ c]) | b[( c)] d([ bes]) c4 | \break
    \repeat volta 2 {
      bes8 bes16([ d]) g,4 | a8 a16([ c]) f,4 | g8 g f16([ e]) d([ e]) | f8 a f a | \break
      bes bes16([ d]) g,4 | a8 a16([ c]) f,4 |   g8 g f16([ e]) d([ e]) | f8 a f4 \bar "|."
    }
  }
  }
}
\new Lyrics \with {
  \override LyricText #'font-size = #-3
} \lyricsto "melody" {
  Pů -- jdem spo -- lu do Bet -- lé -- ma, duj -- daj, duj -- daj duj -- daj dá.
  Je -- žíš ku, pa -- náč -- ku, já tě bu -- du ko -- lé -- ba -- ti,
  Je -- žíš ku, pa -- náč -- ku, já tě bu -- du ko -- lé -- bat.
}
>>
\layout {
  #(layout-set-staff-size 56)
}
}
\markup {
  \vspace #0.3
  \column {
    \line { Začni Kubo, na ty dudy, duj-daj, duj-daj, ... Ježíšku ...}
    \line { A ty, Janku, na píšťalku, hudli-tydli, hudli-tydli, ... Ježíšku ...}
    \line { A ty, Mikši, na housličky, hudli-tydli, hudli-tydli, ... Ježíšku ...}
    \line { A ty, Vávro, na tu basu, ruma-ruma, ruma-ruma, ... Ježíšku ...}
  }
}
