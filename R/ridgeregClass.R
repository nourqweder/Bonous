#' Ridge regression class
#' @title Ridge regression
#'
#'
#' ridgereg(formula, data, lambda).
#' Ridge regression can be a good alternative when we have a lot of covariates (when p > n) or in the
#' situation of multicollinearity. More information on ridge regression can be found in chapter 3.4.1 in [1].
#' @field lambda argument lambda a constant for ridge. "a hyperparameter"
#' @field formula formula, is a object of class formula. format y ~ x_1 + x_2 + ... + x_n.
#' @field data data.frame, The data is typically a data.frame. The gieven data set.
#' @references Reference Classes: \url{http://adv-r.had.co.nz/R5.html}
#' @description Returns the result of the Ridge Regression
#' @examples
#' data(iris)
#' ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 0)$print()
#' ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 0)$predict()
#' ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 0)$coef()
#' @export ridgereg
#' @export
#'
ridgereg <- setRefClass("ridgereg",
                          fields = list(
                        formula = "formula",
                        data = "data.frame",
                        lambda= "numeric"
                        ),
                         methods= list(

                         #--------------------------------------------------------------------------------------
                         #ridgereg(formula, data, lambda)
                         initialize = function(formula, data,lambda ){
                           # 1- Check validation & initialize
                           stopifnot(is.data.frame(data), length(lambda) == 1, class(formula) == "formula")
                           data <<-data
                           formula <<-formula
                           lambda <<-lambda
                           normalise <- TRUE

                         },
                         #--------------------------------------------------------------------------------------
                         #2- calculate values
                         #The goal here is to establish a mathematical equation for a ridge regression model
                          calculateValues = function()
                          {
                           result <- list()

                           # Define matrix
                           X <- model.matrix(formula, data)# x is the independent variables

                           # 1. Normlization
                           X[,2:ncol(X)] <- scale( X[,-1])

                           # 2. Calculations using least squares.
                           dependentVar <- all.vars(expr = formula)[1]
                           y <- data[, dependentVar] # y is the dependent variable/s in this formula
                           I <- diag(ncol(x))


                           ##3.  Compute Estimations
                           # Regression coefficients:
                           #betaHat <<- coef(lm(y ~ x))

                           result$coef  <- as.vector(solve( t(x) %*% x + lambda * I) %*% t(x) %*% y)

                           # yHat = X*bHat  === yhat = beta0 + beta1*x
                           # The fitted values:
                           #betaZero <- mean(y)
                           result$fittedValues <- x %*% result$coef
                           return(result)
                         },
                         #--------------------------------------------------------------------------------------
                          print=function()
                         {
                          "print out the coefficients and coefficient names, similar as done by the lm class."
                           cat(paste("call: \n"))
                           cat(paste("ridgereg(formula = ", deparse(formula), ", data = ", deparse(substitute(data))," lambda = ", lambda, ")\n\n", sep = ""))
                           cat(paste("Coefficients:\n"))
                           info <- calculateValues()[[1]]
                           structure( c(info), names = row.names(info))
                         }))
                         #--------------------------------------------------------------------------------------
                          ridgereg$methods(predict = function()
                         {
                          "return the predicted values ^y, it should be able to predict for new dataset similar"

                         })
                         #--------------------------------------------------------------------------------------
                        ridgereg$methods(coef = function()
                        {#^ ridge =( XTX + I)1

                         "return the ridge regression coefficients ^ ridge"
                          info <- calculateValues()[[1]]
                          structure( c(info), names = row.names(info))

                        })




lambda <- 1

data <- iris[,1:4]
formula <- Sepal.Length ~ Sepal.Width + Petal.Length
class(formula)
x<-model.matrix(formula, data)
head(x)
formula <- Sepal.Length ~ Sepal.Width + Petal.Length
o <- ridgereg$new(formula, data,lambda)
o$print()
#X<-model.matrix(formula, data)
#x[,2:ncol(x)] <- scale(x[,-1]) #Normalizing
#head(X)

calculateValues()
traceback()

#lm.ridge(formula, data,lambda = lambda)
#lm.ridge(formula, data)
data(flights)
o <- ridgereg$new(formula, data,lambda)
o$coef()
