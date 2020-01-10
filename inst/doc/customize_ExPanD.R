## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----intro, eval = FALSE------------------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  
#  ExPanD(df = gapminder, cs_id = "country", ts_id = "year")

## ----omit_components, eval = FALSE--------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  ExPanD(df = gapminder, cs_id = "country", ts_id = "year",
#         components = c(sample_selection = FALSE, missing_values = FALSE))

## ----select_components, eval = FALSE------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  ExPanD(df = gapminder, cs_id = "country", ts_id = "year",
#         components = c(descriptive_table = TRUE,
#                        by_group_violin_graph = TRUE,
#                        scatter_plot = TRUE,
#                        regression = TRUE))

## ----include_intro, eval = FALSE----------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  ExPanD(df = gapminder, cs_id = "country", ts_id = "year",
#         title = "Explore the Preston Curve",
#         abstract = paste("This interactive display uses 'gapminder' data to",
#                          "let you explore the Preston Curve. Scroll down and enjoy!"),
#         components = c(descriptive_table = TRUE,
#                        by_group_violin_graph = TRUE,
#                        scatter_plot = TRUE,
#                        regression = TRUE))

## ----include_df_def, eval = FALSE---------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  df_def <- data.frame(
#    var_name = names(gapminder),
#    var_def = c("Name of the country",
#                "Continent where country is located",
#                "Year of data",
#                "Life expectancy in years at birth",
#                "Population in million",
#                "Gross Domestic Product (GDP) per capita"),
#    type = c("cs_id", "factor", "ts_id", rep("numeric", 3))
#  )
#  
#  gapminder$pop <- gapminder$pop / 1e6
#  
#  ExPanD(df = gapminder,
#         title = "Explore the Preston Curve",
#         abstract = paste("This interactive display uses 'gapminder' data to",
#                          "let you explore the Preston Curve. Scroll down and enjoy!"),
#         components = c(descriptive_table = TRUE,
#                        by_group_violin_graph = TRUE,
#                        quantile_trend_graph = TRUE,
#                        scatter_plot = TRUE,
#                        regression = TRUE),
#         df_def = df_def)

## ----include_dl_clist, eval = FALSE-------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  df_def <- data.frame(
#    var_name = names(gapminder),
#    var_def = c("Name of the country",
#                "Continent where country is located",
#                "Year of data",
#                "Life expectancy in years at birth",
#                "Population in million",
#                "Gross Domestic Product (GDP) per capita"),
#    type = c("cs_id", "factor", "ts_id", rep("numeric", 3))
#  )
#  
#  gapminder$pop <- gapminder$pop / 1e6
#  
#  clist <- readRDS("my_config.RDS")
#  
#  ExPanD(df = gapminder,
#         title = "Explore the Preston Curve",
#         abstract = paste("This interactive display uses 'gapminder' data to",
#                          "let you explore the Preston Curve. Scroll down and enjoy!"),
#         components = c(descriptive_table = TRUE,
#                        by_group_violin_graph = TRUE,
#                        scatter_plot = TRUE,
#                        regression = TRUE),
#         df_def = df_def,
#         config_list = clist)

## ----include_manual_clist, eval = FALSE---------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  df_def <- data.frame(
#    var_name = names(gapminder),
#    var_def = c("Name of the country",
#                "Continent where country is located",
#                "Year of data",
#                "Life expectancy at birth, in years",
#                "Population in million",
#                "Gross Domestic Product (GDP) per capita in US-$, inflation-adjusted"),
#    type = c("cs_id", "factor", "ts_id", rep("numeric", 3)),
#    stringsAsFactors = FALSE
#  )
#  
#  gapminder$pop <- gapminder$pop / 1e6
#  
#  clist <- list(
#    scatter_x = "gdpPercap",
#    scatter_y = "lifeExp",
#    scatter_size = "pop",
#    scatter_color = "continent",
#    scatter_loess = TRUE,
#    scatter_sample = FALSE,
#  
#    reg_y = "lifeExp",
#    reg_x = "gdpPercap",
#    reg_fe1 = "country",
#    reg_fe2 = "year",
#    cluster = "4" # Now this is hard to guess
#    # 1: none, 2: first FE, 3: second FE, 4: both FE
#  )
#  
#  ExPanD(df = gapminder,
#         title = "Explore the Preston Curve",
#         abstract = paste("This interactive display uses 'gapminder' data to",
#                          "let you explore the Preston Curve. Scroll down and enjoy!"),
#         components = c(descriptive_table = TRUE,
#                        by_group_violin_graph = TRUE,
#                        scatter_plot = TRUE,
#                        regression = TRUE),
#         df_def = df_def,
#         config_list = clist)

