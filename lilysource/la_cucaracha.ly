#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.26.0"
\layout {
  indent = 0.0
}
\header {
  title = "La cucaracha"
  section = "traditional"
  language = "es"
  source = "https://www.singing-bell.com/how-to-play-la-cucaracha-piano-notes-chords-sheet-music-activities/"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \relative {
      \key c \major
      \time 4/4
      s2 r8 c'8 c c |
      \repeat volta 2 {
        f4. a4 c,8 c c | f4. a8( a2) | r8 f4 f8 e e d d | c2 r8 c8 c c |
        e4. g4 c,8 c c | e4. g8 g2 | r8 c8 c d c bes a g | 
      }
      \alternative {
        { f2 r8 c8 c c | }
        { f1 |}
      }
      \repeat volta 2 {
        r8 c4 c8 f f a a | c4. a8( a2)( | a8) c4 d8 c bes a c | bes4. g8 g2|
        r8 c,8 c c e e g g | bes4. g8( g2)( | g8) c c d c bes a g | 
      }
      \alternative {
        {a4. f8( f2) | }
        {f2 }
      }
      \bar "|."
    }
  }
}
\new Lyrics  \with {
      \override LyricText.font-size = #-3
    } \lyricsto "melody" {
      La cu -- ca -- 
      \repeat volta 2 {
         ra -- cha, la cu -- ca -- ra cha,
      ya no pue -- de ca -- mi nar 
      por -- que no tie -- ne por -- que le fal -- ta _ 
      las dos pa -- ti -- tas de a --
      }
      \alternative {
        { tras La cu -- ca}
        { tras }
      }
      \repeat volta 2 {
        Di -- cen que la cu -- ca -- ra -- cha
        es un a -- ni -- mal pe -- que -- no _
        Y cuan -- do en -- traen u -- na ca -- sa
        se tie -- ne que que -- dar du --
      }
      \alternative {
        { e -- no _ }
        { _ }
      }
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
