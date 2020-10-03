###########################
# Playing Around with R
# Not intended for anything
###########################

fam.list <- list(name = fam.df$name[1], age = fam.df$age[1], gender = fam.df$gender[1]
                 , works = fam.df$works[1])
fam.list
fam.list$name <- as.character(fam.list$name)
str(fam.list)
fam.list
typeof(fam.list[1])
typeof(fam.list[[1]])
str(fam.list)
typeof(fam.list[[2]])
fam.list[1:4]
fam.list[["name"]]
fam.list["name"]
typeof(fam.list["name"])
typeof(fam.list[["name"]])
fam.list$age
fam.list[c("name", "age", "gender", "works")]
length(fam.list)
str(fam.df)
fam.df$name <- as.character(fam.df$name)
str(fam.df)
fam.df[1, 4]
fam.df[c("name", "age", "gender", "works")]
mtcars[1:3, 1:4] #Row number, column number
mtcars[c(1, 4), c(1, 3)]
mtcars[c(1, 4)]
mtcars[c(T, T, T, T), ]
mtcars[mtcars$mpg < 10, ]
fam.df[c(T, T, F, T)]
mtcars[c(T, T, T, T, F, F, F, T, T, T)] #use logical operators to pull indexed values
mtcars[mtcars$hp > 180, ]
mtcars[mtcars$hp >= 180, ]
fam.df[fam.df$works == T,]
fam.df[fam.df$gender == "Female", ]
fam.df
levels(fam.df$gender)
fam.df[fam.df$name == "James", ]
str(fam.df)
fam.df[fam.df$age >= 30, ]
getwd()
setwd("C:/Users/james.putterman/Documents/Spreadsheets")
read.csv(file = "feb_captime.txt")
#feb.cap <- read.csv(file = "feb_captime_kickback_csv1", header = T, quote "\"")
getwd()
fam.df
str(fam.df)
str(test.vector)
remove(test.vector) #removes objects
glimpse(mtcars)
summary(mtcars)
str(mtcars)
head(mtcars, n = 15) #displays 15 rows as opposed to default
tail(mtcars, n = 5)
hist(mtcars$mpg, breaks = 5)
plot(mtcars$mpg, mtcars$hp)
fam.names <- as.character(c("James", "Abbye", "Kiki", "Sadie"))
fam.ages <- c(35, 30, 11, 5)
fam.gender <- c("Male", "Female", "Female", "Female")
fam.works <- c(T, F, F, F)
fam.df <- data.frame("Name" = fam.names, "Age" = fam.ages, "Gender" = fam.gender, "Works" = fam.works)
str(fam.df)
fam.df[1, ]
fam.df[fam.df$fam.gender == "Female", ]
glimpse(fam.df)
fam.df$fam.names <- as.character(fam.df$fam.names)
?data.frame
fam.df <- colnames(c("Name", "Age", "Gender", "Works"))
str(fam.df)
fam.df$Name <- as.character(fam.df$Name)
glimpse(fam.df)
x <- 0
f.add.five <- function(n)
{
  n + 5
}
f.add.five(x)
rnorm
rnorm(1,20)
f <- function(n)
{
  if (n < 10) {
    n + 1
  }

}
f(x)
f.while <- function(n)
{
  while (n < 10) {
    n +1
  }
}
f.while(x)
?Inf
is.infinite(f.while) #doesn't work on fucntions
is.infinite(x)
is.infinite(f) #doesn't work on fucntions
str(f)
str(f.while)
glimpse(f)
glimpse(fam.df)
mtcars$model <- rownames(mtcars)
glimpse(mtcars)
mtcars$model
mtcars$test <- mtcars$test
glimpse(mtcars)
mtcars
is.infinite(mtcars$mpg)
benchmark-baseball
vignette("benchmark-baseball")
vignette("benchmark")
vignette("baseball")
??vignette
x <- 10
f.add.five(x)
f(x)
x <- 5
f(x)
glimpse(Titanic)
head(Titanic)
tail(Titanic)
titanic.df <- data.frame(Titanic)
glimpse(titanic.df)
titanic.df[titanic.df$Survived == "Yes" & titanic.df$Sex == "Male", ]
titanic.df[titanic.df$Sex == "Female" & titanic.df$Age == "Child", ]
titanic.df[titanic.df$Sex == "Female" & titanic.df$Survived == "No", ]
survived <- titanic.df[titanic.df$Survived == "Yes", ]
died <- titanic.df[titanic.df$Survived == "No", ]
fam.df[fam.df$Works == T, ]
fam.df[fam.df$Gender == "Female", ]
?grepl
str(died)
str(survived)
survived$Class
survived[survived$Class == "Crew", ]
titanic.df
survived.crew <- survived[survived$Class == "Crew", ]
str(survived.crew)
survived.crew
survived.crew <- survived.crew[survived.crew$Class != "Crew" & survived.crew$Age != "Child" , ]
survived.crew
survived.crew <- survived.crew[survived.crew$Age != "Child", ]
plot(survived.crew$Sex, survived.crew$Freq)
survived.passengers <- survived[survived$Class != "Crew" , ]
survived.passengers
survived <- survived[survived$Freq != 0, ]
survived 
plot(survived$Freq, survived$Age)
hist(survived$Freq)
qqplot(survived$Freq, survived$Age)
x <- c(5, 7, 12) #1 x 3 vector
y <- c(14, -9, 1)#1 x 3 vector
x + y #matrix/n dimensional math 
x * y #product
#y <- c(2, 3, 1)
?matrix
X <- matrix(c(1, 7, 4, -1, 1, 12, 14, 2, 1, -2, 10, 3),
                   nrow = 3,
                   ncol = 4)
