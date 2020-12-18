#(set-global-staff-size 32)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Veselé vánoční hody"
  section = "koledy"
  tagline = ##f
}
% theChords = \chordmode {
%   \time 2/4
% }
\score {
<<
\new Staff {
  \new Voice = "melody" {
  \transpose d c {
  \relative {
    \key d \major
    \easyHeadsOn
    \time 2/4
    d'8[( fis)] a\noBeam a | a4 d8( b) | a4 g | fis r4 | d8[( fis)] a\noBeam a | a4 d8( b) | a4 g | fis r4 | \break
    \repeat volta 2 {
      \autoBeamOff
      a8 a g fis | e fis g e | a a g fis | e fis g e | fis4 e | d r4 |
    }
  }
  }
  }
}
\new Lyrics \with {
  \override LyricText #'font-size = #-3
    } \lyricsto "melody" {
      Ve -- se -- lé vá -- noč -- ní ho -- dy, zpí -- vej -- te dít -- ky ko -- le -- dy,
      o tom, co se v_skut -- ku sta -- lo, že se li -- dem na -- ro -- di -- lo dě -- ťát -- ko.
    }
>>
\layout {
  #(layout-set-staff-size 56)
}
\midi {}
}
\markup {
  \vspace #0.3
  \column {
    \line { Jehož Maria počala, v Betlémě ho porodila,}
    \line { položila do jesliček, zavinula do plenčiček, děťátko.} 
    \vspace #0.3
    \line { Vůl a oslík nad ním stáli a svým dechem zahřívali} 
    \line { chudé lidské nemluvňátko, slavné Boží pacholátko, děťátko.} 
    \vspace #0.3
    \line { Potmě leží, nemá svíčičky, na nebi svítí mu hvězdičky.} 
    \line { Ty, jenž všechen oděv dáváš, samo's nahé a nic nemáš, děťátko.}
    \vspace #0.3
    \line { Přišli chudí pastouškové, zpívají Ti chvály nové:} 
    \line { Vítej nám nebeský Králi, Tebeť jsme zdávna žádali, děťátko.} 
  }
}