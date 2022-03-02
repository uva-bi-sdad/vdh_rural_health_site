# VDH Rural Health Data Commons

This is a child site of [community_example](https://github.com/uva-bi-sdad/community_example), generated with this:
```R
library(community)

# make copy (could be "uva-bi-sdad/community_example" to get from repo)
site_make_child("../community_example", "../vdh_rural_health_site", include = "docs/data/measure_info.json")

# build site
vars <- jsonlite::read_json('../vdh_rural_health_site/docs/data/measure_info.json')
site_build(
  '../vdh_rural_health_site', variables = names(vars), version = "dev",
  parent = "https://uva-bi-sdad.github.io/community_example/"
)
```