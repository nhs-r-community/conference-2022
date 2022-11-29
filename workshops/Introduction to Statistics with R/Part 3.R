install.packages("tidyverse")
install.packages("NHSRdatasets")
install.packages("lsr")
install.packages("psych")
install.packages("NHSRplotthedots")
library(tidyverse)
library(NHSRdatasets)
library(lsr)
library(psych)

LOS_dataset <- NHSRdatasets::LOS_model

# Correlation between variables ---- 
## Pearson correlation and correlation matrix ---- 
cor(LOS_dataset$Age,LOS_dataset$LOS) #Pearson correlation

cor(LOS_dataset[,-c(1,2)]) #correlation matrix

## Scatterplot ---- 
plot(LOS_dataset$Age, LOS_dataset$LOS, main="Scatterplot",
     xlab="Age ", ylab="Length of stay") #scatterplot using base R

ggplot(LOS_dataset, aes(x=Age, y=LOS)) +
  geom_point() #scatterplot using ggplot2 R

## correlogram  ----
install.packages("corrplot")
library(corrplot)
cor_matrix <- cor(LOS_dataset[,-c(1,2)])

corrplot(cor_matrix, method="circle")
corrplot(cor_matrix, method="number", type="lower")

corrplot(cor_matrix, method="color",  
         type="upper",
         addCoef.col = "black")

# Hypotheses testing ----
## testing correlation ---- 
cor.test(LOS_dataset$Age,LOS_dataset$LOS) 

## testing distribution statistically ---- 
shapiro.test(LOS) #test if distribution is normal. H0: sample distribution is normal

## comparing means ---- 
LOS_death <- LOS_dataset$LOS[LOS_dataset$Death==1]
LOS_alive <- LOS_dataset$LOS[LOS_dataset$Death==0]


t.test(LOS_death, LOS_alive) #Welch test
t.test(LOS_death, LOS_alive, conf.level = 0.99) #adjusting confidence intervalsn
t.test(LOS_death, LOS_alive, var.equal = TRUE) #assuming equal variance - Student's test

t.test(LOS ~ Death, data = LOS_dataset) #easier Welch test
