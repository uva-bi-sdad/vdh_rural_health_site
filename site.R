library(community)

page_head(
  title = "Virginia Department of Health Data Commons",
  description = "Virginia Department of Health Data Commons.",
  icon = "https://uva-bi-sdad.github.io/community_example/icon.svg"
)

page_navbar(
  title = "Virginia Department of Health Data Commons",
  logo = "https://uva-bi-sdad.github.io/community_example/icon.svg",
  input_button("Reset", "reset_selection", "reset.selection", class = "btn-link", note = "Reset the menu inputs to their defaults."),
  input_button("Filter", "filter", "open.filter", class = "btn-link"),
  list(
    name = "Settings",
    backdrop = "false",
    class = "menu-compact",
    items = list(
      input_switch("Dark Theme", id = "settings.theme_dark"),
      input_switch(
        "Color by Rank", id = "settings.color_by_order",
        note = paste(
          "Switch from coloring by value to coloring by sorted index.",
          "This may help differentiate regions with similar values."
        )
      ),
      input_select(
        "Color Scale Center", options = c("none", "median", "mean"), default = "none",
        display = c("None", "Median", "Mean"), id = "settings.color_scale_center",
        floating_label = FALSE,
        note = "Determines whether and on what the color scale should be centered."
      ),
      input_switch("Hide URL Settings", id = "settings.hide_url_parameters"),
      input_switch("Hide Tooltips", id = "settings.hide_tooltips"),
      input_switch("Show Missing Years", id = "settings.show_empty_times"),
      input_number("Digits", "settings.digits", default = 2, min = 0, max = 6, floating_label = FALSE),
      input_select(
        "Summary Level", options = c("dataset", "filtered", "all"), default = "dataset",
        display = c("All Regions", "Selected Region Types", "Selected Region"), id = "settings.summary_selection",
        floating_label = FALSE,
        note = paste(
          "Determines which regions are included in summaries for box-plots and color scaling;",
          "All-Regions are state-wide, Selected Region Types are filtered by the Region Types input, and",
          "Selected Region are filtered by region selection."
        )
      ),
      '<p class="section-heading">Map Options</p>',
      input_select(
        "Animations", c("fly", "zoom", "none"), "fly",
        note = "Fly animates the whole move to different regions; Zoom only animates changes in zoom level.",
        id = "settings.map_animations", floating_label = FALSE
      ),
      input_switch("Background On Top", default_on = TRUE, id = "settings.background_top"),
      input_number(
        "Outline Weight", "settings.polygon_outline", default = 1.5, step = .5, floating_label = FALSE,
        note = "Thickness of the outline around region shapes."
      ),
      input_number(
        "Background Outline Weight", "settings.background_polygon_outline", default = 2,
        step = .5, floating_label = FALSE
      ),
      input_number(
        "Overlay Circle Size", "settings.circle_radius", default = 5, step = 1, floating_label = FALSE,
        note = "Radius of the circles that are parts of overlays."
      ),
      input_select(
        "Overlay Circle Property", "overlay_properties", id = "settings.circle_property", floating_label = FALSE,
        note = "Property to adjust circle size by."
      ),
      '<p class="section-heading">Plot Options</p>',
      input_select("Plot Type", c("scatter", "scattergl", "bar"), "scatter", id = "plot_type", floating_label = FALSE),
      input_switch("Box Plots", default_on = TRUE, id = "settings.boxplots"),
      input_switch(
        "Use IQR Whiskers", id = "settings.iqr_box",
        note = "Define the extreme fences of the box plots by 1.5 * interquartile range (true) or min and max (false)."
      ),
      input_number(
        "Trace Limit", "settings.trace_limit", default = 20, floating_label = FALSE,
        note = "Limit the number of plot traces that can be drawn, split between extremes of the variable."
      ),
      '<p class="section-heading">Table Options</p>',
      input_switch("Auto-Sort", default_on = TRUE, id = "settings.table_autosort"),
      input_switch("Auto-Scroll", default_on = TRUE, id = "settings.table_autoscroll"),
      input_select(
        "Scroll Behavior", c("instant", "smooth", "auto"), "auto",
        id = "settings.table_scroll_behavior", floating_label = FALSE
      )
    ),
    foot = list(
      input_button("Clear Settings", "reset_storage", "clear_storage", class = "btn-danger")
    )
  ),
  list(
    name = "About",
    items = list(
      page_text(c(
        paste0(
          "This site was made by the [Social and Decision Analytics Division]",
          "(https://biocomplexity.virginia.edu/institute/divisions/social-and-decision-analytics)",
          " of the [Biocomplexity Institute](https://biocomplexity.virginia.edu) for the ",
          "[Virginia Department of Health](https://www.vdh.virginia.gov)."
        ),
        "View its source on [GitHub](https://github.com/uva-bi-sdad/vdh_rural_health_site).",
        input_button("Download Loaded Data", "export", query = list(
          features = list(geoid = "id", name = "name", region_type = "type")
        ), class = "btn-full"),
        "Credits",
        paste(
          "Built in [R](https://www.r-project.org) with the",
          "[community](https://uva-bi-sdad.github.io/community) package, using these resources:"
        )
      ), class = c("", "", "h5")),
      output_credits()
    )
  )
)

