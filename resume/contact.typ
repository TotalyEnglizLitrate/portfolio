// Contact details shared by the resume (PDF and web) and the home page.
#let name = [Narendra Sampath Kumar]

#let phone = link("tel:+91-95003-22609")[+91 95003 22609]
#let email = link("mailto:contact@engliz.dev")[contact\@engliz.dev]
#let linkedin = link("https://linkedin.com/in/narendra-sampath")[linkedin.com/in/narendra-sampath]
#let github = link("https://github.com/TotalyEnglizLitrate")[github.com/TotalyEnglizLitrate]

#let website = link("https://engliz.dev")[engliz.dev]

// Shared by the resume and the home page. `website` is not in this list: the
// PDF resume header adds it on its own (see layout-pdf.typ).
#let contacts = (phone, email, linkedin, github)
