# Retrieve links from RSS-Feed
library(RSelenium)
library(rvest)
library(XML)
library(xml2)
library(stringr)
library(RMySQL)

# SQL Login

db_user <- 'root'
db_password <- 'gesisonline'
db_name <- 'newsfeed'
db_host <- "127.0.0.1" # root server  access
db_port <- 3306
us <-  dbConnect(RMySQL::MySQL(), user = db_user, password = db_password,
                 dbname = db_name, host = db_host, port = db_port)
dbSendQuery(us, "ALTER DATABASE newsfeed CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")


# Retrieve links from RSS-Feed
rss <- read_xml("https://www.n-tv.de/politik/rss")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-c(1,2)]

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "NTV"
addedwhen<-Sys.time()
topic <- "Standard"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",topic,"_",date_file,"_",time_file)

# Save copy on harddrive of RSS Feed
write_xml(rss,file = paste0("./newspaper_rss/NTV/RSS_FEEDS/ntv_rss_",date_file,"_",time_file,".txt"))


#Setup RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

for(l in 1:length(links)){

# Now navigate to specific article page
article <- paste0("",links[l],"")
remDr$navigate(article)
Sys.sleep(4)

if(l == 1){
# Now accept the Data Security Question
r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@id="notice"]/div[3]/div[2]/button')
r$clickElement()
remDr$switchToFrame(NA)
}

r <- remDr$findElement('xpath', '//*[@class="article__date"]')
date <- unlist(r$getElementText())

r <- remDr$findElement('xpath', '//*[@class="article__headline"]')
title <- unlist(r$getElementText())

c <- remDr$findElements('xpath', '//*[@class="article__text"]')
text<-c()
for(k in 1:length(c)){
  text[k]<-unlist(c[[k]]$getElementText())
}
text <- paste(text, collapse="")

# Now look for Tweets on page
tweet_id1 <- NA
tweet_id2 <- NA
tweet_id3 <- NA
tweet_id4 <- NA
tweet_id5 <- NA
tweet_id6 <- NA
tweet_id7 <- NA
tweet_id8 <- NA
tweet_id9 <- NA
tweet_id10 <- NA

result <- tryCatch({
  suppressMessages({
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-0"]')
    tweet_id1 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id1)==0){
      tweet_id1 <- "check"
    }
    
    r <- remDr$findElement("css", "body")
    r$sendKeysToElement(list(key = "end"))
    Sys.sleep(3)
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-1"]')
    tweet_id2 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id2)==0){
      tweet_id2 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-2"]')
    tweet_id3 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id3)==0){
      tweet_id3 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-3"]')
    tweet_id4 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id4)==0){
      tweet_id4 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-4"]')
    tweet_id5 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id5)==0){
      tweet_id5 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-5"]')
    tweet_id6 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id6)==0){
      tweet_id6 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-6"]')
    tweet_id7 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id7)==0){
      tweet_id7 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-7"]')
    tweet_id8 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id8)==0){
      tweet_id8 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-8"]')
    tweet_id9 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id9)==0){
      tweet_id9 <- "check"
    }
    
    r <- remDr$findElement('xpath','//*[@id="twitter-widget-9"]')
    tweet_id10 <- unlist(r$getElementAttribute('data-tweet-id'))
    if(length(tweet_id10)==0){
      tweet_id10 <- "check"
    }
  })
},
error = function(e) {
  message("No tweet on this site.")
}
)

# Now we make a safe copy of the page
article_html <- remDr$getPageSource()
article_html <- read_html(article_html[[1]])

url <- gsub("https://www.","",links[l])
url <- gsub("\\/","_",url)
url <- gsub("\\.","_",url)
write_html(article_html, paste0("./newspaper_rss/NTV/HTMLS/",url,".html"))

filepath <- paste0("./newspaper_rss/NTV/HTMLS/",url)

date <- gsub("August", "08.", date)
date <- gsub("September", "09.", date)
date <- gsub("Oktober", "10.", date)
date <- gsub("November", "11.", date)
date <- gsub("Dezember", "12.", date)
date <- gsub("Januar", "01.", date)
date <- gsub("[A-z]", "",date)
date <- gsub("\\,", "", date)
date <- as.POSIXct(date, format = "%d. %m. %Y ")

# Create Article ID
articleID<-paste0(l,"_",outlet,"_",topic,"_",Sys.time())
articleID<-gsub(" ","_",articleID)

df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                       tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                       date, links[l], outlet, filepath, addedwhen, rssid, rsstopic)

colnames(df)[15] <- "link" 

dbWriteTable(us,"articles",df,append=T,row.names=F)
}

remDr$close()


