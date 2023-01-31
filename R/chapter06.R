#Source file Practice R: Chapter 6
#Author: Edgar Treischl
#Source file from: GitHub
#Updates: None

# 6 Analyze data################################################################

#The setup of Chapter 6
library(broom)
library(dotwhisker)
library(dplyr)
library(estimatr)
library(effectsize)
library(forcats)
library(ggeffects)
library(HistData)
library(huxtable)
library(interactions)
library(jtools)
library(lmtest)
library(tidyr)
library(palmerpenguins)
library(performance)
library(PracticeR)
library(see)

# 6.1 Linear regression analysis ###############################################

#The HistData package gives you access to the Galton data
head(Galton)


#The lm function
model <- lm(child ~ parent, data = Galton)
model

#How tall will a child be on average if the parents are 68 inches?
23.9415 + 68 * 0.6463

#Generate example data
new_data <- data.frame(parent = c(55, 68, 75))
#Apply the model with predict
predict(model, new_data)

#Calculate the slope manually
Galton |>
  summarise(mean_x = mean(parent),
         mean_y = mean(child),
         cov  = sum((parent - mean_x)*(child-mean_y)),
         variance_x = sum((parent - mean_x)^2),
         slope = cov / variance_x
         )

#The summary function gives more information about the model
summary(model)





#Get summary
sum_model <- summary(model)

#Interpret R2
effectsize::interpret_r2(sum_model$r.squared,
                         rules = "cohen1988")





# 6.2 Develop a linear regression model ########################################

#The penguins
library(palmerpenguins)

varlist <- c("body_mass_g", "species", "sex", "bill_length_mm")

penguins |>
  select(all_of(varlist))|>
  summary()

#Create a dummy
penguins_df <- penguins |>
  mutate(species_bin = if_else(species ==
                            "Adelie", "Adelie", "Others"))

#Check the data preparation steps
fct_count(penguins_df$species_bin)

#The first model
m1 <- lm(body_mass_g ~ species_bin, data = penguins_df)
summary(m1)

#Factor variables can be included
lm(body_mass_g ~ species, data = penguins)


#Relevel the reference group
penguins$species <- relevel(penguins$species, ref = 2)

#Run model again
lm(body_mass_g ~ species, data = penguins)



## #Info box: Power analysis ######################################################
#Use the pwr package to run a power analysis
pwr::pwr.r.test(r=0.5,
                power=0.8,
                n=NULL,
                sig.level=0.05,
                alternative = "two.sided")



#Control for confounding variables
m2 <- lm(body_mass_g ~ species + sex, data = penguins)
summary(m2)


#Compare models
m1 <- lm(body_mass_g ~ species, data = penguins)
m2 <- lm(body_mass_g ~ species + sex, data = penguins)

#But use huxreg to compare them!
huxtable::huxreg(m1, m2)

#jtools returns a dot-and-whisker plot
jtools::plot_summs(m1, m2)

#Interaction of two categorical variables
m3 <- lm(body_mass_g ~ species*sex, data = penguins)
#Interaction between a categorical and a numerical variable
m3a <- lm(body_mass_g ~ bill_length_mm*sex, data = penguins)

summary(m3)

library(interactions)

#Left: cat_plot for categorical predictors
cat_plot(m3, pred = species, modx = sex,
         point.shape = TRUE, vary.lty = FALSE)

#Right: Interaction plot
interact_plot(m3a, pred = bill_length_mm, modx = sex,
              interval = TRUE, plot.points = FALSE)



#Compare model performance, for example:
m1 <- lm(body_mass_g ~ species, data = penguins)
m2 <- lm(body_mass_g ~ species + sex, data = penguins)

#R2
library(performance)
r2(m1)

#Compare performance
compare_performance(m1, m2,
                    metrics = c("AIC", "BIC", "R2_adj"))

#Drop observations that will be dropped in later steps
# penguins <- penguins |>
#   tidyr::drop_na(sex)

