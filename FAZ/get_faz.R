# Load packages
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
rss <- read_xml("https://www.faz.net/rss/aktuell/politik/")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-c(1:2)]

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "FAZ"
addedwhen<-Sys.time()
topic <- "Standard"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",topic,"_",date_file,"_",time_file)

write_xml(rss,file = paste0("./newspaper_rss/FAZ/RSS_FEEDS/faz_rss_",date_file,"_",time_file,".txt"))


#Setup PC Dylan RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

l <- 3

for(l in 1:length(links)){
  
  if(l == 1){
    # First navigate to FAZ
    remDr$navigate("https://www.faz.net/")
    Sys.sleep(2)
    # Accept Data Security Question
    r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
    remDr$switchToFrame(r[[1]])
    r <- remDr$findElement("xpath", '//*[@title="EINVERSTANDEN"]')
    r$clickElement()
    
    remDr$switchToFrame(NA)
    
    # Begin Login Process
    r <- remDr$findElement("xpath", '//*[@id="TOP"]/header/nav/div/div[6]/button[1]')
    r$clickElement()
    Sys.sleep(4)
    
    r <- remDr$findElements("xpath", '//*[@class="lay-Login_Iframe"]')
    remDr$switchToFrame(r[[1]])
    
    r <- remDr$findElement("xpath", '//*[@name="loginName"]')
    r$sendKeysToElement(list("mayer@dezim-institut.de"))
    
    r <- remDr$findElement("xpath", "//*[@name='password']")
    r$sendKeysToElement(list("ImaGs2_faz21"))
    
    r <- remDr$findElement("xpath", "//*[@class='btn-Base_Text']")
    r$clickElement()
  }
  
  # Now navigate to specific article page
  article <- paste0("",links[l],"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  intro_text <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="atc-MetaTime"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="atc-HeadlineText"]')
      title <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[contains(@class, "atc-IntroText")]')
      intro_text <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@class, "atc-TextParagraph")]')
      text<-c()
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())
      }
      text <- paste(intro_text, text, collapse="")
    })
  },
  error = function(e) {
    message("Just a video link.")
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
      
      r <- remDr$findElement("css", "body")
      r$sendKeysToElement(list(key = "end"))
      Sys.sleep(1)
      
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
    message("Ignore me.")
  }
  )
  
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  
  url <- gsub("https://www.","",links[l])
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("_html",".html",url)
  write_html(article_html, paste0("./newspaper_rss/FAZ/HTMLS/",url))
  
  filepath <- paste0("./newspaper_rss/FAZ/HTMLS/",url)
  
  date <- gsub("-", " ", date)
  date <- gsub("\\.", "-", date)
  date <- as.POSIXct(date, format = "%d-%m-%Y %H:%M")
  
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

