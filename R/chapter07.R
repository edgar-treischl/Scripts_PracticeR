
#library(knitr)


library(patchwork)

#Libraries for section 7.1 #####
library(ggplot2)
library(ggthemes)
library(palmerpenguins)
library(showtext)

## # 7.1 The basics of ggplot2 ####################################################

## library(showtext)
## font_add_google("Ramaraja")
## showtext_auto()
##
## p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g,
##                        color = island))+
##   geom_point()+
##   labs(tag = "A")
##
## p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g,
##                        color = island))+
##   geom_point()+
##   theme_minimal(base_size = 12, base_family = "Ramaraja")+
##   labs(tag = "B",
##        title="Palmer penguins",
##        subtitle = "Is bill length and body mass associated?",
##        x ="Bill length",
##        y = "Body mass",
##        caption = "Data source: \nThe palmerpenguins package",
##        color = "The Islands:")+
##   theme(plot.title=element_text(size=14))+
##   scale_color_viridis_d(option = "viridis")
##
## p1 + p2

knitr::include_graphics('images/Fig_073.pdf')

## #Left plot: The ggplot function
## ggplot(data = penguins)
##
## #Center: The aes function
## ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))
##
## #Right plot: Add layers with a + sign!
## ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))+
##    geom_point()

p1 <- ggplot(data = penguins) + theme_bw()

p2 <- ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))

p3 <- ggplot(data = penguins, aes(x = bill_length_mm, y = body_mass_g))+
   geom_point()

p1 + p2 + p3

## #The minimal code
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##    geom_point()

## #Provide precise labels for the axis and a title
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   xlab("Bill length")+
##   ylab("Body mass")+
##   ggtitle("Palmer penguins")

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

## plot_themes()

knitr::include_graphics('images/Fig_076.pdf')

## #The ggthemes provides even more themes
## library(ggthemes)
##
## #Left: Stata style
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   theme_stata()
##
## #Right: Excel "style"
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   theme_excel()
##

p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_stata()

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme_excel()

p1 + p2

## #Adjust the axis.text
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   theme(axis.text = element_text(colour="gray",  angle=45))
##
## #Or change how the plot.title is displayed
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   ggtitle("Title")+
##   theme(plot.title=element_text(size=16, face="bold"))
##

p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  theme(axis.text = element_text(colour="gray",  angle=45))

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point()+
  ggtitle("Title")+
  theme(plot.title=element_text(size=16, face="bold"))


p1 + p2

## #font_paths shows you where your font types live
## font_paths()

#font_files returns the path, file, and family name of fonts
df <- font_files()
df[1:5, 1:3]

## library(showtext)
## #Add a font
## font_add(family = "American Typewriter",
##          regular = "AmericanTypewriter.ttc")
##
## #showtext_auto render text automatically with showtext
## showtext_auto()
##
## #Include the font within the theme, as the left plot shows:
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   ggtitle("Font: American Typewriter")+
##   theme_minimal(base_family = "American Typewriter")
##

## library(showtext)
## #font_add(family = "Garamond", regular = "GARA.TTF")
## font_add(family = "American Typewriter", regular = "AmericanTypewriter.ttc")
##
## #showtext_auto render text automatically with showtext
## showtext_auto()
##
## p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   ggtitle("Font: American Typewriter")+
##   theme_minimal(base_family = "American Typewriter")
##
## font_add_google("Pacifico")
##
## p2 <-ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   theme_minimal(base_size = 12, base_family = "Pacifico")+
##   ggtitle("Font: Pacifico")+
##   theme(plot.title=element_text(size=14))
##
## p1 + p2

knitr::include_graphics('images/Fig_079.pdf')

## #Add a font from Google: https://fonts.google.com/
## #For example: Pacifico
## font_add_google("Pacifico")
##
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point()+
##   theme_minimal(base_size = 12, base_family = "Pacifico")+
##   ggtitle("Font: Pacifico")+
##   theme(plot.title=element_text(size=14))
##

#colors() returns implemented colors
colors()[1:8]

## #Bar plot with colors
## ggplot(penguins, aes(species))+
##   geom_bar(fill="white", color="black")
##
## #Scatter plot with colors
## ggplot(penguins, aes(bill_length_mm, body_mass_g))+
##   geom_point(fill="red", color="black", shape = 21)
##
##

p1 <- ggplot(penguins, aes(species))+
  geom_bar(fill="white", color="black")

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g))+
  geom_point(fill="red", color="black", shape = 21)

p1 + p2

## #Which shape shall it be?
## PracticeR::show_shapetypes()

knitr::include_graphics('images/Fig_0711.pdf')

## #Line types
## show_linetypes()

