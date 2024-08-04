

df = read.csv('C:\\Users\\Adam\\Documents\\GitHub\\SheffieldAutismBiomarkers_oldExtra\\autismBiomarkersAllData3.csv')


library(tidyverse)

df <- df %>% select(-names(df)[grepl('PAC', names(df))])
df <- df %>% select(-names(df)[grepl('phase', names(df))])
df <- df %>% select(-names(df)[grepl('Asym', names(df))])
df <- df %>% select(-names(df)[grepl('sampEnt', names(df))])
df <- df %>% select(-names(df)[grepl('ispc', names(df))])
df <- df %>% select(-names(df)[grepl('Slope', names(df))])
df <- df %>% select(-names(df)[grepl('Alpha', names(df))])
df <- df %>% select(-names(df)[grepl('log', names(df))])
df <- df %>% select(-names(df)[grepl('rel', names(df))])

df<- df%>% filter(eyes == 'open')

myGitHubPath = 'C:\\Users\\Adam\\Documents\\GitHub\\MasterStatsUsingR\\'
write.csv(df, paste0(myGitHubPath, 'data\\restingEEG.csv'))

df %>% ggplot(aes(x = pow_delta_O)) + geom_histogram(breaks = seq(0,50,1)) + facet_grid(group~.)

df %>% ggplot(aes(x = age, y = log(pow_delta_O))) + geom_point()
