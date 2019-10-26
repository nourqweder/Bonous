context("ridgereg")

data("iris")

Polygon <- setRefClass("Polygon", fields = c("sides"))
square <- Polygon$new(sides = 4)
test_that("ridgereg rejects errounous input", {
  expect_error(ridgereg_obj <- ridgereg$new(formula = Petal.Length~Sepdsal.Width+Sepal.Length, data=iris))
  expect_error(ridgereg_obj <- ridgereg$new(formula = Petal.Length~Sepdsal.Width+Sepal.Length, data=irfsfdis))
})


test_that("class is correct", {
  ridgereg_obj <- ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 1)

  expect_true(class(ridgereg_obj)[1] == "ridgereg")
})
