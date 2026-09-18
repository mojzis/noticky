#(set-global-staff-size 34)
#(set-default-paper-size "a4" 'landscape)
\version "2.26.0"
\layout {
  indent = 0.0
}
\header {
  title = "Dobrý král Václav"
  section = "koledy"
  tagline = ##f
}
\score {
<<
\new Staff {
  \new Voice = "melody" {
    \relative {
      \key f \major
      f' f f g | f f c2 | d4 c d e | f2 f | \break
      f4 f f g | f f c2 | d4 c d e | f2 f | \break
      c'4 bes a g | a g f2 | d4 c d e | f2 f | \break
      c4 c d e | f f g2 | c4 bes a g( | f2) bes | f1
      \bar "|."
    }
  }
}
\new Lyrics \with {
      \override LyricText.font-size = #-3
    } \lyricsto "melody" {
  Na Ště -- pá -- na dob -- rý král Vác -- lav z_ok -- na hle -- dí,
  všu -- de kam se po -- dí -- vá, zá -- vě -- je a le -- dy.
  Sví -- til mě -- síc a byl mráz, pá -- lil ja -- ko di -- vý,
  a vtom spat -- ří chu -- dá -- ka, jak tam sbí -- rá dří -- ví.
}
>>
\layout {
  #(layout-set-staff-size 50)
}
\midi {}
}
\markup {
  \vspace #2
  \fill-line {
    \column {
      \line { „Hola, páže,“ pravil král, }
      \line { „podívej se honem. }
      \line { Odkud je ten sedláček, }
      \line { víš-li něco o něm?“ }
      \line { „Pane můj, ten sedláček }
      \line { bydlí támhle kdesi }
      \line { u studánky v chalupě }
      \line { pod samými lesy.“ }
      \vspace #1
      \line { „Přines maso, přines chléb }
      \line { a pár polen k tomu, }
      \line { zanesem to ještě dnes }
      \line { sedláčkovi domů.“ }
      \line { A tak šli, král s pážetem, }
      \line { a tak vyrazili, }
      \line { i když venku vítr dul }
      \line { a vyl ze vší síly. }
    }
    % singing-image
    \column {
      \line { „Pane můj, je hrozná tma }
      \line { a je hrozná zima. }
      \line { Sotva jdu, už nemůžu, }
      \line { strach mě z toho jímá.“ }
      \line { „Vkládej nohy do mých stop }
      \line { a pojď dál, můj hochu! }
      \line { Za chvíli ti nebude }
      \line { zima ani trochu.“ }
      \vspace #1
      \line { Vkládal nohy krok co krok }
      \line { do stop po svém králi, }
      \line { a kam vkročil svatý král, }
      \line { tam i sněhy hřály. }
      \line { Proto, věřte, křesťané, }
      \line { boháči i páni, }
      \line { ten, kdo cítí s chudými, }
      \line { dojde požehnání. }
    }
  }
}
