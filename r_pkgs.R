# R packages for fresh installation

install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")
pak::pak_setup()

pak::pkg_install(c(
  "tidyverse",
  "afex",
  "blogdown",
  "bookdown",
  "broom",
  "BUCSS",
  "cowplot",
  "datarium",
  "DT",
  "easypower",
  "effsize",
  "emmeans",
  "emojifont",
  "faux",
  "gsDesign",
  "here",
  "huxtable",
  "jmv",
  "JuliaConnectoR",
  "kableExtra",
  "knitr",
  "komaletter",
  "leaflet",
  "learnr",
  "linl",
  "lme4",
  "MBESS",
  "meta",
  "metafor",
  "miniUI",
  "modelbased",
  "MOTE",
  "pagedown",
  "PASWR2",
  "pwr",
  "psych",
  "RefManageR",
  "renv",
  "rmarkdown",
  "Routliers",
  "rpact",
  "simstudy",
  "statcheck",
  "tint",
  "TOSTER",
  "usethis",
  "ufs",
  "vitae",
  "WebPower",
  "weightr",
  "xaringan",
  "xaringanthemer"
))

pak::pkg_install("gadenbuie/xaringanExtra")
pak::pkg_install("ropenscilabs/icon")
pak::pkg_install("MathiasHarrer/dmetar")
pak::pkg_install("rstudio/fontawesome")
pak::pkg_install("profandyfield/adventr")
pak::pkg_install("profandyfield/discovr")
pak::pkg_install("gadenbuie/rsthemes")
pak::pkg_install("crsh/prereg")
pak::pkg_install("GRousselet/rogme")
pak::pkg_install("easystats/easystats")

#remotes::install_github("statisfactions/simpr")
#devtools::install_github("gadenbuie/rsthemes")
#devtools::install_github("infotroph/DeLuciatoR") # for ggsave_fitmax
#devtools::install_github("crsh/papaja")
