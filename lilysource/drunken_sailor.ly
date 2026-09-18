#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.20.0"
\layout {
  indent = 0.0
}
\header {
  title = "Drunken sailor"
  section = "sea shanty"
  source = "https://www.free-notes.net/cgi-bin/noten_Song.pl?song=What+shall+we+do+with+the+drunken+sailor&profile=null&lang=en&db=Main"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody"
  \relative {
    \key c \major
    \easyHeadsOn
    \time 2/4
    a'8 a16 a a8 a16 a | a8 d, f a | g g16 g g8 g16 g | g8 c, e g |
    a a16 a a8 a16 a a8 b c d | c a g e | d4 d | a' a8. a16 | a8 d, f a |
    g4 g8. g16 | g8 c, e g | a4 a8. a16 | a8 b c d | c a g e | d d 
    \bar "|."
  }
}
\new Lyrics \with {
  \override LyricText #'font-size = #-3
} \lyricsto "melody" {
  What shall we do with the drun -- ken sai -- lor, what shall we do with the drun -- ken sai -- lor,
  what shall we do with the drun -- ken sai -- lor, ear -- ly in the mor -- ning? Hoo -- ray and up she ri -- ses,
  hoo -- ray and up she ri -- ses, hoo -- ray and up she ri -- ses, ear -- ly in the mor -- ning.
}
>>
\layout {
  #(layout-set-staff-size 40)
    \context {
    \Score
    \remove "Bar_number_engraver"
  }
}
}
\markup {
  \vspace #1
  \column {
    \line { Give him a dose of salt and water, ...}
    \vspace #0.1
    \line { Put him in the long-boat till he's sober, ... }
    \vspace #0.1
    \line { Heave him by the leg in a running bowlin', ... }
    \vspace #0.1
    \line { Take him and shake him and try to awake him, ... }
    \vspace #0.1
    \line { Give him a taste of the bosun's rope-end, ... }
    \vspace #0.1
    \line { Put him in the long-boat till he's sober, ... }
    \vspace #0.1
    \line { Pull out the plug and wet him all over, ... }
    \vspace #0.1
    \line { Heave him by the leg in a running bowlin', ... }
    \vspace #0.1
    \line { That's what to do with a drunken sailor, ... }
  }
}