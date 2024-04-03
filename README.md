# Community Example

This site was generated from the [Social Data Commons](https://github.com/uva-bi-sdad/social_data_commons)'s
[community_example](https://github.com/uva-bi-sdad/social_data_commons/blob/main/views/community_example/view.json) view.
.

To recompile from source repositories, clone that repository, and run this (assuming this repository is in the same directory):

```R
# remotes::install_github("uva-bi-sdad/community")
library(community)

# clone/pull the data repositories
datacommons_refresh("../social_data_commons")

# rebuild the view
datacommons_view(
  "../social_data_commons", "community_example", entity_info = NULL, prefer_repo = TRUE
)
```

To run the site locally, run this:

```R
site_build(
  "../community_example", version = "dev", serve = TRUE,
  endpoint = "https://vdh-data-commons.netlify.app/api"
)
```
