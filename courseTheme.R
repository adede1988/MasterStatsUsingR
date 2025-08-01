

####################################################################
#### theme setting #################################################
####################################################################


myText90 = element_text(size=16, 
                        color="#FFEAB1", 
                        face="bold",
                        angle=90)
myText = element_text(size=16, 
                      color="#FFEAB1", 
                      face="bold",
                      angle=0)
myTextBig = element_text(size=20, 
                         color="#84E642", 
                         face="bold",
                         angle=0,
                         hjust = .5)
# backCol = element_rect(fill = "transparent", color = NA)
backCol = element_rect(fill = "#1C1A3B", color = "#1C1A3B" )

myTheme = theme(
  panel.background = backCol, # bg of the panel
  plot.background = backCol, # bg of the plot
  panel.grid.major = element_blank(), # get rid of major grid
  panel.grid.minor = element_blank(), # get rid of minor grid
  legend.background = backCol, # get rid of legend bg
  legend.box.background = backCol, # get rid of legend panel bg
  legend.key = backCol, 
  legend.title = myText,
  legend.text = myText,
  axis.title.x = myText,
  axis.title.y = myText90,
  axis.text.y = myText,
  axis.text.x = myText,
  plot.title = myTextBig,
  axis.line = element_line(colour = "#FFEAB1", 
                           linewidth = 2, linetype = "solid"),
  axis.ticks = element_line(colour = "#FFEAB1", 
                            linewidth = 2, linetype = "solid"),
  axis.ticks.length=unit(-0.25, "cm") #determine length/direction of ticks
)

myText90 = element_text(size=16, 
                        color="#ABA269", 
                        face="bold",
                        angle=90)
myText = element_text(size=16, 
                      color="#ABA269", 
                      face="bold",
                      angle=0)
myTextBig = element_text(size=20, 
                         color="#ABA269", 
                         face="bold",
                         angle=0,
                         hjust = .5)
myThemeDark = theme(
  panel.background = element_rect(fill = "transparent"), # bg of the panel
  plot.background = element_rect(fill = "transparent", color = NA), # bg of the plot
  panel.grid.major = element_blank(), # get rid of major grid
  panel.grid.minor = element_blank(), # get rid of minor grid
  legend.background = element_rect(fill = "transparent"), # get rid of legend bg
  legend.box.background = element_rect(fill = "transparent"), # get rid of legend panel bg
  
  axis.title.x = myText,
  axis.title.y = myText90,
  axis.text.y = myText,
  axis.text.x = myText,
  plot.title = myTextBig,
  axis.line = element_line(colour = "#ABA269", 
                           size = 2, linetype = "solid"),
  axis.ticks = element_line(colour = "#ABA269", 
                            size = 2, linetype = "solid")
)

brightCol = scale_color_manual(values = c('#20CDF2', '#6EE11F', '#415d2e',
                                          '#a05824', '#d5db52', '#E24C3A', 
                                          '#9B4F96', '#F1A14C'))  
brightFil = scale_fill_manual(values = c('#20CDF2', '#6EE11F', '#415d2e',
                                         '#a05824', '#d5db52', '#E24C3A', 
                                         '#9B4F96', '#F1A14C'))
dimCol = scale_color_manual(values = rep('#ABA269',8))
dimFil = scale_fill_manual(values = rep('#ABA269',8))


rm(myText, myText90, myTextBig)
