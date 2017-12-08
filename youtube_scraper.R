library(RSelenium)
library(rvest)

# start a chrome browser
rD <- rsDriver()
remDr <- rD[["client"]]

# Define URL
url <- 'https://www.youtube.com/user/DevTipsForDesigners/videos'

#navigate to your page
remDr$navigate(url)

# Scroll down multiple times
webElem <- remDr$findElement("css", "body")

for (i in 1:10){
  webElem$sendKeysToElement(list(key = "end"))
  Sys.sleep(2) # Wait for few seconds to get new results loaded
}

Sys.sleep(5) # Wait for few seconds to get fully loaded

# Let us read the html page now
page_source<-remDr$getPageSource()[[1]]
html <- read_html(page_source)

# Title
title <- html %>%
  html_nodes('#video-title') %>%
  html_text()

# Length
length <- html %>%
  html_nodes('.ytd-thumbnail-overlay-time-status-renderer') %>%
  html_text()

# Percentage watched
# html <- paste(readLines(url), collapse="\n")
# library(stringr)
# matched <- str_match_all(html, "<a href=\"(.*?)\"")

# webElem <- remDr$findElement(using = 'class name', "ytd-thumbnail-overlay-resume-playback-renderer")
# webElem$getElementAttribute("style")

# Close browser
remDr$close()
# stop the selenium server
rD[["server"]]$stop() 

# Dataset
df <- data.frame(cbind(title, length))
