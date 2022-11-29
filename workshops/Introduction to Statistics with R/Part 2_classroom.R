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
 #default histogram of frequency

 #default density histogram

 #adding title, better x asix, adjusting bins, base R way


# ggplot way

## density line ---- 



 #overlay with histogram

## boxplots ----
 #base boxplot



## violin plots ----
 #basic violin


 #adding summary statistics

 #violin and boxplot
