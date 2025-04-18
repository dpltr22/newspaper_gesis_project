# Retrieve needed cookies from ZEIT (manually)
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

remDr$navigate("https://meine.zeit.de/anmelden?url=https%3A%2F%2Fwww.zeit.de%2Findex&entry_service=sonstige")

# Fill in Login Information
r <- remDr$findElement('xpath', '//*[@id="login_email"]')
r$highlightElement()
r$clearElement()
r$sendKeysToElement(list(""))

r <- remDr$findElement('xpath', '//*[@id="login_pass"]')
r$highlightElement()
r$clearElement()
r$sendKeysToElement(list(""))

r <- remDr$findElement('xpath', '//*[@type="submit"]')
r$clickElement()

# Accept Data Security Question
Sys.sleep(3)
r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@id="notice"]/button')
r$clickElement()
remDr$switchToFrame(NA)

remDr$navigate("www.zeit.de")
Sys.sleep(6)

cookies <- remDr$getAllCookies()
saveRDS(cookies, "./newspaper_rss/Zeit/cookies_zeit.rds")

remDr$close()
