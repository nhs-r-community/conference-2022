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

# Understanding the data using descriptive statistics -------------
## measures of central tendency -----
#caclulating the mean
 #caclulating the median

 #calculating trimmed mean, removing top and bottom 5%

 #calculating mean
#finding mode
#finding how frequent mode appears

## measures of variability ----
### Min, max and range ----
 #range, min and max 

 #max to min ratio


### Quantiles and quartiles -----
 #identify 50% quantile = median

 #quartiles
#interquartile range
### Absolute deviations -----
 #mean absolute deviation
#mean absolute deviation manually

#median absolute deviation
#median absolute deviation manually

### Variance and metrics derived from it ----
#variance manually (variance of a sample)
 # variance using function (variance of a population)

#standard deviation

 

#coefficient of variation



### Which variability metrics to use? ----
stranded_dataset <- NHSRdatasets::stranded_data

 #range might not be helpful for dummy variables 

 #same with max to min

 #IQRs

#var, sd and coefficient of variation



## full summary statistics ----

 #summary by group



## Statistical process control
library(NHSRplotthedots)
ae_attendances <- NHSRdatasets::ae_attendances 


