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

rss <- read_xml("https://www.bild.de/rss-feeds/rss-16725492,feed=news.bild.html")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-c(1:2)]

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "BILD"
addedwhen<-Sys.time()
topic <- "News"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",date_file,"_",topic,"_",time_file)

write_xml(rss,file = paste0("./newspaper_rss/Bild/RSS_NEWS/bild_rssnews_",date_file,"_",time_file,".txt"))

#Setup RSelenium

remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

for(l in 1:length(links)){
  
  # Add needed Cookies  
  if(l == 1){
    remDr$navigate("https://www.bild.de")
    cookies <- readRDS("./newspaper_rss/Bild/cookies_bild.rds")
    for (i in 1:length(cookies)) {
      remDr$addCookie(name = cookies[[i]][["name"]], value = cookies[[i]][["value"]])
    }
    
    # Accept Data Security Question
    r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
    remDr$switchToFrame(r[[1]])
    r <- remDr$findElement("xpath", '//*[@id="notice"]/div[3]/div[2]/button')
    r$clickElement()
    remDr$switchToFrame(NA)
    
    Sys.sleep(2)
  }
  
  # Now navigate to specific article page
  article <- paste0("",links[l],"")
  remDr$navigate(article)
  Sys.sleep(5)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  date <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="authors__pubdate"]')
      date <- unlist(r$getElementText())
      
      date <- gsub(" Uhr", "", date)
      date <- as.POSIXct(date, format = "%d.%m.%Y - %H:%M")
    })
  },
  error = function(e) {
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="pub-date"]')
      date <- unlist(r$getElementText())
      
      date <- as.POSIXct(date, format = "%d.%m.%Y")
      return(date)
    })
  },
  error = function(e) {
    r <- remDr$findElement('xpath', '//*[@class="datetime datetime--article"]')
    date <- unlist(r$getElementText())
    
    date <- gsub("Uhr", "", date)
    date <- as.POSIXct(date, format = "%d.%m.%Y - %H:%M")
    return(date)
  },
  error = function(e) {
    date <- NA
    
    return(date)
  }
  )
  
  title <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@id="cover"]')
      title <- unlist(r$getElementText())
    })
  },
  error = function(e) {
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="headline"]')
      title <- unlist(r$getElementText())
      return(title)
    })
  }, 
  error = function(e) {
    r <- remDr$findElement('xpath', '//*[@class="article-header__heading"]')
    title <- unlist(r$getElementText())
    return(title)
  },
  error = function(e) {
    title <- NA
    
    return(title)
  }
  )
  
  text <- tryCatch({
    suppressMessages({
      c <- remDr$findElements('xpath', '//*[contains(@class, "txt")]')
      text<-c()
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())
      }
      text <- paste(text, collapse="")
    })
  },
  error = function(e) {
    suppressMessages({
      c <- remDr$findElements('xpath', '//*[contains(@class, "desc")]')
      text<-c()
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())
      }
      text <- paste(text, collapse="")
      return(text)
    })
  },
  error = function(e) {
    c <- remDr$findElements('xpath', '//*[contains(@class, "article-body")]')
    text<-c()
    for(k in 1:length(c)){
      text[k]<-unlist(c[[k]]$getElementText())
    }
    text <- paste(text, collapse="")
    return(text)
  },
  error = function(e) {
    text <- NA
    
    return(text)
  }
  )
  
  # Look for Tweets on the page
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
      Sys.sleep(1)
      
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
  
  
  Sys.sleep(2)
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  
  url <- gsub("https://www.","",links[l])
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("_html",".html",url)
  write_html(article_html, paste0("./newspaper_rss/Bild/HTMLS_NEWS/",url))
  filepath <- paste0("./newspaper_rss/Bild/HTMLS_NEWS/",url)
  
  # Create Article ID
  articleID<-paste0(l,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, links[l], outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)  
}  

remDr$deleteAllCookies()
remDr$close() 