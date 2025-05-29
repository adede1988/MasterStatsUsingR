#Statistics with R using the Tidyverse: 
#intuition, basic coding, and applications
#plotting scratch sheet
#Adam Dede; adam.osman.dede@gmail.com 
#Fall 2021
setwd("C:/Users/Adam Dede/Google Drive/Teaching/stats/RCourse/plotting")

library(tidyverse)
#all graphs have data, aesthetic mappings, and a geometric object

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
myTheme = theme(
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
  axis.line = element_line(colour = "#FFEAB1", 
                           size = 1, linetype = "solid"),
  axis.ticks = element_line(colour = "#FFEAB1", 
                            size = 1, linetype = "solid")
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
                           size = 1, linetype = "solid"),
  axis.ticks = element_line(colour = "#ABA269", 
                            size = 1, linetype = "solid")
)

brightCol = scale_color_manual(values = rep('#20CDF2',
                                            length(unique(mpg$class))))  
brightFil = scale_fill_manual(values = rep('#20CDF2',
                                           length(unique(mpg$class))))
dimCol = scale_color_manual(values = rep('#ABA269',
                                         length(unique(mpg$class))))
dimFil = scale_fill_manual(values = rep('#ABA269',
                                        length(unique(mpg$class))))


# color = '#20CDF2'

####################################################################
#### SCATTER PLOT ##################################################
####################################################################
p <- ggplot(mpg, aes(x=displ, y = hwy, color = class))+
  geom_point(show.legend = F) +
  ylab('miles per gallon') + 
  xlab('engine size (L)') +
  ggtitle("fuel efficiency as a function \n of engine size")


