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
LOS <- df$LOS
Age <- df$Age


# plotting Distributions ---- 
## histogram ----
hist(LOS) #default histogram of frequency

hist(LOS, freq=FALSE) #default density histogram

hist(LOS,
     main="Distribution of Length of Stay across providers",
     xlab="Length of stay",
     xlim=c(0,20),
     col="blue",
     freq=FALSE
) #adding title, better x asix, adjusting bins, base R way


ggplot(LOS_model, aes(x=LOS)) +
  geom_histogram(binwidth=1,fill="blue", colour="white") + 
  labs(title = "Distribution of Length of Stay across providers")# ggplot way

## density line ---- 
ggplot(LOS_model, aes(x=LOS)) + geom_density()

ggplot(LOS_model, aes(x=LOS)) + 
  geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                 binwidth=1,
                 colour="white",
                 fill="blue") +
  geom_density(alpha=.2, fill="#FF6666") #overlay with histogram

## boxplots ----
boxplot(LOS ~ Death, data=LOS_dataset, 
        main="Length of stay by death status") #base boxplot

ggplot(LOS_dataset, aes(x=as.factor(Death), y=LOS)) +
  geom_boxplot() +
  labs(title = "Length of stay by death status",
       xlab="Death Status")

## violin plots ----
ggplot(LOS_dataset, aes(x=as.factor(Death), y=LOS)) +
  geom_violin(trim=FALSE) + #trim is true by default 
  labs(title = "Length of stay by death status",
       xlab="Death Status") #basic violin


ggplot(LOS_dataset, aes(x=as.factor(Death), y=LOS)) +
  geom_violin(trim=FALSE) + #trim is true by default 
  labs(title = "Length of stay by death status",
       xlab="Death Status") +
  stat_summary(fun=median, geom="point", size=2, color="blue") #adding summary statistics

ggplot(LOS_dataset, aes(x=as.factor(Death), y=LOS)) +
  geom_violin(trim=FALSE) + #trim is true by default 
  geom_boxplot(width=0.1) +
  labs(title = "Length of stay by death status",
       xlab="Death Status")  #violin and boxplot
