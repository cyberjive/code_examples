####################################
# Submission to Driven Data
# Blood Drive Competition
# Not intended for production use
# TODO: clean up, see if feature engineering
# or different algo can reduce the loss
####################################

#set seed for reproducibility
set.seed(7)

#load libraries
require(caret)
require(dplyr)
require(ggplot2)
require(readr)
require(tidyr)
require(Amelia)

#set working directory
setwd("C:/Users/james.putterman/Downloads")
#read training .csv into dataframe
df.blood_donations <- read.csv("9db113a1-cdbe-4b1c-98c2-11590f124dd8.csv")

#check for any missing values
missmap(df.blood_donations, main = "Missing values vs Observerd")#none missing because beginner competition

#remove the Total.Volume.Donated column as all visits donate 250cc
df.bd <- select(df.blood_donations, X
                , Months.since.Last.Donation
                , Number.of.Donations
                , Months.since.First.Donation
                , Made.Donation.in.March.2007)

#check to make sure outcome variable is a factor (0/1 classification)
is.factor(df.bd$Made.Donation.in.March.2007)

#change Made.Donation.in.March.2007 to factor for classification
df.bd$Made.Donation.in.March.2007 <- as.factor(df.blood_donations$Made.Donation.in.March.2007)

#create the logistic regression model/native R method
logr_bd <- glm(Made.Donation.in.March.2007 ~ Months.since.First.Donation +
                 Months.since.Last.Donation + Number.of.Donations, data = df.bd, family = "binomial")

#check the model 
logr_bd
summary(logr_bd)


#plot the data
ggplot(df.bd, aes(x = Number.of.Donations, y=Made.Donation.in.March.2007)) +
  geom_point() +
  stat_smooth(method = 'glm', method.args = list(family = "binomial"), se=F)

#secondary plotting method
#plot(df.bd$Number.of.Donations, df.bd$Made.Donation.in.March.2007)
#curve(predict(logr_bd, data.frame(x=), type='response'), add=T)


#analyze model
anova(logr_bd, test = "Chisq")
confint(logr_bd) # 95% CI for the coefficients
exp(coef(logr_bd)) # exponentiated coefficients
exp(confint(logr_bd)) # 95% CI for exponentiated coefficients
predict(logr_bd, type="response") # predicted values
residuals(logr_bd, type="deviance")

#plot the model
plot(logr_bd)

#read test data into data frame
test.data <- read.csv("5c9fa979-5a84-45d6-93b9-543d1a0efc41.csv")

#run a prediction using the glm model and the test set
logr_bd_prob <- predict(logr_bd, newdata = test.data, type = "response")
#round the prediction to 3 places
round(logr_bd_prob, 3)

#make a new dataframe with one column and populate it with the results of the prediction
newcol <- data.frame("Made Donation in March 2007" = round(logr_bd_prob, 3))
#bind the predictions to the test set
test.data <- cbind(test.data, newcol)
#check the test set
head(test.data)

#filter the dataframe to X values (ID) and predicted value
submission <- select(test.data, X, Made.Donation.in.March.2007)
#check submission format
head(submission)

#read the submisssion format .csv into a data frame
submission_format <- read.csv("BloodDonationSubmissionFormat.csv", check.names = F)
#set the column names in my submission to match those from Driven Data 
colnames(submission) <- colnames(submission_format)
#write the filtered dataframe to a .csv and submit! Hurray!
write.csv(submission, "BD_Submission_08022016.csv", row.names = F)


#method 2 using CARET package

#set seed for reproducibility
set.seed(7)

# load the dataset
data(df.bd)
# prepare training scheme
control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model
model <- train(Made.Donation.in.March.2007~Months.since.First.Donation +
                 Months.since.Last.Donation + Number.of.Donations, data=df.bd, method="glm", preProcess="scale", trControl=control)
#estimate variable importance
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
plot(importance)
#predict new values
x <- predict(model, newdata = test.data, type = "prob")
print(x)
#round the predictions to three places
x <- round(x, 3)
print(x)

#make a new dataframe with one column and populate it with the results of the prediction
caret_sub <- data.frame("Made Donation in March 2007" = x$`1`)
#bind the predictions to the test set
test.data <- cbind(test.data, caret_sub)
#check the test set
head(test.data)

#filter the dataframe to X values (ID) and predicted value
caret_submission <- select(test.data, X, Made.Donation.in.March.2007)
#check submission format
head(caret_submission)

#read the submisssion format .csv into a data frame
submission_format <- read.csv("BloodDonationSubmissionFormat.csv", check.names = F)
#set the column names in my submission to match those from Driven Data 
colnames(caret_submission) <- colnames(submission_format)
#write the filtered dataframe to a .csv and submit! Hurray!
write.csv(caret_submission, "BD_Submission_08182016_2.csv", row.names = F)
