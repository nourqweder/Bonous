context("ridgereg")

data("iris")

Polygon <- setRefClass("Polygon", fields = c("sides"))
square <- Polygon$new(sides = 4)
test_that("ridgereg rejects errounous input", {
  expect_error(ridgereg_obj <- ridgereg$new(formula = Petal.Length~Sepdsal.Width+Sepal.Length, data=iris))
  expect_error(ridgereg_obj <- ridgereg$new(formula = Petal.Length~Sepdsal.Width+Sepal.Length, data=irfsfdis))
  expect_error(ridgereg_obj <- ridgereg$new(formula = Petal.Length~Sepdsal.Width+Sepal.Length, data=iris, lambda="1"))
  expect_error(ridgereg$new(formula = c(Petal.Length, Sepal.Width, Sepal.Length), data=Nour, lambda=1))
})


test_that("class is correct", {
  ridgereg_obj <- ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 1)

  expect_true(class(ridgereg_obj)[1] == "ridgereg")
})


test_that("predict() function works", {
  ridgereg_obj <- ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda=0.5)
  expect_equal(round(unname(ridgereg_obj$predict()[c(1,20,79)]),2), c(1.84, 1.44, 4.23))
  expect_equal(round(unname(ridgereg_obj$predict(newdata = iris[1:3,])),2), c(4.59, 4.29, 2.36))
  expect_error(ridgereg_obj$predict(newdata=mtcars))
})


test_that("coef() function works", {
  ridgereg_obj <- ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda=0.5)

  #normalized covariates in real lm.ridge
  newdata <- iris[,colnames(iris) %in% all.vars(Petal.Length~Sepal.Width+Sepal.Length)[-1]]
  newdata <- scale(newdata)
  newdata <- data.frame(Petal.Length=iris[,colnames(iris) %in% all.vars(Petal.Length~Sepal.Width+Sepal.Length)[1]], newdata)
  ridge2 <- MASS::lm.ridge(formula=Petal.Length~Sepal.Width+Sepal.Length, data=newdata, lambda=0.5)

  expect_equal(round(ridgereg_obj$coef()[-1],1), round(ridge2$coef,1))
})

