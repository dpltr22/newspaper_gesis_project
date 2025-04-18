# Retrieve needed cookies from BILD
library(RSelenium)

remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

# Navigate to Login Page to log ourselves in

remDr$navigate("https://secure.mypass.de/sso/web-bigp/login?service=https%3A%2F%2Fdon.bild.de%2Fwww%2Fli%2Fhttps%25253A%25252F%25252Fwww.bild.de%25252Fcorporate-site%25252Frss-infoseite%25252Fbild-service%25252Frss-3257128.bild.html&security=low#remId=1705695055080985663")

r <- remDr$findElement("xpath", "//*[@name='username']")
r$sendKeysToElement(list(""))

r <- remDr$findElement("xpath", "//*[@name='password']")
r$sendKeysToElement(list(""))

r <- remDr$findElement('xpath','//*[@id="login-form-submit"]/span')
r$clickElement()

remDr$navigate("https://www.bild.de")

# Accept Data Security Question

r <- remDr$findElements("xpath", '//*[@title="SP Consent Message"]')
remDr$switchToFrame(r[[1]])
r <- remDr$findElement("xpath", '//*[@id="notice"]/div[3]/div[2]/button')
r$clickElement()
remDr$switchToFrame(NA)

Sys.sleep(2)
cookies <- remDr$getAllCookies()
saveRDS(cookies, "./newspaper_rss/Bild/cookies_bild.rds")

remDr$close()
