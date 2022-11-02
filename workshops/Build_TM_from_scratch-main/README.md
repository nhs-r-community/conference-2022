# NHS R Community - Build a TidyModels Classification Model from Scratch

<a href="https://hutsons-hacks.info/"><img src = "man/fig/TidyModels.gif"></a>

 <!-- badges: start -->
  [![TidyModelsTutorial: Active](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<!-- badges: end -->

## Contents

In this workshop you will learn how to:

- Load in data from the [MLDataR](https://cran.r-project.org/web/packages/MLDataR/vignettes/MLDataR.html) library
- Explaratory data analysis
- Create a [recipe](https://recipes.tidymodels.org/) for model training 
- Build a [Parsnip](https://www.tidyverse.org/blog/2018/11/parsnip-0-0-1/) baseline regression model and then compare to a cutting edge algorithm (XGBoost)
- Hyperparameter tune with [dials](https://dials.tidymodels.org/) and fit seperate models
- Evaluate your model with [ConfusionTableR](https://cran.r-project.org/web/packages/ConfusionTableR/vignettes/ConfusionTableR.html)
- Visualise and save your model results
- Serialise model
- Build inference script to pass production data through model
- Deploy your model with [Vetiver](https://vetiver.rstudio.com/) (a new package for MLOps) which creates a [Plumber API](https://www.rplumber.io/) and docs for deploying to other services, such as a Dockerfile


## Additional resources

- Building a classification model from scratch and deploying with Plumber: https://youtu.be/PtD5hgHM-DY
- TidyModels webinar on building TidyModels models: https://www.youtube.com/watch?v=hxRx7ozLNKw
- Deploying Plumber web service as a Docker microservice: https://youtu.be/JK6VLAKRjO4
- Advanced Modelling with Caret in R: https://www.youtube.com/watch?v=9uLiSTc-MUs
- Introduction to Docker and R: https://github.com/StatsGary/NHS_R_Community_Intro_to_Docker
- [Assessing classification model with ConfusionTableR and outputting matrix to database](https://www.youtube.com/watch?v=9zcUlgLySZo&list=PL37zlCA8GQdo-mObS7U6ViJduy9CyC5aI&index=15&t=322s) - this will show you how to use the Confusion Matrix object of R and then beable to store the results into a database with ConfusionTableR. 


