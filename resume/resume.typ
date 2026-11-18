// PDF build of the resume. Content: content.typ, layout: layout-pdf.typ
#import "content.typ": resume
#import "layout-pdf.typ": layout, setup
#show: setup
#resume(layout)
