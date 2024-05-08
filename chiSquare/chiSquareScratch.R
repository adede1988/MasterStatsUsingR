#some scratch stuff for Chi Square test




## here are C section rates by state and year: 

path = 'R:\\MSS\\Johnson_Lab\\dtf8829\\GitHub\\MasterStatsUsingR\\data\\CsectionRates.csv'

cSec = read.csv(path)

#the challenge is that chi squared tests work on observed versus expected values, so we need to know the actual counts! 

#here are the total births for each state
path = 'R:\\MSS\\Johnson_Lab\\dtf8829\\GitHub\\MasterStatsUsingR\\data\\Natality, 2016-2022 expanded.txt'

data <- read_delim(path, 
                   delim = "\t", # Specify tab as the delimiter
                   quote = "\"", # Specify quotation marks as text qualifiers
                   col_names = c("Notes", "StateOfRes", "StateCode", "Births"),
                   skip = 1 # Adjust this as needed to skip any header info
)

data <- data[!is.na(data$StateCode), ]
data <- select(data, -Notes) # Remove the 'Notes' column

#but they don't use the same state coding! Let's ask chatGPT to help us: 
state_abbreviations <- data.frame(
  State = c(
    "Alabama", "Alaska", "Arizona", "Arkansas", "California",
    "Colorado", "Connecticut", "Delaware", "Florida", "Georgia",
    "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
    "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
    "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
    "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
    "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
    "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina",
    "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
    "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
  ),
  Abbreviation = c(
    "AL", "AK", "AZ", "AR", "CA",
    "CO", "CT", "DE", "FL", "GA",
    "HI", "ID", "IL", "IN", "IA",
    "KS", "KY", "LA", "ME", "MD",
    "MA", "MI", "MN", "MS", "MO",
    "MT", "NE", "NV", "NH", "NJ",
    "NM", "NY", "NC", "ND", "OH",
    "OK", "OR", "PA", "RI", "SC",
    "SD", "TN", "TX", "UT", "VT",
    "VA", "WA", "WV", "WI", "WY"
  )
)
names(state_abbreviations) <- c("stateLong", "STATE")
#now we can link this information together! 
merge(state_abbreviations, cSec) -> cSec
cSec <- cSec %>% filter(YEAR == 2021)
names(data) <- c("stateLong", "code", "Births")
cSec <- merge(cSec, data) %>% select(c('YEAR', 'stateLong', 'RATE', 'Births'))

cSec$cSecCount = (cSec$RATE/100) * cSec$Births

test <- filter(cSec, stateLong %in% c('New York', 'California')  )

#bit thing is that this test compares births to c-sections which doesn't make
#sense since c-section is a subset of total births
chisq.test(test[,c(4,5)])


cSec$vagCount = cSec$Births - cSec$cSecCount

#this test now compares c-sections to vaginal births, which does make sense
#chi square test is about comparing outcomes! not about comparing part to whole!
chisq.test(cSec[,c(5,6)])



#can use bootstrapping to test proportions if we don't have actual counts
# Define proportions and assumed sample sizes
prop1 <- 0.30  # proportion for group 1
n1 <- 100     # sample size for group 1
prop2 <- 0.45  # proportion for group 2
n2 <- 100     # sample size for group 2

# Simulate data
set.seed(123)
data1 <- rbinom(1000, size = n1, prob = prop1)
data2 <- rbinom(1000, size = n2, prob = prop2)

# Bootstrap comparison function
compare_props <- function(data1, data2) {
  sample1 <- sample(data1, replace = TRUE)
  sample2 <- sample(data2, replace = TRUE)
  mean(sample1/n1) - mean(sample2/n2)
}

# Bootstrap the difference
boot_diffs <- replicate(10000, compare_props(data1, data2))

# Calculate confidence interval
CI <- quantile(boot_diffs, c(0.025, 0.975))

# Output results
list(CI = CI, P_Value = mean(boot_diffs >= 0 | boot_diffs <= 0))


