#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.26.0"
\layout {
  indent = 0.0
}
\header {
  title = "Marnivá sestřenice"
  section = "semafor"
  source = "Zpěvník Albatros"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice= "melody" {
    \transpose a c {
    \relative {
      \key a \major
      \time 4/4
      a'4 a cis e | a, a cis e | e1 | fis4 e r2 | \break
      b4 b d e | b b d e |  e1 | fis4 e r2 | \break
      a4 a a a | cis a a a | fis a a a | c a a a | \break
      e e e cis | gis' fis gis fis | a2 gis2 | a1 
      \bar "|."
    }
    }
  }
}
\new Lyrics  \with {
      \override LyricText.font-size = #-3
    } \lyricsto "melody" {
      Mě -- la vla -- sy sa -- mou lok -- nu, jé je -- je,
      rá -- no při -- stou -- pi -- la k_ok -- nu, jé je -- je,
      vla -- sy sa -- mou lok -- nu mě -- la a na nic víc ne -- my -- sle -- la
       a na nic víc ne -- my -- sle -- la, jé, jé, jé.
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