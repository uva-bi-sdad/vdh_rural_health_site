# Community Example

This site was generated with these commands:
```R
# remotes::install_github("uva-bi-sdad/community")
library(community)

# run from where you want the site files, or set `dir`
init_site('Virginia Department of Health Dashboard', with_data = TRUE)

# reformat original files, and output to the current working directory
# (in this case, the original files were moved to a subdirectory of the output directory first)
data_reformat_sdad("docs/data/original", out = "docs/data")

# then run
data_add(
  c(
    district = "health_district.csv",
    county = "county.csv",
    tract = "tract.csv"
  ),
  rep(list(list(
    ids = list(
      variable = 'ID',
      map = 'https://uva-bi-sdad.github.io/community/dist/shapes/VA/virginia_2010.json'
    ),
    time = 'time',
    variables = 'measure_info.json'
  )), 3),
  dir = 'docs/data',
  refresh = TRUE
)

# specify variables if you want to only include a subset
meta <- jsonlite::read_json('docs/data/measure_info.json')

# edit site.R, and add some styling to docs/style.css, then run
# (add `bundle_data = TRUE` or run `npm start` from a console to run locally)
site_build(variables = c('ID', names(meta)))
```