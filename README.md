# Bonous

[![Build Status](https://travis-ci.com/nourqweder/Bonous.svg?branch=master)](https://travis-ci.com/nourqweder/Bonous)  <!-- badges: start -->  [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/nourqweder/Bonous?branch=master&svg=true)](https://ci.appveyor.com/project/nourqweder/Bonous)
  <!-- badges: end -->


## How to use
```{r installation, eval = FALSE}
devtools::install_github("nourqweder/Bonous", build_vignettes = TRUE)
```

## Installation 

 Before start using this package, `ggplot2` package must be installed, in order to plot the result of modelling. This packages is created to make linear regression model with given data. By putting formula and data in the function, the printed result will show the linear relationship between independent variables and dependent variable, which is calculated by using least square method.
 
 

## Usage Methods


```{r echo=TRUE, fig.show='hold'}
ridgereg_mod = ridgereg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris, lambda = 0 )
```



## Data

All fields and methods are stored in reference class of R. Therefore, the data set which is to be examined must be created and stored in the reference class. New data set is assigned to a variable by using function 'classname$new(function, data)'. In the function, dependent variable must be given at first, and after putting ' ~ ', independent variable(s) should be given.


## Print

`print()` function shows the data given for the linear regression, and coefficients of the  constructed linear regression model. Since this method is stored in 'linreg' reference class, before using this method, name of the data set, which is stored in the same class as this method is, must be specified, `datasetname$print()` will use the data set stored in the reference class, and show the result of constructed 

Folloing is an example:



## pred and coef

 `pred()`, and `coef()` function will present residuals, best fitted values, and coefficients of the linear model respectively. Each function will print a vector of the corresponding numeric values. These functions, as well, requires to specify the name of the data set, that is stored in the same class as the function is, as `datasetname$functionname()` because they are also the methods defined in the reference class.
 
 Followings are examples:


### coef() 

To calculate the coefficients as a named vector.





## References 
[Advanced R](http://adv-r.had.co.nz/R5.html)