page_panel(
  page_section(
    wraps = "row",
    conditions = c("", "metric_set == rural_health", "metric_set == hoi", "metric_set == unit_profiles"),
    input_select(
      "Metric Set", c("rural_health", "hoi", "unit_profiles"), 1, c("Rural Health", "Health Equity", "Unit Profiles"),
      id = "metric_set"
    ),
    c(
      '<p>Office of Rural Health</p>',
      paste(
        '<img style="margin: auto; width: 35px" alt="Virginia State Office of Rural Health Logo"',
        'src="data:image/png;base64,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">'
      ),
      '<p class="lead fs-6">- Priority Metrics -</p>'
    ),
    c(
      '<p>Office of Health Equity</p>',
      '<p class="lead fs-6">- Health Opportunity Index -</p>'
    ),
    c(
      '<p>Virginia Cooperative Extension</p>',
      '<p class="lead fs-6">- Unit Profiles -</p>'
    )
  ),
  conditions = c("metric_set == rural_health", "metric_set == hoi", "metric_set == unit_profiles"),
  ## RURAL HEALTH PANEL -------------------------------------------------------
  page_section(
    type = "", id = "rural_health_panel",
    '<p class="lead">Education</p>',
    input_button(
      "Child Readiness",
      list(selected_variable = "median_read_pass_rate")
    ),
    '<p class="lead">Broadband</p>',
    input_button(
      "Households with Broadband",
      list(selected_variable = "perc_hh_with_broadband")
    ),
    '<p class="lead">Nutrition and Food Security</p>',
    input_button(
      "Food Insecurity",
      list(selected_variable = "percent_food_insecure")
    ),
    input_button(
      "Childhood Food Insecurity",
      list(selected_variable = "Child_Food_Insecurity_Rate")
    ),
    '<p class="lead">Healthy Moms And Babies</p>',
    input_button(
      "APNCU: Inadequate",
      list(selected_variable = "inadequate")
    ),
    input_button(
      "APNCU: Intermediate",
      list(selected_variable = "intermediate")
    ),
    input_button(
      "APNCU: Adequate",
      list(selected_variable = "adequate")
    ),
    input_button(
      "APNCU: Adequate Plus",
      list(selected_variable = "adequateplus")
    ),
    '<p class="lead">Access to Health Care Services</p>',
    input_button(
      "Avoidable Hospitalizations",
      list(selected_variable = "prevent_hosp_rate")
    ),
    '<p class="lead">Behavioral Health, Substance Use Disorder and Recovery</p>',
    input_button(
      "Overdose ED Visits",
      list(selected_variable = "avg_monthly_rate")
    ),
    '<p class="lead">Employment/Workforce Development</p>',
    input_button(
      "Earnings per Job",
      list(selected_variable = "earnings_per_job")
    ),
    input_button(
      "Employment Rate",
      list(selected_variable = "emp_rate")
    )
  ),
  ## HEALTH OPPORTUNITY INDEX PANEL -------------------------------------------
  page_section(
    type = "", id = "hoi_panel",
    input_button(
      "Health Opportunity Index",
      list(selected_variable = "health_opportunity_indicator")
    ),
    '<p class="lead" style="font-size:1em;text-weight:bold;">HOI Component Indexes</p>',
    input_button(
      "Economic Opportunity",
      list(selected_variable = "economic_opportunity_indicator")
    ),
    input_button(
      "Built Environment",
      list(selected_variable = "community_environment_indicator")
    ),
    input_button(
      "Consumer Opportunity",
      list(selected_variable = "consumer_opportunity_indicator")
    ),
    input_button(
      "Social Impact",
      list(selected_variable = "wellness_disparity_indicator")
    ),

    '<p class="lead" style="font-size:1em;text-weight:bold;">Related Measures</p>',
    input_button(
      "Job Participation",
      list(selected_variable = "job_participate_rate")
    ),
    input_button(
      "Employment Access",
      list(selected_variable = "employment_access_sqmi")
    ),
    input_button(
      "Income Inequality",
      list(selected_variable = "gini_index")
    ),
    input_button(
      "Material Deprivation",
      list(selected_variable = "material_deprivation_indicator")
    ),
    input_button(
      "Years of Schooling",
      list(selected_variable = "average_years_schooling")
    ),
    input_button(
      "Access to Food (VDH)",
      list(selected_variable = "food_accessibility_indicator")
    ),
    input_button(
      "Population Churn",
      list(selected_variable = "pop_churning_indicator")
    ),
    input_button(
      "Population Density",
      list(selected_variable = "population_density")
    ),
    input_button(
      "Segregation",
      list(selected_variable = "segregation_indicator")
    ),
    input_button(
      "Walkability",
      list(selected_variable = "walkability_indicator")
    ),
    input_button(
      "Affordability (H&T)",
      list(selected_variable = "affordability_index")
    ),
    input_button(
      "Air Quality",
      list(selected_variable = "air_quality_indicator")
    ),
    input_button(
      "Care Access (VDH)",
      list(selected_variable = "access_care_indicator"))),
  ## VCE UNIT PROFILES PANEL ------------------------------------------------
  page_section(
    type = "", id = "unit_profiles",
    ## DEMOGRAPHIC
    '<p class="lead" style="font-size:1em;text-weight:bold;">Demographic Summary</p>',
    # Population by Age
    input_button(
      "Population under 20",
      list(selected_variable = "perc_pop_under_20")
    ),
    input_button(
      "Population between 20 and 64",
      list(selected_variable = "perc_pop_20_64")
    ),
    input_button(
      "Population over 65",
      list(selected_variable = "perc_pop_65_plus")
    ),
    # Population by Sex
    input_button(
      "Male Population",
      list(selected_variable = "perc_male")
    ),
    input_button(
      "Female Population",
      list(selected_variable = "perc_female")
    ),
    # Population by Race
    input_button(
      "White Population",
      list(selected_variable = "perc_wht_alone")
    ),
    # N. Housing Units
    input_button(
      "Black or African American Population",
      list(selected_variable = "perc_afr_amer_alone")
    ),
    input_button(
      "American Indian Population",
      list(selected_variable = "perc_native_alone")
    ),
    input_button(
      "Asian/Pacific Islander Population",
      list(selected_variable = "perc_AAPI")
    ),
    # N. Housing Units
    input_button(
      "Other Race Population",
      list(selected_variable = "perc_other")
    ),
    input_button(
      "Two or More Races Population",
      list(selected_variable = "perc_two_or_more")
    ),
    input_button(
      "Hispanic Population",
      list(selected_variable = "perc_hispanic_or_latino")
    ),
    # Households by Income
    input_button(
      "Median Household Income",
      list(selected_variable = "median_household_income")
    ),
    # N. Housing Units
    input_button(
      "Children Raised by Grandparents",
      list(selected_variable = "perc_children_raised_by_GPs")
    ),
    input_button(
      "Without vehicle",
      list(selected_variable = "perc_no_vehicle")
    ),
    ## AGRICULTURE
    '<p class="lead" style="font-size:1em;text-weight:bold;">Agriculture Summary</p>',
    input_button(
      "Cropland Acerage",
      list(selected_variable = "total_cropland_acres")
    ),
    input_button(
      "Irrigated Cropland Acerage",
      list(selected_variable = "total_irrigatedCropland_acre")
    ),
    input_button(
      "Number of Cropland Operations",
      list(selected_variable = "total_cropland_operations")
    ),
    input_button(
      "Expenses towards Animal Industry",
      list(selected_variable = "total_animal_expense")
    ),
    input_button(
      "Sales of Fruits and Treenuts",
      list(selected_variable = "fruit_treeNut_total_sales")
    ),
    input_button(
      "Sales of Animal Products",
      list(selected_variable = "total_animalProducts_sales")
    ),
    input_button(
      "Sales of Commodities",
      list(selected_variable = "total_commodity_sales")
    ),
    input_button(
      "Sales of Calves",
      list(selected_variable = "total_calves_sales")
    ),
    '<p class="lead" style="font-size:1em;text-weight:bold;">Health Summary</p>',
    # Mortality
    # Morbidity
    input_button(
      "Poor physical health days",
      list(selected_variable = "perc_poor_phys_hlth_days_14_and_over")
    ),
    input_button(
      "Poor mental health days",
      list(selected_variable = "perc_poor_ment_hlth_days_14_and_over")
    ),
    # Health Behaviors
    # Clinical Care
    input_button(
      "Uninsured",
      list(selected_variable = "no_hlth_ins_pct")
    ),
    input_button(
      "Primary care physicians",
      list(selected_variable = "primcare_cnt")
    ),
    # Social and Economic Factors
    # Physical Environment
    '<p class="lead" style="font-size:1em;text-weight:bold;">Education Summary</p>',
    # School Enrollment
    # Educational Attainment
    input_button(
      "Postsecondary education",
      list(selected_variable = "acs_postsecondary_percent")
    ),
    # Percent of Age Group Enrolled
    '<p class="lead" style="font-size:1em;text-weight:bold;">Business and Employment Summary</p>'),
    # Population
    # SIC Codes
    # Retail Summary
    # Finance, Insurance, Estate Summary
    # Service Summary
  foot = input_switch("Share use data", "settings.tracking", as.checkbox = TRUE, note = paste(
    "Sharing your use data (via Google Analytics) supports this project,",
    "and can help us improve the site."
  ))
)

