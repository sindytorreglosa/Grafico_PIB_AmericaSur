# ========================================================================================== #
# Script de gr�fico: Comportamiento del PIB per c�pita, Am�rica del Sur, Periodo 2007 - 2017
# UD: "Procesamiento y visualizaci�n de datos espaciales en R"
# Fecha de modificaci�n: 3 de diciembre de 2019
# Autora: Sindy Torreglosa Hern�ndez
# ========================================================================================== #

# Llamar librer�as

library(tidyverse)
library(readr)
library(ggplot2)
library(gganimate)


# Este gr�fico se realizar� con la malla mismanaged_vs_gdp. 

# Descargar malla mismanaged_vs_gdp

mismanaged_vs_gdp <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-05-21/per-capita-mismanaged-plastic-waste-vs-gdp-per-capita.csv")


#Antes, voy a cambiar el nombre de algunas variables, para que sea m�s f�cil su uso:
  # Total Population por PobTotal
  # GDP per capita, PPP (constant 2011 international $) (aste) se cambia por PIB 

names (mismanaged_vs_gdp)[6] = "PobTotal"
names (mismanaged_vs_gdp)

names (mismanaged_vs_gdp)[5] = "PIB"
names (mismanaged_vs_gdp)


# Voy a filtrar los registros a partir del a�o 2007 y para los paises de Am�rica del Sur.

AmericaSur <- 
  mismanaged_vs_gdp %>% 
  filter(Code %in% c("ARG", "BRA", "CHL", "COL", 
                     "ECU", "GUY", "PER", "SUR", 
                     "TTO", "URY", "VEN","BOL","PRY")) %>%
  filter(Year > 2006) %>% 
  print()



# Generar gr�fico

ggplot(AmericaSur, aes(Year, PIB, group = Entity, fill=Entity)) + 
  geom_line(aes(color = Entity)) + #Color por Pa�s
  geom_segment(aes(xend = 2018, yend = PIB), linetype = 2) + 
  scale_x_continuous(limits = c(2007, 2017), breaks = seq(2007, 2017, 1)) +
  scale_y_continuous(breaks=seq(4403, 31952, 2000)) + #Distribuci�n del eje y
  geom_point(size = 2) + 
  geom_text(aes(x = Year, label = Entity), hjust = 0) +
  transition_reveal(Year) + 
  coord_cartesian(clip = 'off') + 
  labs(title = 'Comportamiento del PIB per c�pita, Am�rica del Sur',
       subtitle = "Periodo 2007 - 2017",
       x = "A�o",
       y = "PIB per c�pita") +
  theme_get() + 
  theme(legend.position = "none") + #Omitir las leyendas
  theme(plot.margin = margin(5.5, 40, 5.5, 5.5))
anim_save("PIB_AmericaSur.gif")
