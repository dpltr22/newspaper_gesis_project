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
rss <- read_xml("https://rss.focus.de/politik/")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-c(1,2)]

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "Focus"
addedwhen<-Sys.time()
topic <- "Politik"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",topic,"_",date_file,"_",time_file)

# Save copy on harddrive of RSS Feed
write_xml(rss,file = paste0("./newspaper_rss/Focus/RSS_POLITIK/focus_rsspolitik_",date_file,"_",time_file,".txt"))


#Setup RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()


for(l in 1:length(links)){
  
  # Now navigate to specific article page
  article <- paste0("",links[l],"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  if(l == 1){
    # Now accept the Data Security Question
    r <- remDr$findElements("xpath", '//*[@title="Iframe title"]')
    remDr$switchToFrame(r[[1]])
    r <- remDr$findElement("xpath", '//*[@title="Akzeptieren"]')
    r$clickElement()
    remDr$switchToFrame(NA)
  }
  
  r <- remDr$findElement('xpath', '//*[@class="displayDate"]')
  date <- unlist(r$getElementText())
  
  r <- remDr$findElement('xpath', '//*[@class="articleIdentH1"]')
  title <- unlist(r$getElementText())
  
  c <- remDr$findElements('xpath', '//*[contains(@class, "textBlock")]')
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
      
      r <- remDr$findElement("css", "body")
      r$sendKeysToElement(list(key = "end"))
      Sys.sleep(2)
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-1"]')
      tweet_id2 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-2"]')
      tweet_id3 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-3"]')
      tweet_id4 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-4"]')
      tweet_id5 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-5"]')
      tweet_id6 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-6"]')
      tweet_id7 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-7"]')
      tweet_id8 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-8"]')
      tweet_id9 <- unlist(r$getElementAttribute('data-tweet-id'))
      
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-9"]')
      tweet_id10 <- unlist(r$getElementAttribute('data-tweet-id'))
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
  write_html(article_html, paste0("./newspaper_rss/Focus/HTMLS_POLITIK/",url,".html"))
  filepath <- paste0("./newspaper_rss/Focus/HTMLS_POLITIK/",url)
  
  date <- gsub("[A-z]", "",date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  
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