#' Ridge regression class
#'
#'
#' @description
#' ridgereg(formula, data, lambda).
#' Ridge regression can be a good alternative when we have a lot of covariates (when p > n) or in the
#' situation of multicollinearity. More information on ridge regression can be found in chapter 3.4.1 in [1].
#' @field lambda argument lambda a constant for ridge
#' @field myFormula formula, is a object of class formula.
#' @field myData character, The data is typically a data.frame. The gieven data set.
#'
#' @references Reference Classes: \url{http://adv-r.had.co.nz/R5.html}
#'
#' QR decomposition: \url{https://en.wikipedia.org/wiki/QR_decomposition}
#'
#' Vignettes: \url{http://r-pkgs.had.co.nz/vignettes.html}
#'
#' @importFrom methods new
#'
#' @export ridgereg
#' @exportClass ridgereg
#'
ridgereg <- setRefClass("ridgereg",
                      fields = list(
                         #x = "ANY", #Independent Values (is considered to be an explaantory variable)
                         #y = "ANY", #Depenent Values (whose value we want to explain or forecast)
                         #betaHat ="matrix", #
                         #fittedValues = "matrix",
                         #epsilon = "matrix",
                         #n = "numeric",
                         #p = "numeric",
                         #df = "numeric",
                         #segmaSequare = "matrix",
                         #regressionsVar = "matrix",
                         #tValue = "matrix",
                         #pValues = "numeric",
                        formula = "formula",
                        data = "character",
                         lambda= "numeric"
                        ),
                         methods= list(

                         #--------------------------------------------------------------------------------------
                         #ridgereg(formula, data, lambda)
                         initialize <- function(formula, data,lambda ){
                          #,normalise = TRUE) error in initilize function

                           #1- check validation
                          # ifelse(!is.data.frame(data),stop("the input data is not valid"),
                           #       ifelse(!class(formula) != "formula"), stop("formula is not valid"),
                            #      ifelse(!all(sapply(data[,conames(data)%in% all.vars(formula)],is.numeric)), stop("not numeric data"),
                            #             ifelse(!length(lambda)==1, stop("lambda not valid")," ")))

                           data <<-data
                           formula <<-formula
                           lambda <<-lambda
                         },
                         #--------------------------------------------------------------------------------------
                         #2- calculate values
                         #The goal here is to establish a mathematical equation for a ridge regression model
                         calculateValues <- function()
                         {
                           result <- list()
                           x <<- model.matrix(formula, data)
                           y<-data[,colnames(data)==all.vars(formula)[1]]
                           #NROMLAIZED
                           x[,2:ncol(x)] <- scale(x[,-1])
                           # is speeed in cars data
                           #betaHat <<- coef(lm(y ~ x))
                           # Regression Coefficients
                           result$coef <- solve(t(x) %*% x+ diag(lambda, nrow = ncol(x))) %*% (t(x) %*% y)
                           # yHat = X*bHat  === yhat = beta0 + beta1*x
                           #fittedValues <<- x%*%betaHat
                           result$fittedValues <- x%*%result$coef
                           return(result)
                         }#,
                         #--------------------------------------------------------------------------------------
                         #print=function()
                         #{
                          # "print out the coefficients and coefficient names, similar as done by the lm class."

                         #},
                         #--------------------------------------------------------------------------------------
                         #predict = function()
                         #{
                          # "return the predicted values ^y, it should be able to predict for new dataset similar"

                         #},
                         #--------------------------------------------------------------------------------------
                        # coef = function()
                         #{#^ ridge =( XTX + I)1

                          # "return the ridge regression coefficients ^ ridge"

                         #}
                       ))


#lambda <- 1
#data <- iris[,1:4]
#formula <- Sepal.Length ~ Sepal.Width + Petal.Length
#x<-model.matrix(formula, data)
#head(x)
#formula <- Sepal.Length ~ Sepal.Width + Petal.Length
#X<-model.matrix(formula, data)
#x[,2:ncol(x)] <- scale(x[,-1]) #Normalizing
#head(X)
#calculateValues()
#traceback()
#epal.Length
#(Intercept)       3322182
#Sepal.Width      10061570
#Petal.Length     13971232

#lm.ridge(formula, data)
