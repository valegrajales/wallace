context("test-workflow")
skip_on_travis()
skip_on_cran()

# Load the package
library(RSelenium)
library(testthat)
library(XML)

comps <- paste0('c', 1:8)

for (i in comps) {
  test_dir('/Users/musasabi/Documents/github/wallace/test', filter = i, reporter = "Tap")  
}

