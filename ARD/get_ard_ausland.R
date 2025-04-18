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
db_host <- "127.0.0.1" # root server access
db_port <- 3306
us <-  dbConnect(RMySQL::MySQL(), user = db_user, password = db_password,
                 dbname = db_name, host = db_host, port = db_port)

dbSendQuery(us, "ALTER DATABASE newsfeed CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")

# Get links from RSS Feed

rss <- read_xml("https://www.tagesschau.de/newsticker.rdf")

links_xml <- xml_nodes(rss, "link")
links <- xml_text(links_xml)
links <- links[-1]

# Standard Variables

date_file <- Sys.Date()

time_file <- format(Sys.time(), format="%H_%M_%S")

outlet <- "ARD"
addedwhen<-Sys.time()
topic <- "Ausland"

rsstopic<-paste0(outlet,"_",topic)
rssid<-paste0(outlet,"_",topic,"_",date_file,"_",time_file)

# Save copy on harddrive of RSS Feed
write_xml(rss,file = paste0("./newspaper_rss/ARD/RSS_AUSLAND/ard_rssausland_",date_file,"_",time_file,".txt"))

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
    

      # Get metadata of the article
      
      title <- NA
      date <- NA
      text <- NA
      
      result <- tryCatch({
        suppressMessages({
          r <- remDr$findElement('xpath', '//*[@class="metatextline"]')
          date <- unlist(r$getElementText())
          
          r <- remDr$findElement('xpath', '//*[@id="content"]/article/div[1]/div[2]/div/h1/span[2]')
          title <- unlist(r$getElementText())
          
          c <- remDr$findElements('xpath', '//*[contains(@class, "textabsatz")]')
          for(k in 1:length(c)){
            text[k]<-unlist(c[[k]]$getElementText())
          }
          text <- paste(text, collapse="")
        })
      },
      error = function(e) {
        message("Just a video link.")
      }
      )
      
      # Accept Data Security for external content
      result <- tryCatch({
        suppressMessages({
          result <- remDr$findElement('xpath','//*[@class="external-embed external-embed--twitter"]')
        })
      },
      error = function(e) {
        message("Already accepted.")
      }
      )  
      
      
      ds_click <- tryCatch({
        suppressMessages({
          result$clickElement()
        })
      },
      error = function(e) {
        message("Ignore me.")
      }
      )
      
      
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
  write_html(article_html, paste0("./newspaper_rss/ARD/HTMLS_AUSLAND/",url,".html"))
  filepath <- paste0("./newspaper_rss/ARD/HTMLS_AUSLAND/",url,".html")
  
  date <- gsub("[A-z]", "", date)
  date <- gsub(": ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y  %H:%M")
  
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