knitr::opts_chunk$set(echo = TRUE)
#library(GGally)
#library(ggplot2)
library(tidyverse)
library(patchwork)
library(cowplot)
#library(viridis)
library(dotwhisker)
library(huxtable)
options(huxtable.knit_print_df = FALSE)




#the HistData package gives you access to the Galton data
library(HistData)
#data(Galton)
head(Galton)

## #plot(x, y),
## p1 <- ggplot(Galton, aes(parent, child))+
##   geom_point()+
##   #labs(subtitle = "A")+
##   theme_minimal(base_size = 12)
## 
## p2 <- ggplot(Galton, aes(parent, child))+
##   geom_point()+
##   geom_abline(aes(intercept=20, slope = .75), color = "red", size = 1.1) +
##   #labs(subtitle = "B")+
##   theme_minimal(base_size = 12)
## 
## p3 <- ggplot(Galton, aes(parent, child))+
##     geom_point()+
##     geom_smooth(method=lm, se=TRUE, color = "red")+
##   #labs(subtitle = "C")+
##   theme_minimal(base_size = 12)
## 
## 
## plot_grid(p1, p2, p3, ncol = 3, labels = c("A", "B", "C"))
## 


#use the lm function to run a linear model
model <- lm(child ~ parent, data = Galton)
model

#How large will a child be on average if parents are 68 inches?
23.9415 + 68 * 0.6463 

#generate some example values
new_data <- data.frame(parent = c(55, 68, 75)) 
#apply the model with predict
predict(model, new_data) 

Galton %>%
  summarise(mean_x = mean(parent),
         mean_y = mean(child),
         cov  = sum((parent - mean_x)*(child-mean_y)),
         var_x = sum((parent - mean_x)^2),
         slope = cov / var_x 
         )

#use the summary function to get more information about your model
model <- lm(child ~ parent, data = Galton)
summary(model)



#Interpret R2
library(effectsize)

#assign summary results
sum_model <- summary(model)

#interpret_r2 helps to interpret R2
effectsize::interpret_r2(sum_model$r.squared, rules = "cohen1988")

library(tidyverse)
library(socviz)
#use levels() to inspect all levels
#forcats::fct_count() to count levels
fct_count(gss_sm$income16) %>% 
  head()

gss_sm$income <- as.numeric(gss_sm$income16)
fct_count(gss_sm$happy)

gss_sm %>% 
  mutate(happy2 = if_else(happy == 
                            "Not Too Happy", "Not happy", "Happy")) %>%
  select(happy, happy2) %>%
  head()


gss_sm$happy2 <- if_else(gss_sm$happy == "Not Too Happy", 
                         "Not happy", "Happy")

fct_count(gss_sm$happy2)

m1 <- lm(income ~ happy2, data = gss_sm)
summary(m1)

lm(income ~ happy, data = gss_sm) 

#%>% parameters()
#relevel the reference group
gss_sm$happy <- relevel(gss_sm$happy, ref = 3)  
lm(income ~ happy, data = gss_sm) 

fct_count(gss_sm$marital)

gss_sm$married <- fct_lump(gss_sm$marital, n = 2) 
fct_count(gss_sm$married)


#Control for confounding variables
m2 <- lm(income ~ happy2 + married + sex, data = gss_sm)
summary(m2) 




#huxreg helps to compare models!
library(huxtable)
huxreg(m1, m2)

#left: plot_summs from jtools returns a dot-and-whisker
library(jtools)
plot_summs(m1, m2)


#Interaction effects with two categorical variables
m3 <- lm(income ~ happy2*sex, data = gss_sm)
#Interaction effects with two categorical variables
m3a <- lm(income ~ happy2*age, data = gss_sm)

library(interactions)
cat_plot(m3, pred = happy2, modx = sex,
         point.shape = TRUE,
         vary.lty = FALSE)

interact_plot(m3a, pred = age, modx = happy2,
             interval = TRUE, plot.points = FALSE)

