#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Narodil se Kristus Pán"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" \relative {
    \easyHeadsOn
    \time 4/4
    c'-1 c8-1( d-2) e4-3 fis-4 | g-5 g-4 g2-3 | fis4-2 g-3 a2-4 | g2.-3 r4 | \break
    g-5 g-5 f-4 f-4 | e-3 e-3 d2-2 | e-3 f-4 e-3( d-2) | c2.-1 r4  | \break 
    \repeat volta 2 {
      e-3 d-2 e-3 f-4 | g2-5 c,-1 | e4-3 d-2 e-3 f-4 | g2-5 c,-1 | c-1 a'-5 | g4-4 f-3 e-2( d-1) |  c2.-2 r4 
    }
  }
}
\new Lyrics \with {
      \override LyricText #'font-size = #-2
    } \lyricsto "melody" {
  Na -- ro -- dil se Kris -- tus Pán, ve -- sel -- me se. 
  Z_rů -- že kví -- tek vy -- kvet nám, ra -- duj -- me se.
  Z_ži -- vo -- ta čis -- té -- ho, 
  z_ro -- du krá -- lovs -- ké -- ho 
  nám nám na -- ro -- dil se.
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
    \pad-x #15
    \line {Jenž prorokován jest, veselme se,}
    \line {ten na svět poslán jest, radujme se. }
    \line {|: Z života čistého, rodu ... :|}
    \vspace #0.3
    \line {Člověčenství naše, veselme se, }
    \line {ráčil vzíti na se, radujme se}
    \line {|: Z života čistého, rodu královského ... :|}
  }
  \column {
    \line {Goliáš obloupen, veselme se, }
    \line {člověk jest vykoupen, radujme se.}
    \line {|: Z života čistého, rodu ... :|}
  }
}