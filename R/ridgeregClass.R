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

                           # 1. Calculations using least squares.

                           y<-data[,colnames(data)==all.vars(formula)[1]]# y is the dependent variable/s in this formula

                           # Define matrix
                           X <- model.matrix(object=formula, data=data)# x is the independent variables

                           # 2. Normlization
                           X<-model.matrix(object=formula, data=data)
                           X[,2:ncol(X)] <- scale(X[,-1]) #Normalizing
                           ##3.  Compute Estimations
                           # Regression coefficients:
                           #betaHat <<- coef(lm(y ~ x))

                           result$coef <- solve(t(X) %*% X + diag(lambda, nrow = ncol(X))) %*% (t(X) %*% y)
                           # yHat = X*bHat  === yhat = beta0 + beta1*x
                           # The fitted values:
                           #betaZero <- mean(y)
                           result$fitted <- X %*% result$coef
                           return(result)
                         },
                         #--------------------------------------------------------------------------------------
                          print=function()
                         {
                          "print out the coefficients and coefficient names, similar as done by the lm class."
                            myData <- as.character(deparse(substitute(data)))
                           cat("ridgereg(formula = ", deparse(formula), ", data = ", myData, ", lambda = ", lambda, ")", "\n", "\n", sep="")
                           cat("Coefficients:", "\n")
                           structure(c(calculateValues()[[1]]), names=rownames(calculateValues()[[1]]))
                         },
                         #--------------------------------------------------------------------------------------
                        predict = function(newdata = NULL)
                         {
                          "return the predicted values ^y, it should be able to predict for new dataset similar"
                            if(is.null(newdata)){
                              result <- structure(c(calculateValues()[[2]]), names=(1:length(calculateValues()[[2]])))
                            } else
                              { # if the new data doesn't match formula
                            # stopifnot(is.data.frame(newdata) , !all(all.vars(formula)%in%colnames(newdata)),
                             #           !all(sapply(newdata[,colnames(newdata) %in% all.vars(formula)],is.numeric)))
                                if(!is.data.frame(newdata)) stop("the input data is in wrong form is not a data frame")
                                if(!all(all.vars(formula)%in%colnames(newdata))) stop("newdata mis match the style of formula")
                                if(!all(sapply(newdata[,colnames(newdata) %in% all.vars(formula)],is.numeric))) stop("numeric mis match")


                              X<-model.matrix(object=formula, data =newdata)
                              X[,2:ncol(X)] <- scale(X[,-1])
                              result <- (X %*% calculateValues()[[1]])[,1]
                            }
                            return(result)
                                                 },
                         #--------------------------------------------------------------------------------------
                        coef = function()
                        {#^ ridge =( XTX + I)1

                         "return the ridge regression coefficients ^y ridge"

                          structure(c(calculateValues()[[1]]), names=rownames(calculateValues()[[1]]))
                        })
                        )




#How to use it
#lambda <- 1
#data <- iris[,1:4]
#formula <- Sepal.Length ~ Sepal.Width + Petal.Length
#class(formula)
#ridgeregObj <- ridgereg$new(formula, data,lambda)
#ridgeregObj$print()
#ridgeregObj$coef()
#head(ridgeregObj$calculateValues()[[2]])
#ridgeregObj$predict()
#newdata <- iris[35:40,1:4]
#ridgeregObj$predict(newdata=newdata)

#ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 0)$coef()

#calculateValues()
#traceback()
