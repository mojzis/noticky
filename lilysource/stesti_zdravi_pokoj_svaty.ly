#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Štěstí, zdraví, pokoj svatý"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \transpose d c {
    \relative {
      \key d \major
      \easyHeadsOn
      \time 2/4
      a'8 a a b | g g g a | fis fis e e | d4 r | \break
      a'8 a a b | g g g a | fis fis e e | d4 r | \break
      fis8 fis fis e | fis b a4 | fis8 fis fis e | fis b a4 | \break
      a8 a a b | g g g a | fis fis e e | d4 r 
      \bar "|."
    }
    }
  }
}
\new Lyrics \with {
      \override LyricText #'font-size = #-2
    } \lyricsto "melody" {
      Štěs -- tí zdra -- ví po -- koj sva -- tý vin -- šu -- je -- me vám,
      nej -- prv pa -- nu hos -- po -- dá -- ři, pak va -- šim dít -- kám.
      Zda -- le -- ka se bé -- ře -- me, no -- vi -- nu vám ne -- se -- me,
      co jest se nám při -- ho -- di -- lo v_měs -- tě Bet -- lé -- mě.
}
>>
\layout {
  #(layout-set-staff-size 40)
    \context {
    \Score
    \remove "Bar_number_engraver"
  }
}
\midi {}
}
\markup {
  \vspace #1
  \column {
    \pad-x #15
    \line { Narodil se tam Synáček, }
    \line { posílá mne k vám, }
    \line { byste mu koledy dali, }
    \line { však já mu ji dám. }
  }
  \vspace #1
  \column {
    \line { Chlebíčka nechce bráti, }
    \line { nakrmila ho máti; }
    \line { radš tolárek, neb dukátek }
    \line { máte poslati. }
  }
}