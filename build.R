library(community)


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
