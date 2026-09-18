#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.26.0"
\layout {
  indent = 0.0
}
\header {
  title = "Happy birthday"
  section = "random"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \relative {
      \key c \major
      \easyHeadsOn
      \time 3/4
      \partial 2 g'4.-1 g8 | a4-2 g c-4 | b2 g8. g16 | a4 g d'-5 |
      c2 g8. g16 | g'4-5 e-3 c-1 | b-2 a\fermata f'8.-5 f16 | e4 c d | c2 \bar "|."
    }
  }
}
\new Lyrics \with {
  \override LyricText.font-size = #-3
} \lyricsto "melody" {
  Hap -- py birth -- day to you! Hap -- py birth -- day to you!
  Hap -- py birth -- day, dear A B, Hap -- py birth -- day to you!
}
>>
}