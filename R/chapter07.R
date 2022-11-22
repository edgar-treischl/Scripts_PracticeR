# 7 Visualize research findings  #############################################





#Libraries for section 7.1
library(ggplot2)
library(ggthemes)
library(palmerpenguins)
library(PracticeR)
library(RColorBrewer)
library(showtext)

# 7.1 The basics of ggplot2 ####################################################





#Left plot: The ggplot function
ggplot(data = penguins)

#Center: The aes function
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))

#Right plot: Add layers with a + sign!
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))+
   geom_point()



## #The minimal code
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##    geom_point()

#Provide precise labels for the axis and a title
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  xlab("Bill length")+ 
  ylab("Body mass")+
  ggtitle("Palmer penguins")

#combine all texts with the labs function
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  labs(title="Palmer penguins",
       subtitle = "Is bill length and body mass associated?",
       tag = "Fig. 1",
       x ="Bill length",
       y = "Body mass",
       caption = "Data source: The palmerpenguins package")

## #Set a different default theme, for example:
## theme_set(theme_minimal())





#The ggthemes provides even more themes
library(ggthemes)

#Left: Stata style
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_stata()

#Right: Excel "style"
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_excel()
  



#Adjust the axis.text
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme(axis.text = element_text(colour="gray",  angle=45))

#Or change how the plot.title is displayed
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("Title")+
  theme(plot.title=element_text(size=16, face="bold"))




#font_paths shows you where your font types live
font_paths()
#> [1] "/Library/Fonts"                     
#> [2] "/System/Library/Fonts"             
#> [3] "/System/Library/Fonts/Supplemental"
#> [4] "/Users/edgartreischl/Library/Fonts"

#font_files returns the path, file, and family name of fonts
df <- font_files()
df[1:5, 1:3]

library(showtext)
#Add a font
font_add(family = "American Typewriter", 
         regular = "AmericanTypewriter.ttc")

#showtext_auto render text automatically with showtext
showtext_auto()

#Include the font within the theme, as the left plot shows:
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("Font: American Typewriter")+
  theme_minimal(base_family = "American Typewriter")






#Add a font from Google: https://fonts.google.com/
#For example: Pacifico
font_add_google("Pacifico")

ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_minimal(base_size = 12, base_family = "Pacifico")+
  ggtitle("Font: Pacifico")+
  theme(plot.title=element_text(size=14))


#colors() returns implemented colors
colors()[1:8]

#Bar plot with colors
ggplot(penguins, aes(species))+
  geom_bar(fill="white", color="black")

#Scatter plot with colors
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(fill="red", color="black", shape = 21)





#Which shape shall it be?
library(PracticeR)
show_shapetypes()



#Line types
show_linetypes()

#Add color aesthetic
ggplot(penguins, aes(bill_length_mm, body_mass_g, 
                     color = island))+
  geom_point()

#Add shape aesthetic
ggplot(penguins, aes(bill_length_mm, body_mass_g, 
                     color = island , 
                     shape = island))+
  geom_point()




#scale_fill_manual
ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "stack")+
  scale_fill_manual(values = c("red", "blue", "lightblue"))

#Create a color palette with color names or hexadecimal code
my_palette <- c("#e63946", "#457b9d", "#a8dadc")

#scale_color_manual
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_manual(values = my_palette)






#The display.brewer.all function shows palettes from ColorBrewer
RColorBrewer::display.brewer.all()



#scale_fill_brewer
ggplot(penguins, aes(species, fill = island))+
  geom_bar() +
  scale_fill_brewer(palette="Set1")+
  coord_flip()

#scale_color_brewer
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_brewer(palette="Set2")




#scale_color_viridis_d
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_viridis_d(option = "viridis")

#scale_color_viridis_c
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = bill_length_mm))+
  geom_point()+
   scale_color_viridis_c(option = "mako")




#Info box The paletteer package#################################################
#paletteer_d returns discreet color palette
paletteer::paletteer_d("tayloRswift::lover")

#The paletteer package gives you access to several palettes
library(paletteer)
ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
  geom_point()+
  scale_color_paletteer_d("rtist::munch")+
  ggtitle("rtist::munch")
#Info box The paletteer package#################################################




#Left: Discard the legend 
ggplot(penguins, aes(bill_length_mm, body_mass_g, 
                     color = island))+
  geom_point()+
  theme(legend.position="none") 

#Right display the legend on the right, left, top, or bottom
ggplot(penguins, aes(bill_length_mm, body_mass_g, 
                     color = island))+
  geom_point()+
  theme(legend.position="bottom") 



