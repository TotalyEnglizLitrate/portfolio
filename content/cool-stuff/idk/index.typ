#import "../_layout.typ": cool-page
// Title and summary: shown on this page and on the Cool stuff index.
#let title = "I didn't know that ..."
#let summary = "Surprising pieces of information"
#show: cool-page.with(title: title, summary: summary)

This page is for interesting things I was surprised to find out.

== The x86 `mov` instruction is Turing complete

If you're anything like me, you must have come across some weird things that are Turing complete, like html+css without js, or Pokemon Yellow or Magic the Gathering. One that took me by surprise was, that the x86 `mov` instruction, all by itself is Turing complete. Honorable Mention to the Unicode Transliteration rules being Turing complete as well. https://gwern.net/turing-complete is a neat list of stuff that is turing complete, along with some more pertinent information.
