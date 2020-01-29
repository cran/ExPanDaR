## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE, 
  fig.align = "center", 
  fig.width = 6,
  warnings = FALSE
)

library(ExPanDaR)
library(knitr)
library(kableExtra)
library(ggplot2)

nb_df <- russell_3000
nb_df_def <- cbind(
  russell_3000_data_def, 
  can_be_na = c(rep(FALSE, 3), rep(TRUE, 21))
) 

nb_df_def$var_def <- sub('$', '\\$', nb_df_def$var_def, fixed = TRUE)

create_sample <- function(df, df_def) {
  # Set infinite numerical variables to NA
  df[, df_def$var_name[df_def$type == "numeric"]] <-
    lapply(df[, df_def$var_name[df_def$type == "numeric"]],
      function(x) ifelse(is.finite(x), x, NA))
 
  # Delete numerical variables that only contain NAs
  all_na_vars <- sapply(df, function (x) all(is.na(x)))
  df_def <- df_def[!all_na_vars,]
  df <- df[, df_def$var_name]
 
  # Drop observations that are NA in variables that are not allowed to
  df <- df[complete.cases(df[, df_def$var_name[which(df_def$can_be_na == FALSE)]]), ]
 
  # Outlier treatment as requested in ExPanD()
  nums <- df_def$var_name[df_def$type == "numeric"]
  df[, nums] <- treat_outliers(df[, nums], 0.01, FALSE, NULL)
 
  df <- droplevels(df)
  return(list(df = df, df_def = df_def))
}

smp_list <- create_sample(nb_df, nb_df_def)
smp <- smp_list$df
smp_def <- smp_list$df_def

## ----startExPanD, eval = FALSE------------------------------------------------
#  library(ExPanDaR)
#  
#  ExPanD(df = russell_3000,
#         df_def = russell_3000_data_def,
#         df_name = "Russell 3000",
#         config_list = ExPanD_config_russell_3000,
#         export_nb_option = TRUE)

## ---- out.width = "80%", fig.align="center", fig.border = "none", echo=FALSE----
knitr::include_graphics("figures/expand_export_button.png")

## ----create_sample, eval = FALSE----------------------------------------------
#  create_sample <- function(df, df_def) {
#    # Set infinite numerical variables to NA
#    df[, df_def$var_name[df_def$type == "numeric"]] <-
#      lapply(df[, df_def$var_name[df_def$type == "numeric"]],
#        function(x) ifelse(is.finite(x), x, NA))
#  
#    # Delete numerical variables that only contain NAs
#    all_na_vars <- sapply(df, function (x) all(is.na(x)))
#    df_def <- df_def[!all_na_vars,]
#    df <- df[, df_def$var_name]
#  
#    # Drop observations that are NA in variables that are not allowed to
#    df <- df[complete.cases(df[, df_def$var_name[which(df_def$can_be_na == FALSE)]]), ]
#  
#    # Outlier treatment as requested in ExPanD()
#    nums <- df_def$var_name[df_def$type == "numeric"]
#    df[, nums] <- treat_outliers(df[, nums], 0.01, FALSE, NULL)
#  
#    df <- droplevels(df)
#    return(list(df = df, df_def = df_def))
#  }
#  
#  load("ExPanD_nb_data.Rdata")
#  
#  smp_list <- create_sample(nb_df, nb_df_def)
#  smp <- smp_list$df
#  smp_def <- smp_list$df_def

## ----display_nb_df------------------------------------------------------------
kable(head(nb_df[, 1:7]), row.names = FALSE)

## ----display_nb_df_def--------------------------------------------------------
kable(nb_df_def, row.names = FALSE) 

## ----bar_chart----------------------------------------------------------------
df <- smp
df$period <- as.factor(df$period)
df$sector <- as.factor(df$sector)
p <- ggplot(df, aes(x = period)) +
  geom_bar(aes(fill= sector), position = "stack") +
  labs(x = "period", fill = "sector")
p

## ----histogram----------------------------------------------------------------
var <- as.numeric(smp$nioa)
hist(var, main="", xlab = "nioa", col="red", right = FALSE, breaks= 150)

## ----descriptive_statistics---------------------------------------------------
df <- smp
t <- prepare_descriptive_table(smp)
t$kable_ret  %>%
  kable_styling("condensed", full_width = F, position = "center")

## ----scatter_plot1------------------------------------------------------------
df <- smp
df <- df[, c("coid", "coname", "period", "nioa", "return", "sector", "toas")]
df <- df[complete.cases(df), ]
df$sector <- as.factor(df$sector)
prepare_scatter_plot(df, "nioa", "return", color = "sector", size = "toas", loess = 1)

## ----scatter_plot2------------------------------------------------------------
df <- smp
df <- df[, c("coid", "coname", "period", "cfoa", "return", "sector", "toas")]
df <- df[complete.cases(df), ]
df$sector <- as.factor(df$sector)
prepare_scatter_plot(df, "cfoa", "return", color = "sector", size = "toas", loess = 1)

