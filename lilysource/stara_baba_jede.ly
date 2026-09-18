#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.26.0"
\layout {
  indent = 0.0
}
\header {
  title = "Stará bába jede"
  section = "lidovky"
  source = "https://pesnicky.orava.sk/noty?view=song&layout=attachment&id=12009&attachment_id=12010"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice= "melody" {
    \relative {
      \key c \major
      \easyHeadsOn
      \time 3/4
      c''8 b c g a  b | c b c g a b | c4 g e | c r2 \break
      c'8 b c g a  b | c b c g a b | c4 g e | c r2 \break
      \repeat volta 2 {
        c'2 d4 | e d c | b2 c4 | d c b | \break
        c8 b c g a b | c b c g a b | c4 g e | c r2
      }
    }
  }
}
\new Lyrics  \with {
      \override LyricText.font-size = #-3
    } \lyricsto "melody" {
      Sta -- rá bá -- ba je -- de, sta -- rá bá -- ba je -- de
      s_mar -- ci -- pá -- nem.
      Sta -- rej dě -- děk za ní, sta -- rej dě -- děk za ní
      s_tu -- li -- pá -- nem.
      Bá -- ba od -- chá -- zí, on jí nad -- chá -- zí,
      o -- na do ko -- mí -- na, on ji na -- po -- mí -- ná,
      ať ne -- blá -- zní.
    }
>>
\layout {
  #(layout-set-staff-size 50)
    \context {
    \Score
    \remove "Bar_number_engraver"
  }
}
}