## #Add color aesthetic
## ggplot(penguins, aes(bill_length_mm, body_mass_g,
##                      color = island))+
##   geom_point()
##
## #Add shape aesthetic
## ggplot(penguins, aes(bill_length_mm, body_mass_g,
##                      color = island ,
##                      shape = island))+
##   geom_point()
##

p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island , shape = island))+
  geom_point()

p1 + p2

## #scale_fill_manual
## ggplot(penguins, aes(species, fill = island))+
##   geom_bar(position = "stack")+
##   scale_fill_manual(values = c("red", "blue", "lightblue"))
##
## #Create a color palette with color names or hexadecimal code
## my_palette <- c("#e63946", "#457b9d", "#a8dadc")
##
## #scale_color_manual
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
##   geom_point()+
##   scale_color_manual(values = my_palette)
##

p1 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar(position = "stack")+
  scale_fill_manual(values = c("red", "blue", "lightblue"))

my_palette <- c("#e63946", "#457b9d", "#a8dadc")

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_manual(values = my_palette)

p1 + p2

## RColorBrewer::display.brewer.all(type="seq")

## #The display.brewer.all function shows palettes from ColorBrewer
## RColorBrewer::display.brewer.all()

knitr::include_graphics('images/Fig_0714.pdf')

## #scale_fill_brewer
## ggplot(penguins, aes(species, fill = island))+
##   geom_bar() +
##   scale_fill_brewer(palette="Set1")+
##   coord_flip()
##
## #scale_color_brewer
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
##   geom_point()+
##   scale_color_brewer(palette="Set2")
##

#scale_fill_brewer
p1 <- ggplot(penguins, aes(species, fill = island))+
  geom_bar() +
   scale_fill_brewer(palette="Set1")+
   coord_flip()

#scale_color_brewer
p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_brewer(palette="Set2")

p1 + p2

## #scale_color_viridis_d
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
##   geom_point()+
##   scale_color_viridis_d(option = "viridis")
##
## #scale_color_viridis_c
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = bill_length_mm))+
##   geom_point()+
##    scale_color_viridis_c(option = "mako")
##

p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_viridis_d(option = "viridis")

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = bill_length_mm))+
  geom_point()+
   scale_color_viridis_c(option = "mako")

p1 + p2

## #The paletteer package gives you access to several palettes
## library(paletteer)
## ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
##   geom_point()+
##   scale_color_paletteer_d("rtist::munch")

## #For the plots
## library(paletteer)
## p1 <- ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
##   geom_point()+
##   scale_color_paletteer_d("rtist::munch")+
##   ggtitle("rtist::munch")
##
## p2 <- ggplot(penguins, aes(body_mass_g, flipper_length_mm, color = island))+
##   geom_point()+
##   scale_color_paletteer_d("taylor::lover")+
##   ggtitle("taylor::lover")
##
##
## p1 + p2

## #paletteer_d returns discreet color palette
## paletteer::paletteer_d("taylor::lover")

## #Left: Discard the legend
## ggplot(penguins, aes(bill_length_mm,
##                      body_mass_g,
##                      color = island))+
##   geom_point()+
##   theme(legend.position="none")
##
## #Right display the legend on the right, left, top, or bottom
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
##   geom_point()+
##   theme(legend.position="bottom")

p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  theme(legend.position="none")

p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  theme(legend.position="bottom")

p1 + p2

## #Adjust the legend title and labels
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
##   geom_point()+
##   scale_color_discrete(
##     name = "The Island:",
##     labels = c("A", "B", "C"))
##
## #Remove the legend title
## ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
##   geom_point()+
##   theme(legend.title = element_blank())
##

p1 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  scale_color_discrete(
    name = "The Island:",
    labels = c("A", "B", "C"))


p2 <- ggplot(penguins, aes(bill_length_mm, body_mass_g, color = island))+
  geom_point()+
  theme(legend.title = element_blank())

p1 + p2

## #the penguins scatter plot
## scatter_plot <- ggplot(penguins, aes(bill_length_mm,
##                                      body_mass_g,
##                                      color = island))+
##   geom_point()+
##   theme_minimal(base_size = 12, base_family = "Ramaraja")+
##   labs(tag = "Fig. X",
##        title="Palmer penguins",
##        subtitle = "Is bill length and body mass associated?",
##        x ="Bill length",
##        y = "Body mass",
##        caption = "Data source: \nThe palmerpenguins package",
##        color = "The Islands:")+
##   theme(plot.title=element_text(size=14))+
##   scale_color_viridis_d(option = "viridis")
##

## #Start the addin or use:
## esquisse::esquisser()

knitr::include_graphics('images/export.png')

## #The ggsave export a plot
## ggsave(scatter_plot,
##        file="output_file.png",
##        width = 210,
##        height = 148,
##        units = "mm",
##        dpi = 300)

Sys.time()
