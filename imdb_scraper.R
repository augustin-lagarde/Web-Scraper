#install.packages("rvest")

library(rvest)

# Store web url
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

#Scrape the website
lego_movie %>%
  html_nodes("#titleCast") %>%
  html_nodes(".itemprop") %>%
  html_text()

