
library(broom)
library(dotwhisker)
library(estimatr)
library(effectsize)
library(forcats)
library(ggplot2)
library(ggfortify)
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

#FEHLER: missing package?
library(dplyr)


## # 6.1 Linear regression analysis ###############################################

#The HistData package gives you access to the Galton data
head(Galton)


#use the lm function to run a linear model
model <- lm(child ~ parent, data = Galton)
model

#How tall will a child be on average if parents are 68 inches?
23.9415 + 68 * 0.6463

#generate example data
new_data <- data.frame(parent = c(55, 68, 75))
#apply the model with predict
predict(model, new_data)

#Calculation the slope manually
Galton |>
  summarise(mean_x = mean(parent),
         mean_y = mean(child),
         cov  = sum((parent - mean_x)*(child-mean_y)),
         variance_x = sum((parent - mean_x)^2),
         slope = cov / variance_x
         )

#use the summary function to get more information about your model
model <- lm(child ~ parent, data = Galton)
summary(model)


#Get summary
sum_model <- summary(model)

#interpret_r2 helps to interpret R2
effectsize::interpret_r2(sum_model$r.squared, rules = "cohen1988")


# 6.2 Develop a linear regression model ########################################

#The penguins
head(penguins)

#the independent variable
fct_count(penguins$species)

penguins <- penguins |>
  mutate(species_bin = if_else(species ==
                            "Adelie", "Adelie", "Others"))

fct_count(penguins$species_bin)

m1 <- lm(body_mass_g ~ species_bin, data = penguins)
summary(m1)


lm(body_mass_g ~ species, data = penguins)



penguins$species <- relevel(penguins$species, ref = 2)

lm(body_mass_g ~ species, data = penguins)


m2 <- lm(body_mass_g ~ species + sex, data = penguins)
summary(m2)


#The models
m1 <- lm(body_mass_g ~ species, data = penguins)
m2 <- lm(body_mass_g ~ species + sex, data = penguins)

#Huxreg helps to compare the models!
huxtable::huxreg(m1, m2)

#left: plot_summs from jtools returns a dot-and-whisker
jtools::plot_summs(m1, m2)

#Interaction effects with two categorical variables
m3 <- lm(body_mass_g ~ species*sex, data = penguins)
#Interaction effects with a categorical and a numerical variable
m3a <- lm(body_mass_g ~ bill_length_mm*sex, data = penguins)

#A summary
summary(m3)

library(interactions)
cat_plot(m3, pred = species, modx = sex,
         point.shape = TRUE, vary.lty = FALSE)

interact_plot(m3a, pred = bill_length_mm, modx = sex,
              interval = TRUE, plot.points = FALSE)

#sim_slopes(m3, pred = happy_bin, modx = sex, jnplot = TRUE)




#Example models
m1 <- lm(body_mass_g ~ species, data = penguins)
m2 <- lm(body_mass_g ~ species + sex, data = penguins)

#Performance
r2(m1)

compare_performance(m1, m2,
                    metrics = c("R2_adj", "AIC", "BIC"))

#drop observations that will be droped in later models
penguins <- penguins |>
  tidyr::drop_na(sex)

#rerun the model
m1 <- lm(body_mass_g ~ species, data = penguins)


#Performance radar plot
library(see)
result <- compare_performance(m1, m2)
plot(result)

#make a squared age variable
gssm2016$age_sqr <- gssm2016$age^2

#transform a numerical income
PracticeR::transformer(gssm2016$income)

#Model
model <- lm(body_mass_g ~ sex, data = penguins)

#create a list with text labels
coef_names <- c("Intercept" = "(Intercept)",
                "Male" = "sexmale")

#create a table
export_summs(model, coefs = coef_names)

#export_summs exports the table
# export_summs(m1, m2, scale = FALSE, coefs = coef_names,
#              error_format = "{statistic})",
#              to.file = "docx", file.name = "test.docx")


## # 6.3 Visualization techniques #################################################



#Example model
model <- lm(body_mass_g ~ bill_length_mm + sex, data = penguins)


x <- check_model(model)
plot(x)


#identify outliers with Cook’s D
#FEHLER
#Change NAME_model
cookD_m2 <- cooks.distance(model)
cookD_m2[1:5]

#check_outliers seares for influential observations
#check_outliers(modelname, method = "cook")
check_outliers(model)

x <- check_outliers(model)
plot(x)

x <- check_model(model, check = "linearity")
plot(x)

resid(model)[1:5]
rstandard(model)[1:5]

#ggeffects Example#######

library(ggeffects)
#save prediction
predict_model <- ggpredict(model, terms = "bill_length_mm")

set.seed(1234)
x <- rnorm(200)
z <- rnorm(200)
# quadratic relationship
y <- 2 * x + x^2 + 4 * z + rnorm(200)

d <- data.frame(x, y, z)
m <- lm(y ~ x + z, data = d)

pr <- ggpredict(m, "x [all]")

plot(pr, add.data = TRUE)+
  ggtitle("Scatter plot")

plot(pr, residuals = TRUE, residuals.line = TRUE)+
  ggtitle("Residual plot")



#check_heteroscedasticity
x <- check_heteroscedasticity(model)
plot(x)


#check_heteroscedasticity retuns the Breusch-Pagan test (1979)
lmtest::bptest(model)

#check_heteroscedasticity interprets it
check_heteroscedasticity(model)

#Robust standard errors with estimatr
robust_model <- lm_robust(body_mass_g ~ bill_length_mm + sex,
                          data = penguins,
                          se_type = "stata")


check_collinearity(model)

check_normality(model)

#cluster robust model
cluster_model <- lm_robust(flipper_length_mm ~ bill_length_mm + sex,
                           data = penguins,
                           clusters = island)

summary(cluster_model)

#Run a Durbin-Watson test in case of auto-correlation
lmtest::dwtest(model)

#Two example models for illustration purposes
m1 <- lm(flipper_length_mm ~ bill_length_mm,
         data = penguins)
m2 <- lm(flipper_length_mm ~ bill_length_mm + sex,
         data = penguins)

#left: plot_summs from jtools returns a dot-and-whisker
plot_summs(m1)

#right: add coefficient labels
plot_summs(m1, m2, coefs = c("Bill length" = "bill_length_mm",
                           "Male" = "sexmale"))



#broom::tidy returns a tidy data of your model
broom::tidy(m1, conf.int = TRUE)

#the dot-and-whisher plot
#library(dotwhisker)
#left: the dwplot
dwplot(m1)

#right: add a reference line
dwplot(m1,
       vline = geom_vline(xintercept = 0,
                            color = "black"))




#include several models as list
dwplot(list(m1, m2))

#sort/resort models via model_order
dwplot(list(m1, m2),
       model_order = c("Model 2", "Model 1"))



dwplot(m2,
       vars_order = c("sexmale", "bill_length_mm"))

dwplot(m2) |>
  relabel_predictors(c(bill_length_mm = "Bill length",
                       sexmale = "Male penguins"))




plot <- dwplot(list(m1, m2),
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

plot


