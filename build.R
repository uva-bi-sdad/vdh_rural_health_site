library(community)

<<<<<<< HEAD
data_add(
  c(
    district = "health_district.csv.xz",
    county = "county.csv.xz",
    tract = "tract.csv.xz"
  ),
  list(
    ids = list(
      variable = "ID",
      map = paste0(
        "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/",
        "entities/data/distribution/VA.json"
      )
    ),
    time = "time",
    variables = "measure_info.json"
  ),
  dir = "./docs/data",
  clean = TRUE
=======
# make copy (could be "uva-bi-sdad/community_example" to get from repo)
site_make_child("../community_example", "../vdh_rural_health_site", include = "docs/data/measure_info.json")

# build site
site_build(
  "../vdh_rural_health_site", serve = TRUE, aggregate = TRUE,
  parent = "https://uva-bi-sdad.github.io/community_example/",
  endpoint = "https://vdh-data-commons.netlify.app/api",
  tag_id = "G-WSQPEF0573"
>>>>>>> ae04b738c7f88679aa0f548c6cdafa7cb334e95d
)

# # clone/pull the data repositories
# datacommons_refresh("../social_data_commons")
# 
# # # rebuild the view
# datacommons_view(
#   "../social_data_commons", "vdh_rural_parent", entity_info = NULL, prefer_repo = TRUE
# )

site_build(
  ".", serve = TRUE, aggregate = TRUE,
  endpoint = "https://vdh-data-commons.netlify.app/api"
)
# site_build(
#   ".", version = "dev", serve = TRUE,
#   endpoint = "https://vdh-data-commons.netlify.app/api"
# )