library(interactions)


gss_sm$age_sqr <- gss_sm$age^2

m5 <- lm(income ~ happy2 + age + age_sqr, data = gss_sm)


library(PracticeR)
transformer(gss_sm$income)

library(performance)
r2(m1)

compare_performance(m1, m2, m3, m3a,
                    metrics = c("R2_adj", "AIC", "BIC"))

# library(tidyr)
# 
# m1_new <- gss_sm %>%
#   drop_na(age) %>%
#   lm(income ~ happy2, data = .)

#Performance radar plot
library(see)
result <- compare_performance(m1, m2, m3)
plot(result)

#broom::glance returns performance indicators as a tidy data frame
broom::glance(m1)[1:12]


# #Example model
library(palmerpenguins)
model <- lm(body_mass_g ~ bill_length_mm + sex, data = penguins)
 
#diagnostics plot
plot(model)



cookD_m2 <- cooks.distance(model)
head(cookD_m2)

library(performance)
#check_outliers seares for influential observations
#check_outliers(modelname, method = "cook")
check_outliers(model)

x <- check_outliers(model)
plot(x)

resid(model)[1:5]
rstandard(model)[1:5]

# library(ggeffects)
# predict_model <- ggpredict(model, terms = "bill_length_mm")
# plot(predict_model,
#      residuals = TRUE,
#      residuals.line = TRUE)



#check_heteroscedasticity retuns the Breusch-Pagan test (1979) 
lmtest::bptest(model)
check_heteroscedasticity(model)

#Robust standard errors
library(estimatr)
lm_robust(body_mass_g ~ bill_length_mm + sex, 
          data = penguins,
          se_type = "HC1") 

x <- check_normality(model)
plot(x)

library(estimatr)
lm_robust(body_mass_g ~ bill_length_mm + sex, 
          data = penguins,
          clusters = island) 

## #Durbin-Watson test
## lmtest::dwtest(model)

check_collinearity(model)



m1 <- lm(body_mass_g ~ bill_length_mm, data = palmerpenguins::penguins)
m2 <- lm(body_mass_g ~ bill_length_mm + sex, data = palmerpenguins::penguins)


library(jtools)
plot_summs(m1)


plot_summs(m1, m2,
                 coefs = c("Bill length" = "bill_length_mm",
                           "Male" = "sexmale"))



#broom::tidy returns a tidy data of your model
broom::tidy(m1, conf.int = TRUE)


library(dotwhisker)
library(patchwork)
#the dot-and-whisher plot
dwplot(m1)

#add a reference line
dwplot(m1, 
             vline = geom_vline(xintercept = 0,
                            colour = "black", 
                            linetype = 2))


#PracticeR::show_plot("linetypes")



dwplot(list(m1, m2))+
  theme_gray(base_size = 10)


dwplot(list(m1, m2),
             model_order = c("Model 2", "Model 1")) +
  theme_gray(base_size = 10)




dwplot(m2,
       vars_order = c("sexmale", "bill_length_mm"))

dwplot(m2) %>%
  relabel_predictors(c(bill_length_mm = "Bill length", 
                       sexmale = "Male penguins"))



plot <- dwplot(list(m1, m2),
       dot_args = list(size = 2),
       vline = geom_vline(xintercept = 0, 
                          colour = "black", 
                          linetype = 2),
       model_order = c("Model 1", "Model 2")) %>%
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

#Which class is the last plot?
class(plot)



library(jtools)
#create a list with text labels
coef_names <- c("Intercept" = "(Intercept)",
                "Bill length" = "bill_length_mm",
                "Males" = "sexmale")

#create a table
export_summs(m1, m2, coefs = coef_names)

#export_summs can also be used to export your table
# export_summs(m1, m2, scale = FALSE, coefs = coef_names,
#              error_format = "{statistic})",
#              to.file = "docx", file.name = "test.docx")



