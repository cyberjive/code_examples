#########################
# Playing with Vectors
#########################


mymat <- matrix(nrow=30, ncol=30) # create a 30 x 30 matrix (of 30 rows and 30 columns)

for(i in 1:dim(mymat)[1])  # for each row
{
  for(j in 1:dim(mymat)[2]) # for each column
  {
    mymat[i,j] = i*j     # assign values based on position: product of two indexes
  }
}
glimpse(mymat)
mymat[1:10, 1:10]
mymat[1:15, 1:15]
i
j
str(i)
mymat2 <- matrix(c(2, 5, 9, 12, 7, 11),
                 nrow = 2,
                 ncol = 3,
                 byrow = T)# 2 x 3 matrix
theta <- c(7, -2, 5)
theta * mymat2
mat.a <- matrix(c(4, 3, 3, 2),
                nrow = 2,
                ncol = 2,
                byrow = T)
mat.b <- matrix(c(-2, 3, 3, -4),
                nrow = 2,
                ncol = 2,
                byrow = T)
mat.c <- mat.a %*% mat.b
mat.a
mat.b
mat.a * mat.b #element-wise multiplication
mat.a %*% mat.b #matrix multiplication
t(mat.a) #mat.b
solve(mat.a) #find inverse where m is a square matrix
getwd()
setwd("c:/users/james.putterman/documents/R")
t(mat.a)
mat.c
mymat2 %*% theta
mymat2
theta
counter <- icount(10)
for(n in c(2,5,10,20,50)) {
  x <- stats::rnorm(n)
  cat(n, ": ", sum(x^2), "\n", sep = "")
}
n
x
n %*% x
require(graphics)
mosaicplot(Titanic, main = "Survival on the Titanic")
## Higher survival rates in children?
apply(Titanic, c(3, 4), sum)
## Higher survival rates in females?
apply(Titanic, c(2, 4), sum)
## Use loglm() in package 'MASS' for further analysis ...
islands
head(islands)
tail(islands)
str(islands)
glimpse(islands)
islands.df$name <- rownames(islands.df)
glimpse(islands.df)
View(islands.df)
t(X)
diag(10,5)
diag(5)
diag(0, 5)
m <- diag(5)
t(m)
m
solve(m)
t(m)
X
solve(mat.a)
mat.a
t(mat.a)
