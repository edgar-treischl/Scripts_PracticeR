#libraries for this section
#library(dplyr)
library(ggplot2)
library(ggthemes)
library(palmerpenguins)
library(showtext)



#Left plot: The ggplot function
ggplot(data = penguins)

#Second plot: The aes function
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))

#Right plot: Add layers with a + sign!
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))+
   geom_point()



## #The minimal code
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
   geom_point()

## #Provide precise labels for the axis and a title
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

#Add a theme_* to change the appearance of a graph
#left side: theme_minimal()
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("theme_minimal()")+
  theme_minimal()

## #right side: theme_gray()
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("theme_gray()")+
  theme_gray()


## # sets a different default theme, for example:
## theme_set(theme_minimal())



## #the ggthemes provides even more themes
library(ggthemes)

#left: add stata style
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_stata()

#right: add the excel style
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_excel()



## #adjust the axis.text
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme(axis.text = element_text(colour="gray",  angle=45))

#or change how the plot.title is displayed
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("Title")+
  theme(plot.title=element_text(size=16, face="bold"))




library(showtext)
#add a font type
#font_add(family = "family_name", regular = "/path/to/the/file")

#font_paths shows you where your font types live
font_paths()

#font_files returns information about the path, file, and family name of fonts
df <- font_files()
df[1:5, 1:3]

## #Add a font
font_add(family = "American Typewriter", regular = "AmericanTypewriter.ttc")
## 
## #showtext_auto render text automatically with showtext
showtext_auto()

#Include the font within the theme, as the left plot shows:
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("Font: American Typewriter")+
  theme_minimal(base_family = "American Typewriter")




#Add a font from Google: https://fonts.google.com/
font_add_google("Ramaraja")

ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_minimal(base_size = 12, base_family = "Ramaraja")+
  ggtitle("Font: Ramaraja")+
  theme(plot.title=element_text(size=14))


#Bar plot with colors
ggplot(penguins, aes(species))+
  geom_bar(fill="white", color="black")

#Scatter plot with colors
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(fill="red", color="black", shape = 21)


## #which shape shall it be?
PracticeR::show_shapetypes()


#add color aes
ggplot(penguins, aes(bill_length_mm, body_mass_g,
                     color = island))+
  geom_point()

#add shape aes
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




#colors() returns a long list with all implemented color names
colors()[1:8]

#The display.brewer.all function shows palettes from ColorBrewer
RColorBrewer::display.brewer.all()

#scale_fill_brewer
ggplot(penguins, aes(species, fill = island))+
  geom_bar() +
   scale_fill_brewer(palette="Set1")

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




#The paletteer package gives you access to several palettes
library(paletteer)
ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
  geom_point()+
  scale_color_paletteer_d("rtist::munch")


## #Left: Discard the legend
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  theme(legend.position="none")

#Right display the legend on the right, left, top, or bottom
ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
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
scatter_plot <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
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


## #Start the addin or use:
## esquisse::esquisser()


#ggsave export your work and comes with several options
ggsave(scatter_plot,
       file="output_file.png",
       width = 210, height = 148, units = "mm", dpi = 300)