p + brightCol + myTheme
ggsave(p+brightCol + myTheme, filename = "exampScat.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')
ggsave(p+dimCol + myThemeDark, filename = "exampScatDim.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')

####################################################################
#### HISTOGRAM PLOT ################################################
####################################################################

p <- ggplot(mpg, aes(hwy, color = class, fill = class))+
  geom_histogram(show.legend = F) +
  ylab('count') + 
  xlab('miles per gallon') +
  ggtitle("fuel efficiency distribution \n motor vehicles")+
  myTheme
p + brightCol +brightFil + myTheme
ggsave(p+brightCol + brightFil + myTheme, 
       filename = "exampHist.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')
ggsave(p+dimCol + dimFil + myThemeDark, 
       filename = "exampHistDim.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')

####################################################################
#### BAR PLOT       ################################################
####################################################################

mpg %>% 
  group_by(class) %>%  #,
  summarize(meanVals=mean(hwy)) -> plotVals

p <- ggplot(plotVals, aes(x=class,y = meanVals, color = class, fill = class))+
  geom_bar(show.legend = F, stat = 'identity') +
  ylab('miles per gallon') + 
  xlab('') +
  ggtitle("fuel efficiency by types of vehicle")
p + brightCol + brightFil + myTheme
ggsave(p + brightCol + brightFil + myTheme, 
       filename = "exampBar.png",  bg = "transparent",
       width = 9, height = 2.92, units = 'in')
ggsave(p + dimCol + dimFil + myThemeDark, 
       filename = "exampBarDim.png",  bg = "transparent",
       width = 9, height = 2.92, units = 'in')
  
####################################################################
#### BOX PLOT       ################################################
####################################################################

pdim <- ggplot(mpg, aes(drv, hwy))+
  geom_boxplot(show.legend = F,color = '#ABA269', fill = '#ABA269') +
  ylab('miles per gallon') + 
  xlab('drive train') +
  ggtitle("fuel efficiency by vehicle type")
pbright <- ggplot(mpg, aes(drv, hwy))+
  geom_boxplot(show.legend = F,color = '#20CDF2', fill = '#20CDF2') +
  ylab('miles per gallon') + 
  xlab('drive train') +
  ggtitle("fuel efficiency by vehicle type")
pdim + myThemeDark
ggsave(pbright+myTheme, 
       filename = "exampBox.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')
ggsave(pdim+myThemeDark, 
       filename = "exampBoxDim.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')
####################################################################
#### PIE PLOT       ################################################
####################################################################

classes = unique(mpg$class)
counts = unlist(lapply(classes, function(x) sum(mpg$class==x)))

data <- data.frame(
  group=classes,
  value=counts
)
data <- data %>% 
  arrange(desc(group)) %>%
  mutate(prop = round(value / sum(data$value) *100)) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )

p <- ggplot(data, fig_crop=FALSE,aes(x="", y=prop, fill=group)) +
  geom_bar(stat="identity", width=1, color="white") +
  scale_y_continuous(
    breaks=cumsum(data$prop) - data$prop/2,
    labels=data$group ) +
  coord_polar("y", start=0, clip = 'off') +
  theme(legend.position="none") +
  ggtitle('class of cars')

p + myTheme 

tempTheme = myTheme
tempTheme$axis.line = element_blank()
tempTheme$axis.title.x = element_blank()
tempTheme$axis.title.y = element_blank()
p + tempTheme 
ggsave(p+tempTheme, 
       filename = "exampPie.png",  
       bg = "transparent",
       width = 4, height = 4, units = 'in')
tempTheme = myThemeDark
tempTheme$axis.line = element_blank()
tempTheme$axis.title.x = element_blank()
tempTheme$axis.title.y = element_blank()
ggsave(p+tempTheme + scale_fill_manual(values = 
                                         rep('#ABA269',
                                          length(classes))), 
       filename = "exampPieDim.png",  
       bg = "transparent",
       width = 4, height = 4, units = 'in')

####################################################################
#### LINE PLOT       ###############################################
####################################################################

years = unique(mpg$year)
plotStats = t(array(unlist(lapply(
                          years, function(x){c(
                                    mean(mpg$hwy[mpg$year==x], na.rm=T),
                                    sd(mpg$hwy[mpg$year==x], na.rm=T)/
                                                sqrt(sum(mpg$year==x)),
                                    x
                                  )
                              }
                          )
                   ),
                  dim = c(3,2)
                  ))
colnames(plotStats) <- c('meanVals', 'ste', 'year')
plotStats <- as_tibble(plotStats)
plotStats <- plotStats %>% mutate('upper' = meanVals - ste, 
                                  'lower' = meanVals + ste)
pBright<-ggplot(plotStats, aes(y=meanVals, x = year, 
                      ymin = lower, ymax = upper)) +
  geom_point(size = 2, show.legend=F,color = '#20CDF2') +
  geom_line(size = 2, show.legend=F,color = '#20CDF2') +
  geom_errorbar(width=0.5, size = 2, show.legend=F,color = '#20CDF2')+
  ylab('miles per gallon') + 
  xlab('year') +
  ggtitle("fuel efficiency by year")

pDim<-ggplot(plotStats, aes(y=meanVals, x = year, 
                            ymin = lower, ymax = upper)) +
  geom_point(size = 2, show.legend=F,color = '#ABA269') +
  geom_line(size = 2, show.legend=F,color = '#ABA269') +
  geom_errorbar(width=0.5, size = 2, show.legend=F,color = '#ABA269')+
  ylab('miles per gallon') + 
  xlab('year') +
  ggtitle("fuel efficiency by year")


pBright+myTheme
pDim + myThemeDark

ggsave(pBright+myTheme, 
       filename = "exampLine.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')
ggsave(pDim+myThemeDark, 
       filename = "exampLineDim.png",  
       bg = "transparent",
       width = 4.53, height = 2.92, units = 'in')


#   
#   
#   
#   
#   geom_text(aes(y = ypos, label = group), color = "black", size=6) +
#   scale_fill_brewer(palette="Set1")
# 
# 
# 
# 
# p <- ggplot(mpg, aes(factor(1), fill = class))+
#   geom_bar( width = 1) +
#   geom_text(aes( label = ..count..), stat = "count", colour = "white")+
#   coord_polar(theta = "y") +
#   xlab(NULL) +
#   ylab(NULL)
#   ggtitle("fuel efficiency by types of vehicle")
# p + myTheme
# ggsave(p + brightCol + brightFil + myTheme, 
#        filename = "exampBar.png",  bg = "transparent",
#        width = 9, height = 2.92, units = 'in')
# ggsave(p + dimCol + dimFil + myThemeDark, 
#        filename = "exampBarDim.png",  bg = "transparent",
#        width = 9, height = 2.92, units = 'in')

####################################################################
#### BAR PLOT SCI COMBO QUESTION ###################################
####################################################################
usTrends$noNASC1 <- usTrends$SC1_W15
usTrends$noNASC1[is.na(usTrends$noNASC1)] <- 0
usTrends$noNATECH1 <- usTrends$TECH1_W15
usTrends$noNATECH1[is.na(usTrends$noNATECH1)] <- 0

#sanity check that the addition is working
usTrends$noNATECH1 + usTrends$noNASC1
#why are there 3s? 

#let's look at them in the original data 
idx = which(usTrends$noNATECH1 + usTrends$noNASC1 == 3)
usTrends$SC1_W15[idx]
usTrends$VIEWSCHAR_W15[idx]

#3 means someone refused, we can note that: 
usTrends <- usTrends %>% mutate(sciTech = 
                                  factor(noNASC1 + noNATECH1,
                                         labels = c("pos","neg",
                                                    "neutral","refused")))

#how do people feel about science and tech? 
ggplot(usTrends, mapping = aes(x = sciTech)) + 
  geom_bar()

#did the way the question was phrased make a difference? 
ggplot(usTrends, mapping = aes(x = sciTech)) +
  geom_bar() +
  facet_wrap(~form)