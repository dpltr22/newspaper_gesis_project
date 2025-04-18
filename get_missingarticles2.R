# Load packages
library(RSelenium)
library(rvest)
library(XML)
library(xml2)
library(stringr)
library(RMySQL)

# Load crawlers

source("./newspaper_rss/source_crawlers.R")

# Load list of missing links

missing_links <- read.csv("./newspaper_rss/missing_links2.csv", encoding = "UTF-8")

missing_links <- missing_links[missing_links$downloaded == 0,]

# SQL Login

db_user <- 'root'
db_password <- 'gesisonline'
db_name <- 'newsfeed'
db_host <- "127.0.0.1" # root server access
db_port <- 3306
us <-  dbConnect(RMySQL::MySQL(), user = db_user, password = db_password,
                 dbname = db_name, host = db_host, port = db_port)

dbSendQuery(us, "ALTER DATABASE newsfeed CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")

# Setup RSelenium
remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

# Login to every newspaper -----------------------------------------------------------

# Focus -------------------------------------------------------------------

remDr$navigate("https://www.focus.de/")

# Now accept the Data Security Question
r <- remDr$findElements("xpath", '//*[@title="Iframe title"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@title="Akzeptieren"]')
r$clickElement()
remDr$switchToFrame(NA)



# NTV -----------------------------------------------------------------------------------------

remDr$navigate("https://www.n-tv.de/")

# Now accept the Data Security Question
r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@id="notice"]/div[3]/div[2]/button')
r$clickElement()
remDr$switchToFrame(NA)

# Spiegel ----------------------------------------------------------------------------------------------


# First navigate to start newspaper page
remDr$navigate("https://www.spiegel.de/")  
Sys.sleep(3)

# Add needed Cookies (For Login Information) 
cookies <- readRDS("./newspaper_rss/Spiegel/cookies_spiegel.rds")
for (i in 1:length(cookies)) {
  remDr$addCookie(name = cookies[[i]][["name"]], value = cookies[[i]][["value"]])
}


# RTL -------------------------------------------------------------------------------------------------

remDr$navigate("https://www.rtl.de/")

  # Now accept the Data Security Question
  r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
  remDr$switchToFrame(r[[1]])
  r <- remDr$findElement("xpath", '//*[@title="Alle akzeptieren"]')
  r$clickElement()
  remDr$switchToFrame(NA)


# Stern ---------------------------------------------------------------------    

remDr$navigate("https://www.stern.de/")  
  
r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@title="Zustimmen"]')
r$clickElement()
remDr$switchToFrame(NA)  
    
# WELT ---------------------------------------------------------------------------------------------------------

# Navigate to Login Page
remDr$navigate("https://secure.mypass.de/sso/web/login?service=https%3A%2F%2Fwww.welt.de%2F&adobe_mc=MCMID%3D75785874272663100190786876232205117899%7CMCORGID%3DB21B678254F601E20A4C98A5%2540AdobeOrg%7CTS%3D1627283490")

# Fill in the Login Form

r <- remDr$findElement("xpath", "//*[@name='username']")
r$sendKeysToElement(list("oschatz@uni-landau.de"))

r <- remDr$findElement("xpath", "//*[@name='password']")
r$sendKeysToElement(list("medeci2021"))

r <- remDr$findElement("xpath", "//*[@type='submit']")
r$clickElement()

# Now accept the Data Security Question
r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@id="notice"]/div[3]/div[2]/button')
r$clickElement()
remDr$switchToFrame(NA)



# Now we start to crawl the articles ------------------------------------

for(a in 1:450){
  addedwhen <- Sys.time()
  
  if(missing_links$rsstopic[a] == "ARD_Ausland"){
    get_ardausland(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "ARD_Inland") {
    get_ardinland(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "Focus_Ausland") {
    get_focusausland(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "Focus_Politik") {
    get_focuspolitik(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "Spiegel_Schlagzeilen") {
    get_spiegelschlagzeilen(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "Spiegel_Politik") {
    get_spiegelpolitik(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "WELT_News") {
    get_weltnews(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "WELT_Politik") {
    get_weltpolitik(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "NTV_Standard") {
    get_ntv(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "Stern_News") {
    get_sternnews(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "Stern_Politik") {
    get_sternpolitik(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "RTL_News") {
    get_rtlnews(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "RTL_PolitikAusland") {
    get_rtlpolitikausland(missing_links$links[a])
  } else if(missing_links$rsstopic[a] == "RTL_PolitikInland") {
    get_rtlpolitikinland(missing_links$links[a])    
  } else {
    get_zdf(missing_links$links[a])
  }
  
  missing_links$downloaded[a] <- 1
  write.csv(missing_links, file = "./newspaper_rss/missing_links2.csv", row.names = FALSE)
}    

remDr$deleteAllCookies()
remDr$close()          
