#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Byla cesta byla ušlapaná"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody"
  \relative {
    \easyHeadsOn
    \time 3/4
    \repeat volta 2 {
      c'8 e g4 bes | aes8 g f4 g | e c2 |
    }
    \repeat volta 2 {
      e8 e c4 f | e8 e c4 f | f8 f8 g4 f | e c r4 |
    }
  }
}
\new Lyrics \with { 
  \override LyricText #'font-size = #-2
  } \lyricsto "melody" {
    By -- la ces -- ta, by -- la u -- šla -- pa -- ná,
    kdo ju šla -- pal, kdo ju šla -- pal? Mat -- ka Kris -- ta Pá -- na.
  }
>>
\layout {
  #(layout-set-staff-size 40)
}
\midi {}
}
\markup {
  \vspace #0.3
  \column {
    \line { Postřehla ju tam svatá Alžběta:}
    \line { Kam ty kráčíš, kam ty kráčíš, sestřičko má milá?}
    \vspace #0.3
    \line { Kráčím sestro, kráčím do kostela,}
    \line { poslúchať mše, poslúchať mše svatého nešpora.}
    \vspace #0.3
    \line { Nechoď sestro, nechoď do kostela,}
    \line { povídajů, povídajů, že porodíš syna.}
    \vspace #0.3
    \line { A co by to za novina byla,}
    \line { kdyby panna, kdyby panna syna porodila.}
    \vspace #0.3
    \line { Porodila v ty vánoční hody,}
    \line { co zamrzly, co zamrzly všecky všady vody. }
  }
}