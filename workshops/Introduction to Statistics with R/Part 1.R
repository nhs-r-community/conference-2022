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
mean(LOS) #caclulating the mean
median(LOS) #caclulating the median

mean(LOS, trim = .05) #calculating trimmed mean, removing top and bottom 5%

mean(Age) #calculating mean
modeOf(Age) #finding mode
maxFreq(Age) #finding how frequent mode appears

## measures of variability ----
### Min, max and range ----
max(LOS)
min(LOS)
range(LOS) #range, min and max 

max(LOS)/min(LOS) #max to min ratio
max(Age)/min(Age)

### Quantiles and quartiles -----
quantile(LOS, probs = .5) #identify 50% quantile = median

quantile(LOS, probs = c(.25,.75) ) #quartiles
IQR(LOS ) #interquartile range
### Absolute deviations -----
aad(LOS) #mean absolute deviation
mean(abs(LOS - mean(LOS))) #mean absolute deviation manually

mad(LOS)#median absolute deviation
median(abs(LOS - median(LOS)))#median absolute deviation manually

### Variance and metrics derived from it ----
mean((LOS - mean(LOS))^2) #variance manually (variance of a sample)
var(LOS) # variance using function (variance of a population)

#standard deviation
sqrt(mean((LOS - mean(LOS))^2))
sd(LOS) 

#coefficient of variation
sqrt(mean((LOS - mean(LOS))^2))/mean(LOS)


### Which variability metrics to use? ----
stranded_dataset <- NHSRdatasets::stranded
summary(stranded_dataset)

range(stranded_dataset$mental_health_care)

stranded_dataset %>%
  group_by(stranded.label) %>%
  summarise(max_age=max(age),
            min_age=min(age),
            max_care_home_referral=max(care.home.referral),
            min_care_home_referral=min(care.home.referral)) %>%
  mutate(max_to_min_age = max_age/min_age,
         max_to_min_care_home_referral=max_care_home_referral/ min_care_home_referral)

IQR(stranded_dataset$age)
IQR(stranded_dataset$care.home.referral)

aad(stranded_dataset$care.home.referral)
mad(stranded_dataset$care.home.referral)

var(stranded_dataset$age)
sd(stranded_dataset$age)

sd(stranded_dataset$age)/mean(stranded_dataset$age)

stranded_dataset %>%
  group_by(stranded.label) %>%
  summarise(mean_age=mean(age),
            sd_age=sd(age)) %>%
  mutate(cv_age=sd_age/mean_age)


## full summary statistics ----
summary(stranded_dataset)
by( data=stranded_dataset, INDICES=stranded_dataset$stranded.label, FUN=summary )

describeBy(stranded_dataset, group=stranded_dataset$stranded.label )

aggregate( age ~ stranded.label + frailty_index, 
           stranded_dataset,                     
           mean                             
)

## Statistical process control
library(NHSRplotthedots)
data("ae_attendances")

ae_attendances %>% 
  filter(org_code == "RRK", type == 1, period < as.Date("2018-04-01")) %>% 
  ggplot(aes(x = period, y = breaches)) +
  geom_point() +
  geom_line() +
  scale_y_continuous("4-hour target breaches") +
  scale_x_date("Date") +
  labs(title = "Example plot of A&E breaches for organsiation: 'RRK'") +
  theme_minimal()

ae_attendances %>% 
  filter(org_code == "RRK", type == 1, period < as.Date("2018-04-01")) %>% 
  ptd_spc(value_field = breaches, date_field = period, improvement_direction = "decrease")
