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

# Retrieve links from RSS Feed

rss <- read_xml("http://newsfeed.zeit.de/politik/index")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-c(1:2)]

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "ZEIT"
addedwhen<-Sys.time()
topic <- "Politik"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",date_file,"_",topic,"_",time_file)


# Save copy on harddrive of RSS Feed
write_xml(rss,file = paste0("./newspaper_rss/Zeit/RSS_FEEDS/zeit_rss_",date_file,"_",time_file,".txt"))


# Setup RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

for(l in 1:length(links)){
  
  # Add needed Cookies  
  if(l == 1){
    remDr$navigate("https://www.zeit.de/")
    cookies <- readRDS("./newspaper_rss/Zeit/cookies_zeit.rds")
    for (i in 1:length(cookies)) {
      remDr$addCookie(name = cookies[[i]][["name"]], value = cookies[[i]][["value"]])
    }
    
    # Accept Data Security Question
    r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
    remDr$switchToFrame(r[[1]])
    r <- remDr$findElement("xpath", '//*[@id="notice"]/button')
    r$clickElement()
    remDr$switchToFrame(NA)
  }
  # Now navigate to specific article page
  article <- paste0("",links[l],"")
  remDr$navigate(article)
  Sys.sleep(5)
  
  # Show article on one page
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="article-toc__fullview"]')
      r$clickElement()
      Sys.sleep(3)
    })
  },
  error = function(e) {
    message("Just a one page article.")
  }
  )
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="metadata__date"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="article-heading__title"]')
      title <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="summary"]')
      text_intro <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[@class="paragraph article__item"]')
      text<-c()
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())
      }
      text <- paste(text_intro, text, collapse="")
    })
  },
  error = function(e) {
    message("Just a video link.")
  }
  )

  # Scroll down the page to activate external content
  r <- remDr$findElement("css", "body")
  r$sendKeysToElement(list(key = "end"))
  Sys.sleep(2)
  
  # Accept Data Security Question for external content
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath','//*[@class="embed-consent__toggle"]')
      r$clickElement()
      Sys.sleep(3)
    })
  },
  error = function(e) {
    message("Already accepted.")
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
  Sys.sleep(3)

  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath','//*[@id="twitter-widget-0"]')
      tweet_id1 <- unlist(r$getElementAttribute('data-tweet-id'))
      
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
  Sys.sleep(3)
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",links[l])
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Zeit/HTMLS/",url,".html"))
  filepath <- paste0("./newspaper_rss/Zeit/HTMLS/",url)
  
  date <- gsub("August", "08.", date)
  date <- gsub("September", "09.", date)
  date <- gsub("Oktober", "10.", date)
  date <- gsub("November", "11.", date)
  date <- gsub("Dezember", "12.", date)
  date <- gsub("Januar", "01.", date)
  date <- gsub("[A-z]", "", date)
  date <- gsub(" ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y,%H:%M")
  
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