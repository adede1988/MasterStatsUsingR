#Statistics with R using the Tidyverse: 
#intuition, basic coding, and applications
#Bar graphs
#Adam Dede; adam.osman.dede@gmail.com 
#Winter 2022




library(tidyverse)
library(kableExtra)
library(haven)

usTrends = read_sav('G:\\My Drive\\Teaching\\stats\\RCourse\\plotting\\ATP W15.sav')
# https://www.pewresearch.org/politics/dataset/american-trends-panel-wave-15/
#These data were collected between March 2 and 28, 2016
#let's explore the data a bit: 
names(usTrends)

#look at these two survey items on the que sheet 
usTrends$VIEWSCHAR_W15
usTrends$AGREEPOL_W15

#there were two forms of the survey, let's make a variable to represent this:
usTrends <- usTrends %>% 
              mutate(form = factor(ifelse(is.na(AGREEPOL_W15), 1, 2),
                                   labels =c('form1', 'form2')))
                                
                                                  

#both tell us about how much someone believes politics defines someone
#let's combine them both into a single variable
usTrends$noNAview <- usTrends$VIEWSCHAR_W15
usTrends$noNAview[is.na(usTrends$noNAview)] <- 0
usTrends$noNAagree <- usTrends$AGREEPOL_W15
usTrends$noNAagree[is.na(usTrends$noNAagree)] <- 0

#sanity check that the addition is working
usTrends$noNAagree + usTrends$noNAview
#why are there 3s? 

#let's look at them in the original data 
idx = which(usTrends$noNAagree + usTrends$noNAview == 3)
usTrends$AGREEPOL_W15[idx]
usTrends$VIEWSCHAR_W15[idx]

#3 means someone refused, we can note that: 
usTrends <- usTrends %>% mutate(polarized = 
                    factor(noNAview + noNAagree,
                    labels = c("polar","non-polar","refused")))

#how polarized are people? 
ggplot(usTrends, mapping = aes(x = polarized)) + 
  geom_bar()

#did the way the question was phrased make a difference? 
ggplot(usTrends, mapping = aes(x = polarized)) +
  geom_bar() +
  facet_wrap(~form)



#can you do a similar combination of questions:
#SC1_W15 and TECH1_W15?
#Looking at the question sheet, does it make sense to combine these?
#Looking at their graphs does combination work well for them? 
#Were there any unexpected values in the combination? 
#What will you label the different response values? 

#political party: 
usTrends <- usTrends %>% mutate(party = ifelse(VOTEPARTY_W15<3, 'rep', 
                                        ifelse(VOTEPARTY_W15<5, 'dem', 
                                               'und')))

ggplot(usTrends, mapping = aes(x = party)) +
  geom_bar()


counts <- usTrends %>% group_by(party) %>%  
  summarize(polar=sum(polarized=='polar')/length(polarized),
            partyDif = sum(PARTYDIFF_W15<3) / length(PARTYDIFF_W15),
            geneMoral = sum(GEN7_W15==1)/length(GEN7_W15),
            chipGood = sum(CHIP2_W15<3)/length(CHIP2_W15))

counts %>% 
  kbl(align = 'cr', digits = 2) %>% 
  kable_classic(full_width = F, 
                font_size = 20) 

plotVals <- counts %>% gather(condition, measurement, 
       polar:chipGood, factor_key=TRUE)


p<-plotVals %>% ggplot(mapping = 
                      aes(fill = party, 
                          x=condition,
                          y=measurement)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  xlab("question") +
  ylab("proportion positive/yes")


p + facet_wrap(.~party) +
  theme(axis.text.x = element_text(angle=45))

