# R packages for fresh installation

# core packages
install.packages(c("tidyverse", "devtools", "remotes"))

install.packages(c(
"afex",
"blogdown",
"bookdown",
"broom",
"cowplot",
"datarium",
"DT",
"effsize",
"emmeans",
"emojifont",
"faux",
"gsDesign",
"here",
"huxtable",
"jmv",
"kableExtra",
"knitr",
"leaflet",
"learnr",
"lme4",
"meta",
"metafor",
"miniUI",
"MOTE",
"pagedown",
"pwr",
"RefManageR",
"renv",
"rmarkdown",
"simstudy",
"statcheck",
"TOSTER",
"vitae",
"WebPower",
"xaringan",
"xaringanthemer"
))

devtools::install_github("gadenbuie/xaringanExtra")
devtools::install_github("ropenscilabs/icon")
devtools::install_github("profandyfield/adventr", dependencies = TRUE)
devtools::install_github("MathiasHarrer/dmetar")
remotes::install_github("profandyfield/discovr")

# other
remotes::install_github("rstudio/fontawesome")
devtools::install_github("gadenbuie/rsthemes")
devtools::install_github("infotroph/DeLuciatoR") # for ggsave_fitmax
devtools::install_github("crsh/papaja")