page_menu(
  input_checkbox(
    "Starting Layer", c("district", "county", "tract"), 1, c("Districts", "Counties", "Census Tracts"),
    id = "starting_shapes", multi = FALSE, note = "Which geographies to show at the state level."
  ),
  page_section(
    type = "col",
    wraps = "row form-row",
    input_combobox(
      "Health District", options = "ids", dataset = "district", dataview = "primary_view",
      id = "selected_district", clearable = TRUE, note = paste(
        "Health districts are sets of counties defined by the Virginia Department of Health."
      )
    ),
    input_combobox(
      "County", options = "ids", dataset = "county", dataview = "primary_view",
      id = "selected_county", selection_subset = "county_subset", clearable = TRUE
    ),
    conditions = c("lock: !selected_county", "starting_shapes != district || selected_district")
  ),
  input_checkbox(
    "Region Types", options = c("rural", "mixed", "urban"), id = "region_type", as.switch = TRUE,
    note = paste(
      "Which region types to include. Types are defined at the county level, so only health districts",
      "have mixed types, and all tracts are of the same type as their county."
    )
  ),
  page_section(
    type = "col",
    wraps = "row form-row",
    input_combobox(
      "Variable", options = "variables", group_feature = "category",
      default = "perc_hh_with_broadband", depends = "shapes",
      id = "selected_variable", note = paste(
        "Determines which variable is shown on the plot's y-axis, in the rank table,",
        "and info fields, and used to color map polygons and plot elements."
      )
    )
  ),
  position = "top",
  default_open = TRUE,
  sizes = c(1, NA, 1, NA)
)