#Rerun the model
# m1 <- lm(body_mass_g ~ species, data = penguins)


#Radar plot
library(see)
result <- compare_performance(m1, m2)
plot(result)



#Make a squared age variable
gss2016$age_sqr <- gss2016$age^2

#Transform a numerical outcome
PracticeR::transformer(gss2016$income)

#Model
model <- lm(body_mass_g ~ sex, data = penguins)

#Create a list with text labels
library(jtools)
coef_names <- c("Intercept" = "(Intercept)",
                "Male" = "sexmale")

#Create a table
export_summs(model, coefs = coef_names)



#Export the table, but learn how to make a report (and tables) with R!
# export_summs(model, scale = FALSE, coefs = coef_names,
#              error_format = "{statistic})",
#              to.file = "docx", file.name = "test.docx")


# 6.3 Visualization techniques #################################################


#Example model
model <- lm(body_mass_g ~ bill_length_mm + sex, data = penguins)

#Get a quick overview
#x <- check_model(model)
#plot(x)


#Identify outliers with Cook’s D
cookD_model <- cooks.distance(model)
cookD_model[1:3]

#Search for influential observations
check_outliers(model)

#Plot influential observations
x <- check_outliers(model)
plot(x)

#VIF values
check_collinearity(model)


#check_heteroscedasticity
x <- check_heteroscedasticity(model)
plot(x)


#Breusch & Pagan test (1979)
lmtest::bptest(model)

#check_heteroscedasticity
check_heteroscedasticity(model)

#Robust standard errors
library(estimatr)
robust_model <- lm_robust(body_mass_g ~ bill_length_mm + sex,
                          data = penguins,
                          se_type = "stata")


#Cluster robust
cluster_model <- lm_robust(flipper_length_mm ~ bill_length_mm + sex,
                           data = penguins,
                           clusters = island)


#Run a Durbin-Watson test in case of auto-correlation
#lmtest::dwtest(model)

#check_normality
#check_normality(model)

#Two example models
m1 <- lm(flipper_length_mm ~ bill_length_mm,
         data = penguins)
m2 <- lm(flipper_length_mm ~ bill_length_mm + sex,
         data = penguins)

#Left: plot_summs from jtools returns a dot-and-whisker
plot_summs(m1)

#Right: add coefficient labels
plot_summs(m1, m2, coefs = c("Bill length" = "bill_length_mm",
                           "Male" = "sexmale"))



#broom::tidy returns a tidy data of your model
broom::tidy(m1, conf.int = TRUE)

library(dotwhisker)
#Left: the dwplot
dwplot(m1)

#Right: add a reference line
dwplot(m1, vline = geom_vline(xintercept = 0,
                              color = "black"))


#Include several models as list
dwplot(list(m1, m2))

#Sort/resort models via model_order
dwplot(list(m1, m2),
       model_order = c("Model 2", "Model 1"))


#Results are displayed on the next page:
#Sort variables
dwplot(m2,
       vars_order = c("sexmale", "bill_length_mm"))

#Relabel variables
dwplot(m2) |>
  relabel_predictors(c(bill_length_mm = "Bill length",
                       sexmale = "Male penguins"))




#The final plot
dwplot(list(m1, m2),
       dot_args = list(size = 2),
       vline = geom_vline(xintercept = 0,
                          colour = "black",
                          linetype = 2),
       model_order = c("Model 1", "Model 2")) |>
  relabel_predictors(c(bill_length_mm = "Bill length",
                       sexmale = "Male penguins"))+
  ggtitle("Results")+
  theme_minimal(base_size = 12)+
  xlab("Effect on body mass") +
  ylab("Coefficient") +
  theme(plot.title = element_text(face = "bold"),
        legend.title = element_blank()) +
  scale_color_viridis_d(option = "plasma")



#E-book: Regression and other stories
#PracticeR::show_link("regression")
