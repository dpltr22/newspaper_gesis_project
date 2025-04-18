# Retrieve needed cookies from FAZ
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

remDr$navigate("https://www.faz.net/aktuell/")

r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@title="EINVERSTANDEN"]')
r$clickElement()

remDr$switchToFrame(NA)

# Begin Login Process
r <- remDr$findElement("xpath", '//*[@id="TOP"]/header/nav/div/div[6]/button[1]')
r$clickElement()
Sys.sleep(3)

r <- remDr$findElements("xpath", '//*[@class="lay-Login_Iframe"]')
remDr$switchToFrame(r[[1]])

r <- remDr$findElement("xpath", '//*[@name="loginName"]')
r$sendKeysToElement(list(""))

r <- remDr$findElement("xpath", "//*[@name='password']")
r$sendKeysToElement(list(""))

r <- remDr$findElement("xpath", "//*[@class='btn-Base_Text']")
r$clickElement()
Sys.sleep(15)

cookies <- remDr$getAllCookies()
saveRDS(cookies, "./newspaper_rss/FAZ/cookies_faz.rds")

remDr$close()
