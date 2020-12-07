#(set-global-staff-size 32)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Nesem vám noviny"
  section = "koledy"
  tagline = ##f
}
theChords = \chordmode {
  \time 3/4
  d2 g4 d2 g4 d2 a4 d2. d1 e4:7 a:7 d2 a4:7 d
}
\score {
<<
% \new ChordNames { \theChords }
\new Staff {
  \new Voice = "nesem" {
    \transpose d c {
    \relative {
      \key d \major
      \easyHeadsOn
      \time 3/4
      \repeat volta 2 {
       a'4-4 a8-4([ fis-2]) b-5( g-3) | a4-4 a8-4([ fis-2]) b-5( g-3) | a4-5 fis8-3([ a-5]) e-2( fis-3) | d2-1 r4 |
      }
      \break
      \repeat volta 2 {
        \autoBeamOff
        d-1 fis8-3 d-1 fis-3 a-5 | d,4-3 fis8-5 d-3 e-4 a,-1 | 
        \autoBeamOn
      }
      a'4-5 fis8-3([ a-5]) e-2( fis-3) | d2.-1
      \bar "|."
    }
    }
  }
}
\new Lyrics \with {
      \override LyricText #'font-size = #-3
    } \lyricsto "nesem" {
  <<
    {Ne -- sem vám no -- vi -- ny po -- slou -- chej -- te,
    Slyš -- te je pil -- ně a ne -- o -- myl -- ně, roz -- jí -- mej -- te
    }
    \new Lyrics \with {
      \override LyricText #'font-size = #-3
    } {
      \set associatedVoice = "nesem"
      zbet -- lém -- ské kra -- ji -- ny po -- zor dej -- te.
    }
  >>
}
>>
\layout {
  #(layout-set-staff-size 56)
}
}
\markup {
  \vspace #0.3
  \column {
    \line { Syna porodila čistá Panna, }
    \line {v jesličky vložila Krista pána,}
    \line {|: jej ovinula a zavinula :| plenčičkama}
    \vspace #0.3
    \line { Andělé v oblacích prozpěvují,}
    \line { narození Páně ohlašují,}
    \line { |: že jest narozen, v jeslích položen :| oznamují.}
  }
  \column {
    \line { K němužto andělé z nebe přišli,}
    \line {i také pastýři jsou se sešli.}
    \line { |: Jeho vítali jeho chválíli :|, dary nesli.}
  }
}
