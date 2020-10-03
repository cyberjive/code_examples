######################
# Plotting and Plot.ly
# playing
######################

#plotting
require(graphics)
mosaicplot(Titanic, main = "Survival on the Titanic")
## Higher survival rates in children?
apply(Titanic, c(3, 4), sum)
## Higher survival rates in females?
apply(Titanic, c(2, 4), sum)

mosaicplot(iris, main = "Petals")

mosaicplot(islands, main = "islands")


glimpse(Titanic)


require(stats)
mosaicplot(Titanic, main = "Survival on the Titanic", color = TRUE)
## Formula interface for tabulated data:
mosaicplot(~ Sex + Age + Survived, data = Titanic, color = TRUE)


mosaicplot(~ gear + carb, data = mtcars, color = TRUE, las = 1)

#plot.ly
library(plotly)
p <- plot_ly(midwest, x = percollege, color = state, type = "box")
p

m <- plot_ly(diamonds, x= carat, color = color, type="box")
m

z <- plot_ly(Titanic, x = survived, color = sex, type="box" )
z
