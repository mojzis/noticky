#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Pásli ovce valaši"
  section = "koledy"
  tagline = ##f
}
\score {
<<
% \chords {
%   a e a
% }
\new Staff {
  \new Voice = "melody" {
    \relative {
      \easyHeadsOn
      \time 2/4
      % \set fontSize = #new-size
      % \override StaffSymbol.staff-space = #(magstep new-size)
      % \override StaffSymbol.thickness = #(magstep new-size)
      c''-5 g-3 | g-3 f-2 | e-1 f-2 | g2-3 | c4-5 g-3 | g-3 f-2 | e-1 d-3 | c2-2 | \break
      c4-1 e-3 | e-3 f-4 | e-3 d-2 | e2-3 | c4-1 e-3 | e-3 f-4 | e-3 d-2 | c2-1 \bar "|."
    }
  }
}
\new Lyrics \with {
      \override LyricText #'font-size = #-3
    } \lyricsto "melody"  {
  Pá -- sli ov -- ce va -- la -- ši při bet -- lém -- ské sa -- la -- ši
  Haj -- dom haj -- dom ty -- dli -- dom haj -- dom haj -- dom ty -- dli -- dom
}
>>
\layout {
  #(layout-set-staff-size 56)
}
}
\markup {
  \vspace #0.3
  \column {
    \line { Anděl se jim ukázal, do Betléma jim kázal, |: hajdom ... :| }
    \line { A tam jděte, pospěšte, Jezulátko najdete, |: hajdom ... :| }
    \line { On tam leží v jesličkách, zavinutý v plenčičkách, |: hajdom ... :|}
    \line { Maria ho kolíbá, svatý Josef mu zpívá, |: hajdom ... :|}
    \line { Hajej, nynej, děťátko, ty malé pacholátko, |: hajdom ... :|}
    }
}