#Adjust the legend title and labels
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_discrete(
    name = "The Island:", 
    labels = c("A", "B", "C"))

#Remove the legend title
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  theme(legend.title = element_blank())




#the penguins scatter plot
scatter_plot <- ggplot(penguins, aes(bill_length_mm,
                                     body_mass_g, 
                                     color = island))+
  geom_point()+
  theme_minimal(base_size = 12, base_family = "Ramaraja")+
  labs(tag = "Fig. X",
       title="Palmer penguins",
       subtitle = "Is bill length and body mass associated?",
       x ="Bill length",
       y = "Body mass",
       caption = "Data source: \nThe palmerpenguins package",
       color = "The Islands:")+
  theme(plot.title=element_text(size=14))+
  scale_color_viridis_d(option = "viridis")


## #Info box The esquisse package#################################################
## #Start the addin or use:
## esquisse::esquisser()



## #The ggsave functions exports a plot
## ggsave(scatter_plot,
##        file="output_file.png",
##        width = 210,
##        height = 148,
##        units = "mm",
##        dpi = 300)

# 7.2 The applied grammar of graphics ##################################################

#The setup for section 7.2 #####
library(dplyr)
library(ggbeeswarm)
library(ggforce)
library(ggplot2)
library(palmerpenguins)
library(patchwork)
#The gapminder data
library(gapminder)
head(gapminder)

#Create a smaller data frame
gapminder_07 <- gapminder |> 
  filter (year == 2007 & continent != "Oceania") |>
  mutate(population = pop/1000000,
         gdp = gdpPercap/1000)


#Minimal code for a scatter plot
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point()

#ggplot with all optional functions
#
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION> (
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>,
#     position = <POSITION>) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION> +
#   <SCALE_FUNCTION> +
#   <THEME_FUNCTION>

#Left plot, the geom_histogram
ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_histogram()

#Right plot, the geom_density
ggplot(data=gapminder_07, aes(x=lifeExp)) +
  geom_density()










#The data transformation step ...
count_continent <- gapminder_07 |>
  count(continent)

count_continent

#And the bar graph
ggplot(data=gapminder_07, aes(x=continent)) +
  geom_bar()

## #geom_bar fills in the counting!
## ggplot(data=gapminder_07) +
##   geom_bar(aes(x=continent, y=..count..))

#Minimal example for a scatter plot with geom_smooth
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth()

#Linear fit
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method = "lm", formula = y ~ x)
  
#Add a quadratic term
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method="lm", formula = y ~ poly(x, 2))



#Map with color
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
  geom_point()+
  scale_color_manual(values=c("red", "gray", "gray", "gray"))

#Map with shapes
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, shape = continent)) +
  geom_point()+
  scale_shape_manual(values=c(0, 2, 3, 14))



#Alpha
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, color = continent)) +
  geom_point(alpha = .5)
#Map with alpha
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, alpha = continent)) +
  geom_point()
  



#Include color
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                         color = continent)) +
  geom_point()

#Include color and size
ggplot(gapminder_07, aes(x=gdp, y = lifeExp, 
                         color = continent, 
                         size = population)) +
  geom_point()




#A dot plot
ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1)

#Add position_jitter
ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_point(size = 1, position=position_jitter())


#A ggbeeswarm plot
library(ggbeeswarm)

ggplot(gapminder_07, aes(continent, lifeExp)) +
  geom_beeswarm(size = 1, cex = 3)+
  stat_summary(fun = "median", colour = "red", 
               size = 1, geom = "point")
          




library(palmerpenguins)

#Position stack is the default 
ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "stack")

#Position fill
ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "fill")





#A messy density plot - how could we improve it?
ggplot(gapminder_07, aes(x=lifeExp, color=continent)) +
  geom_density()

#facet_grid splits the graph by continent 
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  facet_grid(cols = vars(continent))

#Split by columns (on the vertical axis)
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("A: facet_grid(cols = vars(x))")+
  facet_grid(cols = vars(continent))


#Split by rows (on the horizontal)
ggplot(gapminder_07, aes(x=lifeExp)) +
  geom_density()+
  ggtitle("B: facet_grid(rows = vars(x))")+
  facet_grid(rows = vars(continent))




#Split by facet_grid(row . column)
gapminder |> 
  filter (year == 1952 | year == 2007) |> 
  filter (continent != "Oceania") |> 
  ggplot(aes(x=lifeExp)) +
  geom_density()+
  facet_grid(year ~ continent)

#Vertical facet, but wrapped
gapminder |> 
  filter (continent == "Europe") |> 
  ggplot(aes(x=lifeExp)) +
  geom_density()+
  facet_wrap(year ~ ., nrow=2)

