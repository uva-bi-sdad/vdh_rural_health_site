library(community)

# make copy (could be "uva-bi-sdad/community_example" to get from repo)
site_make_child("../community_example", "../vdh_rural_health_site", include = "docs/data/measure_info.json")

# build site
site_build(
  "../vdh_rural_health_site", serve = TRUE,
  parent = "https://uva-bi-sdad.github.io/community_example/",
  endpoint = "https://vdh-data-commons.netlify.app/api"
)
