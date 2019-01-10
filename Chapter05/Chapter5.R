library(rpart)
library(rpart.plot)
library(caret)
library(e1071)
library(arules)

data("AdultUCI");
AdultUCI

## 75% of the sample size
sample_size <- floor(0.80 * nrow(AdultUCI))
## set the seed to make your partition reproductible
set.seed(123)
## Set a variable to have the sample size 
training.indicator <- sample(seq_len(nrow(AdultUCI)), size = sample_size)
# Set up the training and test sets of data
adult.training <- AdultUCI[training.indicator, ]
adult.test <- AdultUCI[-training.indicator, ]
## set up the most important features
features <- AdultUCI$income ~ AdultUCI$age+AdultUCI$education+AdultUCI$"education-num"
# Let's use the training data to test the model
model<-rpart(features,data=adult.training)
# Now, let's use the test data to predict the model's efficiency
pred<-predict(model, adult.test ,type="class")
# Let's print the model
print(model)
# Results
#1) root 32561 7841 small (0.7591904 0.2408096)
#2) AdultUCI$"education-num"< 12.5 24494 3932 small (0.8394709 0.1605291)
*
  # 3) AdultUCI$"education-num">=12.5 8067 3909 small (0.5154332 0.4845668)
#6) AdultUCI$age< 29.5 1617 232 small (0.8565244 0.1434756) *
# 7) AdultUCI$age>=29.5 6450 2773 large (0.4299225 0.5700775) *
printcp(model)
plotcp(model)
summary(model)
print(pred)
summary(pred)
# plot tree
plot(model, uniform=TRUE,
     main="Decision Tree for Adult data")
text(model, use.n=TRUE, all=TRUE, cex=.8)
prp(model, faclen = 0, cex = 0.5, extra = 1)