#Info box: The patchwork package#################################################

library(patchwork)

p1 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +
  ggtitle("p1")
  

p2 <- ggplot(gapminder_07, aes(x=gdp, y=lifeExp,
                               color = continent)) +
  geom_point() +
  ggtitle("p2")+
  theme(legend.position="none")

p3 <- ggplot(data=gapminder_07, aes(x=continent)) +
  geom_bar()+
  ggtitle("p3")

#combine all three graphs
p1 + (p2 / p3) 



#Fake data for a pie chart ... 
data<-tribble(
  ~fruits,   ~Percentage,
  "Apples",   50.0,
  "Bananas",  30.0,
  "Cherries", 20.0
)


#Left, a bar plot
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)

#Right, the bull's-eye chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1) +
  coord_polar()




#Add theta = "y" to get a pie chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1, stat = "identity")+
  coord_polar(theta = "y")

#The theme_void "finalizes" the pie chart
ggplot(data, aes(x="", y=Percentage, fill=fruits))+
  geom_col(width = 1)+
  coord_polar(theta = "y")+
  theme_void()




#Left plot: Never use xlim outside of the coordinate system!
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method = "lm", formula = y ~ x)+
  xlim(c(0,10000))+
  ggtitle("xlim")

#Right plot
ggplot(gapminder_07, aes(x=gdp, y=lifeExp)) +
  geom_point() +    
  geom_smooth(method = "lm", formula = y ~ x)+
  coord_cartesian(xlim=c(0, 10000))+
  ggtitle("coord_cartesian(xlim)")




#Zoom in with ...
library(ggforce)

ggplot(gapminder_07, aes(gdpPercap, lifeExp, color=continent))+
  geom_point()+
  facet_zoom(xlim = c(0, 10000))



#For 7.3 Ggplot extensions, see:
#PracticeR::show_script("chapter07_3")

# 7.3 Extensions of ggplot2 ####################################################





#Minimal code example #####
library(ggplot2)
library(ggalluvial)
#a wide data format is needed (see Chapter 11)
titanic_wide_format <- data.frame(Titanic)

ggplot(data = titanic_wide_format,
       aes(axis1 = Class, axis2 = Sex, axis3 = Age, y = Freq)) +
  geom_alluvium(aes(fill = Survived)) +
  geom_stratum()






#Minimal code example #####
library(titanic)
library(ggbeeswarm)

ggplot(titanic_train, aes(Survived, Age, color = Sex)) + 
  geom_quasirandom(method = "quasirandom")






#Minimal code example #####
#Source: This example comes from the ggplot2 cheat sheet!
map <- map_data("state")
data <- data.frame(murder = USArrests$Murder,
                   state = tolower(rownames(USArrests)))

ggplot(data, aes(fill = murder))+
  geom_map(aes(map_id = state), map = map)+
  expand_limits(x = map$long, y = map$lat)






#Minimal code example #####
library(ggcharts)
data("popeurope")

dumbbell_chart(popeurope, 
               x = country,
               y1 = pop1952, y2 = pop2007,
               top_n = 10)





#Minimal code example #####
#There are many graphs (and code) to explore on:
#www.r-graph-gallery.com





#Minimal code example #####
library(ggmosaic)

ggplot(data = titanic) +
  geom_mosaic(aes(x = product(Sex), 
                  fill = Survived))






#Minimal code example #####
library(ggridges)

#Minimal code by Claus Wilke:
ggplot(lincoln_weather, 
       aes(x = `Mean Temperature [F]`, y = Month, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, 
                               rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "Temp. [F]", 
                       option = "C") 





#Minimal code example #####
library(treemapify)
library(gapminder)

data <- gapminder::gapminder |> 
  dplyr::filter(year == 2007 & continent == "Europe")

ggplot(data, aes(area = gdpPercap, 
                 fill = lifeExp, 
                 label = country)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", 
                    grow = TRUE)





#Minimal code example #####
library(waffle)
parts <- c(66, 22, 12)

waffle(parts, rows = 10)





## #Text Mining with R:
## PracticeR::show_link("textmining")

#Minimal code example #####
#By Erwan Le Pennec 
library(ggwordcloud)
#to recreate the plot each time the exact same way
#set a seed (starting point)
set.seed(123)

ggplot(love_words_small, aes(label = word, 
                             size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 30)

## #R Graphics Cookbook
## show_link("r_graphics")
## 
## #ggplot2: elegant graphics
## show_link("ggplot2")

## #Fundamentals of Data Visualization
## show_link("fundamentals_dataviz")
## 
## #Data Visualization
## show_link("dataviz")