## `input_variable` can be used to set up logical controls
input_variable("shapes", list(
  "starting_shapes == district && !selected_district" = "district",
  "starting_shapes == tract || selected_county" = "tract"
), "county")

input_variable("region_select", list(
  "shapes == county" = "selected_county"
), "selected_district")

input_variable("selected_region", list(
  "selected_county" = "selected_county"
), "selected_district")

input_variable("set_palette", list(
  "color_by_setting == rank" = "lajolla",
  "color_by_setting == quintile" = "greens5"
), "vik")

input_variable("county_subset", list(
  "selected_district" = "siblings"
), "full_filter")

input_rule("color_by_setting == value", list(settings.color_by_order = FALSE))
input_rule("color_by_setting != value", list(settings.color_by_order = TRUE))
input_rule("!settings.color_by_order", list(color_by_setting = "value"))
input_rule("settings.color_by_order && color_by_setting == value", list(color_by_setting = "rank"))

## `input_dataview` can collect multiple inputs as filters for a shared data view
input_dataview(
  "primary_view",
  y = "selected_variable",
  x = "selected_year",
  dataset = "shapes",
  ids = "selected_region",
  features = c(type = "region_type"),
  time_agg = "selected_year",
  palette = "set_palette"
)

# use `page_section` to build the page's layout
page_section(
  type = "col",
  # use `output_` functions to add state and data displays
  output_text(c(
    "State: Virginia[r selected_county,selected_district]",
    "? > Health District: {selected_district}[r selected_county]",
    "? > {selected_county}"
  ), class = "compact"),
  output_text(list(
    "default" = "Virginia Counties",
    "starting_shapes == tract" = "Virginia Census Tracts",
    "starting_shapes == district" = "Virginia (Health Districts)[note: Sets of counties defined by the Virginia Department of Health.]",
    "selected_district" = "{selected_district} Counties",
    "selected_county" = "{selected_county} Census Tracts"
  ), tag = "h1", class = "text-center"),
  page_section(
    type = "container-xsm",
    input_number(
      "Selected Year", min = "filter.time_min", max = "filter.time_max", default = "max",
      id = "selected_year", buttons = TRUE, show_range = TRUE, note = paste(
        "Year of the selected variable to color the map shapes and plot elements by, and to show on hover."
      )
    )
  ),
  page_section(
    type = "row",
    wraps = "col",
    sizes = c(NA, 5),
    output_map(
      list(
        list(
          name = "tract",
          time = 2010,
          url = paste0(
            "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/VA/Census%20Geographies/",
            "Tract/2010/data/distribution/va_geo_census_cb_2010_census_tracts.geojson"
          )
        ),
        list(
          name = "county",
          time = 2010,
          url = paste0(
            "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/VA/Census%20Geographies/",
            "County/2010/data/distribution/va_geo_census_cb_2010_counties.geojson"
          )
        ),
        list(
          name = "tract",
          time = 2020,
          url = paste0(
            "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/VA/Census%20Geographies/",
            "Tract/2020/data/distribution/va_geo_census_cb_2020_census_tracts.geojson"
          )
        ),
        list(
          name = "county",
          time = 2020,
          url = paste0(
            "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/VA/Census%20Geographies/",
            "County/2020/data/distribution/va_geo_census_cb_2020_counties.geojson"
          )
        ),
        list(
          name = "district",
          url = paste0(
            "https://raw.githubusercontent.com/uva-bi-sdad/sdc.geographies/main/VA/State%20Geographies/Health%20Districts/",
            "2020/data/distribution/va_geo_vhd_2020_health_districts.geojson"
          )
        )
      ),
      dataview = "primary_view",
      click = "region_select",
      id = "main_map",
      subto = c("main_plot", "rank_table", "main_legend"),
      options = list(
        attributionControl = FALSE,
        scrollWheelZoom = FALSE,
        center = c(38, -79.5),
        zoom = 7,
        height = "430px"
      ),
      background_shapes = "county",
      tiles = list(
        light = list(url = "https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png"),
        dark = list(url = "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png")
      ),
      attribution = list(
        list(
          name = "Stamen toner-light",
          url = "https://stamen.com",
          description = "Light-theme map tiles by Stamen Design"
        ),
        list(
          name = "CARTO Dark Matter",
          url = "https://carto.com/attributions",
          description = "Dark-theme map tiles by CARTO"
        ),
        list(
          name = "OpenStreetMap",
          url = "https://www.openstreetmap.org/copyright"
        )
      )
    ),
    page_section(
      type = "flex-column col",
      output_info(
        title = "variables.short_name",
        dataview = "primary_view",
        id = "variable_info_pane",
      ),
      page_popup(
        "Export",
        page_section(
          wraps = "col",
          input_select("Table Format", c("tall", "mixed", "wide"), "mixed", id = "export_table_format"),
          input_select("File Format", c("csv", "tsv"), "csv", c("CSV", "TSV"), id = "export_file_format")
        ),
        input_button(
          "Download", "export", dataview = "primary_view", query = list(
            include = "selected_variable",
            features = list(geoid = "id", name = "name"),
            table_format = "export_table_format", file_format = "export_file_format"
          ), class = "btn-full"
        ),
        input_button(
          "Copy API link", "copy", dataview = "primary_view", query = list(
            include = "selected_variable", dataset = "shapes",
            features = list(geoid = "id", name = "name"),
            table_format = "export_table_format", file_format = "export_file_format"
          ), class = "btn-full"
        )
      ),
      output_info(body = "summary", dataview = "primary_view"),
      output_info("Filters", "filter", dataview = "primary_view"),
      page_section(
        output_info(
          title = "features.name",
          default = c(title = "Virginia", body = "Hover over or select a region for more information."),
          dataview = "primary_view",
          subto = c("main_map", "main_plot", "rank_table", "main_legend")
        ),
        output_info(
          body = c(
            "Region Type" = "features.type",
            "variables.long_name" = "selected_variable",
            "variables.statement"
          ),
          row_style = c("table", "stack"),
          dataview = "primary_view",
          subto = c("main_map", "main_plot", "rank_table", "main_legend"),
          variable_info = FALSE
        )
      )
    )
  ),
  page_section(
    type = "row",
    wraps = "col",
    sizes = c(5, 7),
    page_section(
      page_section(
        wraps = "col-md",
        sizes = c(NA, 1),
        output_legend(
          "settings.palette", dataview = "primary_view", click = "region_select",
          subto = c("main_map", "main_plot", "rank_table"), id = "main_legend"
        ),
        input_checkbox(
          "Color By", c("value", "rank", "quintile"), 0,
          id = "color_by_setting", multi = FALSE, class = "compact"
        )
      ),
      output_table("selected_variable", dataview = "primary_view", options = list(
        info = FALSE,
        searching = FALSE,
        scrollY = 300,
        dom = "<'row't>"
      ), id = "rank_table", click = "region_select", subto = c("main_map", "main_plot", "main_legend"))
    ),
    output_plot(
      x = "time", y = "selected_variable", dataview = "primary_view",
      click = "region_select", subto = c("main_map", "rank_table", "main_legend"), id = "main_plot",
      options = list(
        layout = list(
          xaxis = list(title = FALSE, fixedrange = TRUE),
          yaxis = list(fixedrange = TRUE, zeroline = FALSE)
        ),
        data = data.frame(
          type = c("plot_type", "box"), fillcolor = c(NA, "transparent"),
          hoverinfo = c("text", NA), mode = "lines+markers", showlegend = FALSE,
          name = c(NA, "Summary"), marker.line.color = "#767676", marker.line.width = 1
        ),
        config = list(modeBarButtonsToRemove = c("select2d", "lasso2d", "sendDataToCloud"))
      )
    )
  )
)
