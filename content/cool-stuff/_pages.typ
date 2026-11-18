// The pages listed on the Cool stuff index, in the order they appear.
// To add a page: copy `_template/` to `content/cool-stuff/<slug>/`, edit it,
// then add its slug here. Move a slug to change the order.
//
// Each page's title and summary are read from the `title` and `summary`
// defined at the top of its own `<slug>/index.typ`.
#let slugs = (
  "tools",
  "idk",
)

#let load(slug) = {
  import slug + "/index.typ" as page
  (slug: slug, title: page.title, summary: page.summary)
}

#let pages = slugs.map(load)
