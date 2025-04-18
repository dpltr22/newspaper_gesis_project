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
rss <- read_xml("https://www.welt.de/feeds/section/politik.rss")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-c(1:2)]

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "WELT"
addedwhen<-Sys.time()
topic <- "Politik"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",topic,"_",date_file,"_",time_file)

# Save copy on harddrive of RSS Feed
write_xml(rss,file = paste0("./newspaper_rss/Welt/RSS_POLITIK/welt_rsspolitik_",date_file,"_",time_file,".txt"))


#Setup RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

for(l in 1:length(links)){
  
  if(l==1){
    # Navigate to Login Page
    remDr$navigate("https://secure.mypass.de/sso/web/login?service=https%3A%2F%2Fwww.welt.de%2F&adobe_mc=MCMID%3D75785874272663100190786876232205117899%7CMCORGID%3DB21B678254F601E20A4C98A5%2540AdobeOrg%7CTS%3D1627283490")
    
    # Fill in the Login Form
    
    r <- remDr$findElement("xpath", "//*[@name='username']")
    r$sendKeysToElement(list(""))
    
    r <- remDr$findElement("xpath", "//*[@name='password']")
    r$sendKeysToElement(list(""))
    
    r <- remDr$findElement("xpath", "//*[@type='submit']")
    r$clickElement()
    
    # Now accept the Data Security Question
    r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
    remDr$switchToFrame(r[[1]])
    r <- remDr$findElement("xpath", '//*[@id="notice"]/div[3]/div[2]/button')
    r$clickElement()
    remDr$switchToFrame(NA)
  }
  
  # Now navigate to specific article page
  article <- paste0("",links[l],"")
  remDr$navigate(article)
  Sys.sleep(4)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  date <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="c-publish-date"]')
      date <- unlist(r$getElementText())
    })
  },
  error = function(e) {
    r <- remDr$findElement('xpath', '//*[@data-qa="PublishDate"]')
    date <- unlist(r$getElementText())
    return(date)
  },
  error = function(e) {
    date <- NA
    
    return(date)
  }
)  
  
  title <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@data-qa="Headline"]')
      title <- unlist(r$getElementText())
    })
  })
  
  if(title == ""){
    r <- remDr$findElement('xpath', '//*[@class="c-headline o-dreifaltigkeit__headline rf-o-headline"]')
    title <- unlist(r$getElementText())
  }
  
  text <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[contains(@class, "c-summary__intro")]')
      text_intro <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@data-qa, "Article.Text")]')
      text<-c()
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())
      }
      text <- paste(text_intro, text, collapse="")
    })
  },
  error = function(e) {
    r <- remDr$findElement('xpath', '//*[contains(@class, "c-summary__intro")]')
    text <- unlist(r$getElementText())
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
  
  r <- remDr$findElement("css", "body")
  r$sendKeysToElement(list(key = "end"))
  Sys.sleep(5)
  
  result <- tryCatch({
    suppressMessages({
      # Accept Data Security for external content
      
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
    message("Ignore me.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",links[l])
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Welt/HTMLS_POLITIK/",url,".html"))
  filepath <- paste0("./newspaper_rss/Welt/HTMLS_POLITIK/",url)
  
  if(grepl("Uhr", date, fixed = TRUE)){
    date <- gsub("[A-z]","",date)
    date <- gsub(": ", "", date)
    date <- paste0(Sys.Date(), date, sep = " ")
    date <- as.POSIXct(date, format = "%Y-%m-%d %H:%M")
  } else {
    date <- gsub("[A-z]","",date)
    date <- gsub(": ", "", date)
    date <- paste0(date, sep = " ","12:00")
    date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  }
  
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