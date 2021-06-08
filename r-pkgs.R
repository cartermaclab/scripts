# R packages for fresh installation

install.packages("pak", repos = "https://r-lib.github.io/p/pak/dev/")

cran_pkgs <- c(
  "tidyverse",
  "askpass",
  "afex",
  "blogdown",
  "bookdown",
  "BUCSS",
  "cowplot",
  "datarium",
  #"DescTools",
  "devtools",
  "DT",
  "easypower",
  "effsize",
  "emmeans",
  "emojifont",
  "faux",
  "ggfortify",
  "ggpubr",
  "gsDesign",
  "ggthemes",
  "here",
  "hrbrthemes",
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
  "lmerTest",
  "MBESS",
  "meta",
  "metafor",
  "miniUI",
  "modelbased",
  "MOTE",
  "nlme",
  "pagedown",
  "palmerpenguins",
  "parallelly",
  "PASWR2",
  "pwr",
  "psych",
  "RefManageR",
  "remotes",
  "renv",
  "rmarkdown",
  "Routliers",
  "rpact",
  "simstudy",
  "statcheck",
  "tint",
  #"TOSTER",
  "usethis",
  "ufs",
  "vitae",
  "WebPower",
  "weightr",
  "WRS2",
  "xaringan",
  "xaringanthemer"
)

pak::pkg_install(cran_pkgs)

gh_pkgs <- c(
  "arcaldwell49/Superpower",
  "brentthorne/posterdown",
  "crsh/papaja",
  "crsh/prereg",
  "gadenbuie/xaringanExtra",
  "gadenbuie/rsthemes",
  "GRousselet/rogme",
  "hrbrmstr/waffle",
  "Lakens/TOSTER",
  "MathiasHarrer/dmetar",
  "profandyfield/adventr",
  "profandyfield/discovr",
  "ropenscilabs/icon",
  "rstudio/fontawesome"
)

pak::pkg_install(gh_pkgs)

#pak::pkg_install("easystats/easystats")
#pak::pkg_install("statisfactions/simpr")
#pak::pkg_install("infotroph/DeLuciatoR") # for ggsave_fitmax
