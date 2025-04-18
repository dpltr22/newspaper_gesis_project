get_ardinland <- function(link){
  outlet <- "ARD"
  topic <- "Inland"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  for(l in 1:length(link)){
    
    type_link <- str_extract(link, "www\\.(.*?)\\.de")
    
    if(!is.na(type_link)){
      # Now navigate to specific article page
      article <- paste0("",link,"")
      remDr$navigate(article)
      Sys.sleep(4)
      
      if(type_link == "www.tagesschau.de"){
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
      } else if (type_link == "www.mdr.de"){
        # Get metadata of the article
        
        title <- NA
        date <- NA
        text <- NA
        
        result <- tryCatch({
          suppressMessages({
            r <- remDr$findElement('xpath', '//*[@class="webtime"]')
            date <- unlist(r$getElementText())
            
            r <- remDr$findElement('xpath', '//*[@id="content"]/div/div[1]/div[2]/div/div/div[1]/div/div/div/div/h1/span[2]')
            title <- unlist(r$getElementText())
            
            c <- remDr$findElements('xpath', '//*[contains(@class, "paragraph")]')
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
            result <- remDr$findElement('xpath','//*[@id="content"]/article/div[6]/div/div/div/label/span')
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
      } else if (type_link == "www.rbb24.de"){
        # Get metadata of the article
        
        title <- NA
        date <- NA
        text <- NA
        
        result <- tryCatch({
          suppressMessages({
            r <- remDr$findElement('xpath', '//*[@id="col1"]/article/time')
            date <- unlist(r$getElementText())
            
            r <- remDr$findElement('xpath', '//*[@class="titletext"]')
            title <- unlist(r$getElementText())
            
            r <- remDr$findElement('xpath', '//*[contains(@class, "shorttext")]')
            intro_text <- unlist(r$getElementText())
            
            c <- remDr$findElements('xpath', '//*[contains(@class, "textblock")]')
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
      } else if (type_link == "www.swr.de"){
        # Get metadata of the article
        
        title <- NA
        date <- NA
        text <- NA
        
        result <- tryCatch({
          suppressMessages({
            r <- remDr$findElement('xpath', '//*[@class="postdate"]')
            date <- unlist(r$getElementText())
            
            r <- remDr$findElement('xpath', '//*[@id="main-content"]')
            title <- unlist(r$getElementText())
            
            c <- remDr$findElements('xpath', '//*[contains(@class, "grid-container grid-x")]')
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
            r <- remDr$findElement('xpath','//*[@class="agree-btn button medium round"]')
            r$clickElement()
            Sys.sleep(3)
          })
        },
        error = function(e) {
          message("Already accepted.")
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
      } else if (type_link == "www.sportschau.de"){
        # Get metadata of the article
        
        title <- NA
        date <- NA
        text <- NA
        
        result <- tryCatch({
          suppressMessages({
            r <- remDr$findElement('xpath', '//*[@class="postdate"]')
            date <- unlist(r$getElementText())
            
            r <- remDr$findElement('xpath', '//*[@id="main-content"]')
            title <- unlist(r$getElementText())
            
            c <- remDr$findElements('xpath', '//*[contains(@class, "grid-container grid-x")]')
            for(k in 1:length(c)){
              text[k]<-unlist(c[[k]]$getElementText())
            }
            text <- paste(text, collapse="")
          })
        },
        error = function(e) {
          message("Just a video link.")
        })
        } else if (type_link == "www.ndr.de"){
          # Get metadata of the article
          
          title <- NA
          date <- NA
          text <- NA
          
          result <- tryCatch({
            suppressMessages({
              r <- remDr$findElement('xpath', '//*[@class="lastchanged"]')
              date <- unlist(r$getElementText())
              
              r <- remDr$findElement('xpath', '//*[@class="articlehead boxed"]')
              title <- unlist(r$getElementText())
              
              c <- remDr$findElements('xpath', '//*[@class="modulepadding copytext"]')
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
            r <- remDr$findElement('xpath','//*[@class="agree-btn button medium round"]')
            r$clickElement()
            Sys.sleep(3)
          })
        },
        error = function(e) {
          message("Already accepted.")
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
      } else if (type_link == "www.br.de"){
        # Get metadata of the article
        
        title <- NA
        date <- NA
        text <- NA
        
        result <- tryCatch({
          suppressMessages({
            r <- remDr$findElement('xpath', '//*[@class="aipd-gtm css-12d6w1e"]')
            date <- unlist(r$getElementText())
            
            r <- remDr$findElement('xpath', '//*[@class="css-1djxc4a"]')
            title <- unlist(r$getElementText())
            
            c <- remDr$findElements('xpath', '//*[@id="articlebody"]')
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
            r <- remDr$findElement('xpath','//*[@class="agree-btn button medium round"]')
            r$clickElement()
            Sys.sleep(3)
          })
        },
        error = function(e) {
          message("Already accepted.")
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
      }
      
      # Now we make a safe copy of the page
      article_html <- remDr$getPageSource()
      article_html <- read_html(article_html[[1]])
      
      url <- gsub("https://www.","",link)
      url <- gsub("\\/","_",url)
      url <- gsub("\\.","_",url)
      write_html(article_html, paste0("./newspaper_rss/ARD/HTMLS_INLAND/",url,".html"))
      filepath <- paste0("./newspaper_rss/ARD/HTMLS_INLAND/",url,".html")
      
      if(!is.character(date)){
        date <- "NO DATE"
      }
      
      date <- gsub("August", "08.", date)
      date <- gsub("September", "09.", date)
      date <- gsub("Oktober", "10.", date)
      date <- gsub("November", "11.", date)
      date <- gsub("Dezember", "12.", date)
      date <- gsub("Januar", "01.", date)
      date <- gsub("[A-z]", "", date)
      date <- gsub(": ", "", date)
      date <- gsub(",", "", date)
      date <- gsub("\\|", "", date)
      date <- as.POSIXct(date, format = "%d.%m.%Y  %H:%M")
      
      # Create Article ID 
      articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
      articleID<-gsub(" ","_",articleID)
      
      if(is.null(date)){
        date <- NA
      }
      
      if(is.null(title)){
        title <- NA
      }
      
      if(is.null(text)){
        text <- NA
      }
      
      
      df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                             tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                             date, link, outlet, filepath, addedwhen, rssid, rsstopic)
      
      colnames(df)[15] <- "link" 
      
      dbWriteTable(us,"articles",df,append=T,row.names=F)
    }
  }
}

get_ardausland <- function(link){
  outlet <- "ARD"
  topic <- "Ausland"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/ARD/HTMLS_AUSLAND/",url,".html"))
  filepath <- paste0("./newspaper_rss/ARD/HTMLS_AUSLAND/",url,".html")
  
  if(!is.character(date)){
    date <- "NO DATE"
  }
  
  date <- gsub("[A-z]", "", date)
  date <- gsub(": ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y  %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link"  
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)}

get_bildnews <- function(link){
  
  outlet <- "BILD"
  topic <- "News"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
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
  
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("_html",".html",url)
  write_html(article_html, paste0("./newspaper_rss/Bild/HTMLS_NEWS/",url))
  filepath <- paste0("./newspaper_rss/Bild/HTMLS_NEWS/",url)
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F) 
}

get_bildpolitik <- function(link){
  
  outlet <- "BILD"
  topic <- "Politik"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
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
  
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("_html",".html",url)
  write_html(article_html, paste0("./newspaper_rss/Bild/HTMLS_NEWS/",url))
  filepath <- paste0("./newspaper_rss/Bild/HTMLS_NEWS/",url)
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_faz <- function(link){
  outlet <- "FAZ"
  topic <- "Standard"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(5)
  
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
  
  if(length(text) == 0){
    text <- NA
  }
  
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
  
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("_html",".html",url)
  write_html(article_html, paste0("./newspaper_rss/FAZ/HTMLS/",url))
  
  filepath <- paste0("./newspaper_rss/FAZ/HTMLS/",url)
  
  date <- gsub("-", " ", date)
  date <- gsub("\\.", "-", date)
  date <- as.POSIXct(date, format = "%d-%m-%Y %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_focusausland <- function(link){
  outlet <- "Focus"
  topic <- "Ausland"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  title <- NA
  date <- NA
  text <- NA
  
result <- tryCatch({
  suppressMessages({  
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
  })
},
error = function(e) {
  message("No parsing possible")
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Focus/HTMLS_AUSLAND/",url,".html"))
  filepath <- paste0("./newspaper_rss/Focus/HTMLS_AUSLAND/",url)
  
  date <- gsub("[A-z]", "",date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_focuspolitik <- function(link){
  outlet <- "Focus"
  topic <- "Politik"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)

  title <- NA
  date <- NA
  text <- NA
  
result <- tryCatch({
  suppressMessages({    
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
})
},
error = function(e) {
  message("Just a video link.")
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Focus/HTMLS_POLITIK/",url,".html"))
  filepath <- paste0("./newspaper_rss/Focus/HTMLS_POLITIK/",url)
  
  date <- gsub("[A-z]", "",date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link"  
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_ntv <- function(link){
  outlet <- "NTV"
  topic <- "Standard"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(4)
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({  
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
    })
  },
  error = function(e) {
    message("Some parsing problem")
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  
  if(nchar(paste0("./newspaper_rss/NTV/HTMLS/",url,".html") >= 260)){
    write_html(article_html, paste0("./newspaper_rss/NTV/HTMLS/url_too_long",a,".html"))
    filepath <- paste0("./newspaper_rss/NTV/HTMLS/url_too_long",a,".html")
  } else {
    write_html(article_html, paste0("./newspaper_rss/NTV/HTMLS/",url,".html"))
    filepath <- paste0("./newspaper_rss/NTV/HTMLS/",url)
  }
  
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
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_rtlnews <- function(link){
  
  outlet <- "RTL"
  topic <- "News"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="date-time"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="header__headline-title font_primary title-xl-size headline-text"]')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@data-type, "text")]')
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
    message("No tweet on this site.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/RTL/HTMLS_NEWS/",url,".html"))
  filepath <- paste0("./newspaper_rss/RTL/HTMLS_NEWS/",url)
  
  date <- gsub("Juni", "06.", date)
  date <- gsub("Juli", "07.", date)
  date <- gsub("August", "08.", date)
  date <- gsub("September", "09.", date)
  date <- gsub("Oktober", "10.", date)
  date <- gsub("November", "11.", date)
  date <- gsub("Dezember", "12.", date)
  date <- gsub("Januar", "01.", date)
  date <- gsub("Uhr", "", date)
  date <- gsub(" ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y-%H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_rtlpolitikausland <- function(link){
  
  outlet <- "RTL"
  topic <- "PolitikAusland"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="date-time"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="header__headline-title font_primary title-xl-size headline-text"]')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@data-type, "text")]')
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
    message("No tweet on this site.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/RTL/HTMLS_POLITIKAUSLAND/",url,".html"))
  filepath <- paste0("./newspaper_rss/RTL/HTMLS_POLITIKAUSLAND/",url)
  
  date <- gsub("Juni", "06.", date)
  date <- gsub("Juli", "07.", date)
  date <- gsub("August", "08.", date)
  date <- gsub("September", "09.", date)
  date <- gsub("Oktober", "10.", date)
  date <- gsub("November", "11.", date)
  date <- gsub("Dezember", "12.", date)
  date <- gsub("Januar", "01.", date)
  date <- gsub("Uhr", "", date)
  date <- gsub(" ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y-%H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_rtlpolitikinland <- function(link){
  
  outlet <- "RTL"
  topic <- "PolitikInland"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="date-time"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="header__headline-title font_primary title-xl-size headline-text"]')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@data-type, "text")]')
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
    message("No tweet on this site.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/RTL/HTMLS_POLITIKINLAND/",url,".html"))
  filepath <- paste0("./newspaper_rss/RTL/HTMLS_POLITIKINLAND/",url)
  
  date <- gsub("Juni", "06.", date)
  date <- gsub("Juli", "07.", date)
  date <- gsub("August", "08.", date)
  date <- gsub("September", "09.", date)
  date <- gsub("Oktober", "10.", date)
  date <- gsub("November", "11.", date)
  date <- gsub("Dezember", "12.", date)
  date <- gsub("Januar", "01.", date)
  date <- gsub("Uhr", "", date)
  date <- gsub(" ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y-%H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_spiegelpolitik <- function(link){
  outlet <- "Spiegel"
  topic <- "Politik"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({  
      r <- remDr$findElement('xpath', '//*[@class="timeformat"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@id="Inhalt"]/article/header/div/div/h2')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@class, "RichText")]')
      text<-c()
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
      r <- remDr$findElement('xpath','//*[@title="Drittanbieter-Inhalte zulassen"]')
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
  Sys.sleep(7)
  
  result <- tryCatch({
    suppressMessages({
      # Scroll down the page to activate external content
      r <- remDr$findElement("css", "body")
      r$sendKeysToElement(list(key = "end"))
      Sys.sleep(2)    
      
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
    message("No more tweets here.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Spiegel/HTMLS_POLITIK/",url,".html"))
  filepath <- paste0("./newspaper_rss/Spiegel/HTMLS_POLITIK/",url)
  
  date <- gsub(" Uhr", "", date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y  %H.%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link"  
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
  
}

get_spiegelschlagzeilen <- function(link){
  outlet <- "Spiegel"
  topic <- "Schlagzeilen"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="timeformat"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@id="Inhalt"]/article/header/div/div/h2')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@class, "RichText")]')
      text<-c()
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
      r <- remDr$findElement('xpath','//*[@title="Drittanbieter-Inhalte zulassen"]')
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
  Sys.sleep(7)
  
  result <- tryCatch({
    suppressMessages({
      # Scroll down the page to activate external content
      r <- remDr$findElement("css", "body")
      r$sendKeysToElement(list(key = "end"))
      Sys.sleep(2)
      
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Spiegel/HTMLS_SCHLAGZEILEN/",url,".html"))
  filepath <- paste0("./newspaper_rss/Spiegel/HTMLS_SCHLAGZEILEN/",url)
  
  date <- gsub(" Uhr", "", date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y  %H.%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
  
}

get_sternpolitik <- function(link){
  outlet <- "Stern"
  topic <- "Politik"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  intro_text <- NA
  
  result <- tryCatch({
    suppressMessages({    
      r <- remDr$findElement('xpath', '//*[contains(@class, "authors__date")]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="title__heading"]')
      title <- unlist(r$getElementText())
      
      r <- remDr$findElements('xpath', '//*[@class="intro"]')
      intro_text <- unlist(r[[1]]$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@class, "text-element")]')
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())}
      text <- paste(intro_text, text, collapse="")
    })
  },
  error = function(e) {
    message("Just a video link.")
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
    message("No tweet on this site.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("\\?","_",url)
  write_html(article_html, paste0("./newspaper_rss/Stern/HTMLS_POLITIK/",url,".html"))
  filepath <- paste0("./newspaper_rss/Stern/HTMLS_POLITIK/",url)
  
  date <- gsub("Uhr", "", date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_sternnews <- function(link){
  outlet <- "Stern"
  topic <- "News"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  intro_text <- NA
  
  result <- tryCatch({
    suppressMessages({    
      r <- remDr$findElement('xpath', '//*[contains(@class, "authors__date")]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="title__heading"]')
      title <- unlist(r$getElementText())
      
      r <- remDr$findElements('xpath', '//*[@class="intro"]')
      intro_text <- unlist(r[[1]]$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@class, "text-element")]')
      for(k in 1:length(c)){
        text[k]<-unlist(c[[k]]$getElementText())}
      text <- paste(intro_text, text, collapse="")
    })
  },
  error = function(e) {
    message("Just a video link.")
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
    message("No tweet on this site.")
  }
  )
  
  # Now we make a safe copy of the page
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  url <- gsub("\\?","_",url)
  write_html(article_html, paste0("./newspaper_rss/Stern/HTMLS_NEWS/",url,".html"))
  filepath <- paste0("./newspaper_rss/Stern/HTMLS_NEWS/",url)
  
  date <- gsub("Uhr", "", date)
  date <- gsub("\\,", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_sueddeutsche <- function(link){
  
  outlet <- "Sueddeutsche"
  topic <- "Standard"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(3)
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="css-1ryfjbe"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@class="css-6dbltg"]')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[@class="css-1r7yllh"]')
      text<-c()
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
  
  if(length(text) == 0){
    text <- NA
  }
  
  # Accept Data Security Question for external content
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath','//*[@class="sz-button consent-guard__load-button"]')
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
    message("No tweet on this site.")
  }
  )
  
  # Now we make a safe copy of the page
  Sys.sleep(3)
  article_html <- remDr$getPageSource()
  article_html <- read_html(article_html[[1]])
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Sueddeutsche/HTMLS/",url,".html"))
  filepath <- paste0("./newspaper_rss/Sueddeutsche/HTMLS/",url)
  
  date <- gsub("August", "08.", date)
  date <- gsub("September", "09.", date)
  date <- gsub("Oktober", "10.", date)
  date <- gsub("November", "11.", date)
  date <- gsub("Dezember", "12.", date)
  date <- gsub("Januar", "01.", date)
  date <- gsub("Uhr", "", date)
  date <- gsub(" ", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y,%H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_weltnews <- function(link){
  outlet <- "WELT"
  topic <- "News"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
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
    suppressMessages({
    r <- remDr$findElement('xpath', '//*[@data-qa="PublishDate"]')
    date <- unlist(r$getElementText())
    return(date)
    })
  } ,
  error = function(f) {
    date <- NA
    return(date)
  }
  )
  
  title <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@data-qa="Headline"]')
      title <- unlist(r$getElementText())
    })
  }, error = function(e){
    suppressMessages({
    r <- remDr$findElement('xpath', '//*[@class="c-headline o-dreifaltigkeit__headline rf-o-headline"]')
    title <- unlist(r$getElementText())
    })
  }, error = function(f){
    title <- NA
    return(title)
  }
  )
  
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
    suppressMessages({
    r <- remDr$findElement('xpath', '//*[contains(@class, "c-summary__intro")]')
    text <- unlist(r$getElementText())
    return(text)
    })
  },
  error = function(f) {
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/Welt/HTMLS_NEWS/",url,".html"))
  filepath <- paste0("./newspaper_rss/Welt/HTMLS_NEWS/",url)
  
  if(grepl("Uhr", date, fixed = TRUE)){
    date <- gsub("[A-z]","",date)
    date <- gsub(": ", "", date)
    date <- paste0(Sys.Date(), date, sep = " ")
    date <- as.POSIXct(date, format = "%Y-%m-%d %H:%M")
  } else {
    date <- gsub("[A-z]","",date)
    date <- gsub(": ", "", date)
    date <- gsub("ö", "", date)
    date <- paste0(date, sep = " ","12:00")
    date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  }
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
  
}

get_weltpolitik <- function(link){
  outlet <- "WELT"
  topic <- "Politik"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
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
    suppressMessages({
    r <- remDr$findElement('xpath', '//*[@data-qa="PublishDate"]')
    date <- unlist(r$getElementText())
    return(date)
    })
  } ,
  error = function(f) {
    date <- NA
    return(date)
  }
  )
  
  title <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@data-qa="Headline"]')
      title <- unlist(r$getElementText())
    })
  },
  error = function(e) {
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="c-headline o-dreifaltigkeit__headline rf-o-headline"]')
      title <- unlist(r$getElementText())
      return(title)
    })
  } ,
  error = function(f) {
    title <- NA
    return(title)
  }
  )
  

  
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
    suppressMessages({
    r <- remDr$findElement('xpath', '//*[contains(@class, "c-summary__intro")]')
    text <- unlist(r$getElementText())
    return(text)
    })
  },
  error = function(f) {
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
  
  url <- gsub("https://www.","",link)
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
    date <- gsub("ö", "", date)
    date <- paste0(date, sep = " ","12:00")
    date <- as.POSIXct(date, format = "%d.%m.%Y %H:%M")
  }
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_zdf <- function(link){
  outlet <- "ZDF"
  topic <- "Standard"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  
  # Now navigate to specific article page
  article <- paste0("",link,"")
  remDr$navigate(article)
  Sys.sleep(4)
  
  # Get metadata of the article
  
  title <- NA
  date <- NA
  text <- NA
  
  result <- tryCatch({
    suppressMessages({
      r <- remDr$findElement('xpath', '//*[@class="postdate"]')
      date <- unlist(r$getElementText())
      
      r <- remDr$findElement('xpath', '//*[@id="main-content"]')
      title <- unlist(r$getElementText())
      
      c <- remDr$findElements('xpath', '//*[contains(@class, "grid-container grid-x")]')
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
      r <- remDr$findElement('xpath','//*[@class="agree-btn button medium round"]')
      r$clickElement()
      Sys.sleep(3)
    })
  },
  error = function(e) {
    message("Already accepted.")
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
  
  url <- gsub("https://www.","",link)
  url <- gsub("\\/","_",url)
  url <- gsub("\\.","_",url)
  write_html(article_html, paste0("./newspaper_rss/ZDF/HTMLS/",url,".html"))
  filepath <- paste0("./newspaper_rss/ZDF/HTMLS/",url)
  
  date <- gsub(" Uhr", "", date)
  date <- as.POSIXct(date, format = "%d.%m.%Y  %H:%M")
  
  # Create Article ID
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
}

get_zeit <- function(link){
  outlet <- "ZEIT"
  topic <- "Politik"
  rsstopic <- missing_links$rsstopic[a]
  rssid <- missing_links$rssid[a]
  # Now navigate to specific article page
  article <- paste0("",link,"")
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
  
  if(length(text) == 0){
    text <- NA
  }
  
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
  
  url <- gsub("https://www.","",link)
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
  articleID<-paste0(a,"_",outlet,"_",topic,"_",Sys.time())
  articleID<-gsub(" ","_",articleID)
  
  if(is.null(date)){
    date <- NA
  }
  
  if(is.null(title)){
    title <- NA
  }
  
  if(is.null(text)){
    text <- NA
  }
  
  df <- cbind.data.frame(articleID, title, text, tweet_id1, tweet_id2, tweet_id3, tweet_id4,
                         tweet_id5, tweet_id6, tweet_id7, tweet_id8, tweet_id9, tweet_id10,
                         date, link, outlet, filepath, addedwhen, rssid, rsstopic)
  
  colnames(df)[15] <- "link" 
  
  dbWriteTable(us,"articles",df,append=T,row.names=F)
  
}