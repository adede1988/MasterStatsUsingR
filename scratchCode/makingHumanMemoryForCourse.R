##scratch for doing a quick bit of cleaning on human memory data: 


df = read.csv(paste0(gitHubPath, 'data\\test.csv'))

df <- df %>% select(-names(df)[grepl('_1', names(df))] )
df <- df %>% select(-names(df)[grepl('_2', names(df))] )
df <- df %>% select(-names(df)[grepl('_3', names(df))] )
df <- df %>% select(-names(df)[grepl('_4', names(df))] )
df <- df %>% select(-names(df)[grepl('_5', names(df))] )
df <- df %>% select(-names(df)[grepl('_6', names(df))] )
df <- df %>% select(-names(df)[grepl('Lag1_', names(df))] )
df <- df %>% select(-names(df)[grepl('Lag5_', names(df))] )
df <- df %>% select(-names(df)[grepl('_x', names(df))] )
df <- df %>% select(-names(df)[grepl('_s', names(df))] )


write.csv(df, paste0(gitHubPath, 'data\\MemoryData.csv'))