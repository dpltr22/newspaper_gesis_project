# Retrieve needed cookies from Spiegel (manually)
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

remDr$navigate("https://gruppenkonto.spiegel.de/anmelden.html?targetUrl=https%3A%2F%2Fwww.spiegel.de%2Ffuermich%2F&requestAccessToken=true")

r <- remDr$findElement("xpath", "//*[@name='loginform:loginname']")
r$sendKeysToElement(list(""))

r <- remDr$findElement("xpath", "//*[@name='loginform:password']")
r$sendKeysToElement(list(""))

r <- remDr$findElement("xpath", "//*[@name='loginform:submit']")
r$clickElement()

remDr$navigate("https://www.spiegel.de")
Sys.sleep(2)

cookies <- remDr$getAllCookies()
saveRDS(cookies, "./newspaper_rss/Spiegel/cookies_spiegel.rds")

remDr$close()
