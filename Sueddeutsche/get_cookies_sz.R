# Retrieve needed cookies from Sueddeutsche (manually)
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

remDr$navigate("https://www.sueddeutsche.de/")

# Accept Data Security Question
Sys.sleep(3)
r <- remDr$findElements("xpath", '//*[@title="Iframe title"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@title="Akzeptieren"]')
r$clickElement()
remDr$switchToFrame(NA)

# Navigate to Login Page
r <- remDr$findElement("xpath", '//*[@class="custom-77z642"]')
r$clickElement()
Sys.sleep(6)

# Fill in Login Information
r <- remDr$findElement('xpath', '//*[@id="login_login-form"]')
r$highlightElement()
r$clearElement()
r$sendKeysToElement(list(""))

r <- remDr$findElement('xpath', '//*[@id="password_login-form"]')
r$highlightElement()
r$clearElement()
r$sendKeysToElement(list(""))

r <- remDr$findElement('xpath', '//*[@id="authentication-button"]')
r$clickElement()

Sys.sleep(6)
cookies <- remDr$getAllCookies()
saveRDS(cookies, "./newspaper_rss/Sueddeutsche/cookies_sz.rds")

remDr$close()
