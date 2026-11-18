#import "../../config.typ": template
#import "../../link-icons.typ": with-icons
#import "_pages.typ": pages
#show: template.with(title: "Cool stuff")
#show: with-icons

= Cool stuff

This page collects the cool stuff I've found and the things I actually use: tools, tricks and projects that made me stop and think "huh, that's neat". It's a growing list, so check back for new additions.

== Pages

#list(..pages.map(p => [
  #link("/cool-stuff/" + p.slug + "/")[*#p.title*]: #p.summary
]))
