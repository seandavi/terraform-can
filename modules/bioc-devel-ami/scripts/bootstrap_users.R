install.packages(c('babynames','dplyr'))
## Add users function. Assumes that user and password
## are identical.
useradd_local = function(user) {
    system(sprintf("sudo useradd -m -p $(echo %s | openssl passwd -1 -stdin) %s",
                   user, user))
}

library(babynames)
library(dplyr)
# Choose 300 names, so up to 300 accounts.
unames = babynames %>% 
    filter(year>2009) %>% 
    group_by(name) %>% 
    summarize(x=sum(n)) %>% 
    arrange(desc(x)) %>% 
    transform(name=tolower(name)) %>%
    head(300) %>%
    pull(name)
sapply(unames,useradd_local)


