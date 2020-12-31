# Noticky

Songs notes engraved to be easy for kids (or beginners) to play and sing.

I started working on this project while being sick at home and trying to get my brain back to speed. I saw the kids trying to play on their Yamaha keyboard. They actually preferred this annoying toy book which had color coded notes and piano keys and made it super easy to produce something close to a melody.  
So I thought it would be nice to be able to provide them an easy way to play on the "proper" piano as well. My wife put little stickers with note names on the keys of the keyboard, so all we needed was notes with names in them.  
[LilyPond](http://lilypond.org/), among the million of other features allows for that, too :). So I started "engraving" notes in LilyPond, only to figure out its actually a bit harder then I thought. But the results were so beautiful and hearing our boys play was so gratifying that I kept on adding songs. Because its the season, its Christmas Carols now, but we are hoping to add more.  
  
Some of the songs we found were a bit too difficult to play for us (all the #s) so they are "transposed" for now to the key of c. 

Then the magic call happened when a dear auntie helped me figure out the fingerings - while sitting at her piano and talking to me on phone (corona times ...) and asking me to try to play it, transposing songs directly from her head (unlike me there are people who actually know about music in our remote family, i can only admire them :).  

I figured I might as well try to share the whole effort with others, hence this little website :). The main focus is downloadable printable sheets you can put on your piano and play. But the html version got a bit better too and might be usable directly on tablets/ bigger phones.  

This is very much a **learning process** 
- how to teach kids at home without knowing much myself,
- how to engrave properly, 
- how to manipulate the engraved music (current implementation is [hacky](https://github.com/mojzis/noticky/blob/main/do.py#L52) and naive but works for now :) 
- how to setup a single static website so that it has everything a website should have ... 

We enjoy it a lot, kids learning a new song every time I manage to print it.


## Sources
- Many songs are listed on the page of the choir [Sbor Kytice](https://sborkytlice.wordpress.com/uvodni-stranka/materialy-pro-sbor/noty/)

## How is it made
Note engraving done with [Lily Pond](http://lilypond.org/)


Tools to be checked / probably used in the future 
- https://www.frescobaldi.org/ - LilyPond editor
- http://abjad.mbrsi.org/ - music programming
- https://notabug.org/chaosmonk/lpm/src/master - lily management
- https://github.com/frescobaldi/python-ly - used by the above, not exactly easy to use :)

Might be interesting inspiration
https://www.mutopiaproject.org/collections.html - also a lot of music :) 


- Hosting: [netlify](http://netlify.com/) - its really cool 
- Analytics: Privacy friendly open analytics by [Plausible](https://plausible.io/noticky.eu)
- Favicons: https://realfavicongenerator.net/

## How to use

The PDFs are ment to be the easiest way to play, but it might actually work with the html version directly from your device, too. You might want to rotate the screen :).  
If you want to hear the melody, you can try the `midi` file (available for download on each songs page).  
On Ubuntu, the easiest way to play was to run 
```bash
timidity -T 200 nesem_vam_noviny.midi
```
(`-T 200` makes it a bit faster, I think it works better for some songs).

## Privacy
see ma, no cookies :)

## License
As open as [possible](https://github.com/mojzis/noticky/blob/main/LICENSE) - peruse this in whatever way suits you. Would be nice if you let me know :).

## Get in touch
- [@mojzis](https://twitter.com/mojzis)  
- [github](https://github.com/mojzis/noticky)
- mojzis at hey.com