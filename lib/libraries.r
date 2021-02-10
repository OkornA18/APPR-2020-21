library(knitr)
library(rvest)
library(gsubfn)
library(shiny)
library(tidyr)
library(tmap)

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")

options(gsubfn.engine="R")

library(plotrix)