## ----include_udvs, eval = FALSE-----------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  df_def <- data.frame(
#    var_name = names(gapminder),
#    var_def = c("Name of the country",
#                "Continent where country is located",
#                "Year of data",
#                "Life expectancy in years at birth",
#                "Population in million",
#                "Gross Domestic Product (GDP) per capita"),
#    type = c("cs_id", "factor", "ts_id", rep("numeric", 3)),
#    stringsAsFactors = FALSE
#  )
#  
#  gapminder$pop <- gapminder$pop / 1e6
#  
#  clist <- list(
#    scatter_x = "gdpPercap",
#    scatter_y = "lifeExp",
#    scatter_size = "pop",
#    scatter_color = "continent",
#    scatter_loess = TRUE,
#    scatter_sample = FALSE,
#  
#    reg_y = "lifeExp",
#    reg_x = "gdpPercap",
#    reg_fe1 = "country",
#    reg_fe2 = "year",
#    cluster = "4" # No this is hard to guess 1: none, 2: first FE, 3: second FE, 4: both FE
#  )
#  
#  ExPanD(df = gapminder,
#         title = "Explore the Preston Curve",
#         abstract = paste("This interactive display uses 'gapminder' data to",
#                          "let you explore the Preston Curve. Scroll down and enjoy!"),
#         components = c(descriptive_table = TRUE,
#                        by_group_violin_graph = TRUE,
#                        scatter_plot = TRUE,
#                        udvars = TRUE,
#                        regression = TRUE),
#         df_def = df_def,
#         config_list = clist)

## ----include_html, eval = FALSE-----------------------------------------------
#  library(ExPanDaR)
#  library(gapminder)
#  data(gapminder)
#  
#  df_def <- data.frame(
#    var_name = names(gapminder),
#    var_def = c("Name of the country",
#                "Continent where country is located",
#                "Year of data",
#                "Life expectancy in years at birth",
#                "Population in million",
#                "Gross Domestic Product (GDP) per capita"),
#    type = c("cs_id", "factor", "ts_id", rep("numeric", 3)),
#    stringsAsFactors = FALSE
#  )
#  
#  gapminder$pop <- gapminder$pop / 1e6
#  
#  clist <- list(
#    scatter_x = "gdpPercap",
#    scatter_y = "lifeExp",
#    scatter_size = "pop",
#    scatter_color = "continent",
#    scatter_loess = TRUE,
#    scatter_sample = FALSE,
#  
#    reg_y = "lifeExp",
#    reg_x = "gdpPercap",
#    reg_fe1 = "country",
#    reg_fe2 = "year",
#    cluster = "4" # No this is hard to guess 1: none, 2: first FE, 3: second FE, 4: both FE
#  )
#  
#  html_blocks <- c(
#    paste('<div class="col-sm-2"><h3>Variation of life expectancy',
#          "across regions and income levels</h3></div>",
#          '<div class="col-sm-10">',
#          "<p>&nbsp;</p>As you see below, life expectancy varies widely",
#          "across countries and continents. One potential reason for this",
#          "variation is the difference in income levels across countries.",
#          "This association is visualized by the",
#          "<a href=https://en.wikipedia.org/wiki/Preston_curve>",
#          "Preston Curve</a> that you also find below.",
#          "</div>"),
#    paste('<div class="col-sm-2"><h3>Transform variables</h3></div>',
#          '<div class="col-sm-10">',
#          "The Preston Curve is far from",
#          "linear. Maybe you can come up with a transformation",
#          "of GDP per capita that makes the association",
#          "a little bit more well behaved?",
#          "Use the dialog below to define a transformed",
#          "measure of GDP per capita and assess its association",
#          "with life expectancy in the scatter plot above.",
#          "</div>"),
#    paste('<div class="col-sm-2"><h3>Assess Robustness</h3></div>',
#          '<div class="col-sm-10">',
#          "You see below that the linear regression coefficient",
#          "for GDP per capita is <i>negative</i>",
#          "and signficant in a panel model with country and year",
#          "fixed effects.",
#          "Does this also hold when you use a log-transformed version",
#          "of GDP per capita?",
#          "</div>")
#  )
#  
#  ExPanD(df = gapminder,
#         title = "Explore the Preston Curve",
#         abstract = paste("This interactive display uses 'gapminder' data to",
#                          "let you explore the Preston Curve. Scroll down and enjoy!"),
#         components = c(descriptive_table = TRUE,
#                        html_block = TRUE,
#                        by_group_violin_graph = TRUE,
#                        scatter_plot = TRUE,
#                        html_block = TRUE,
#                        udvars = TRUE,
#                        html_block = TRUE,
#                        regression = TRUE),
#         df_def = df_def,
#         config_list = clist,
#         html_blocks = html_blocks)

