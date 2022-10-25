#Libraries for section 7.1 #####
library(ggplot2)
library(ggthemes)
library(palmerpenguins)
library(PracticeR)
library(RColorBrewer)
library(showtext)

## # 7.1 The basics of ggplot2 ####################################################

#Left plot: The ggplot function
ggplot(data = penguins)

#Center: The aes function
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))

#Right plot: Add layers with a + sign!
ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))+
   geom_point()

#The minimal code
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
   geom_point()

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

#Set a different default theme, for example:
#theme_set(theme_minimal())



#The ggthemes provides even more themes
#library(ggthemes)

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

#font_files returns the path, file, and family name of fonts
df <- font_files()
df[1:5, 1:3]

#library(showtext)
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
#font_add_google("Pacifico")

# ggplot(penguins, aes(bill_length_mm, body_mass_g))+
#   geom_point()+
#   theme_minimal(base_size = 12, base_family = "Pacifico")+
#   ggtitle("Font: Pacifico")+
#   theme(plot.title=element_text(size=14))


#colors() returns implemented colors
colors()[1:8]

#Bar plot with colors
ggplot(penguins, aes(species))+
  geom_bar(fill="white", color="black")

#Scatter plot with colors
ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(fill="red", color="black", shape = 21)





#Which shape shall it be?
PracticeR::show_shapetypes()

#Line types
#show_linetypes()

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



#FEHLER##########
#TAYLOR############ the paletteer package includes now the
#tayloRswift instead of the taylor package
#The paletteer package gives you access to several palettes

library(paletteer)
ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
  geom_point()+
  scale_color_paletteer_d("rtist::munch")


ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
    geom_point() +
    scale_color_paletteer_d("tayloRswift::lover")+
    ggtitle("tayloRswift::lover")


#paletteer_d returns discreet color palette
paletteer::paletteer_d("tayloRswift::lover")



#Left: Discard the legend
ggplot(penguins, aes(bill_length_mm,
                     body_mass_g,
                     color = island))+
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


## #Start the addin or use:
#esquisse::esquisser()

#The ggsave export a plot
# ggsave(scatter_plot,
#        file="output_file.png",
#        width = 210,
#        height = 148,
#        units = "mm",
#        dpi = 300)


