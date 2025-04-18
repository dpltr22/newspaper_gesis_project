# Retrieve links from RSS-Feed
library(RSelenium)
library(rvest)
library(XML)
library(xml2)
library(stringr)
library(RMySQL)

load(file = "./safety_sql_51221.Rdata")

# Read in Articles from BILD RSS_NEWS Feed

links_all <- c()

all_files <- list.files(path = "./Bild/RSS_NEWS")

all_date <- gsub(".*rssnews_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
rss <- read_xml(paste0("./Bild/RSS_NEWS/",all_files[r]))
links_xml <- xml_nodes(rss, "link")

links <- xml_text(links_xml)
links <- links[-c(1:2)]

links <- cbind.data.frame(links, all_date[r])
links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from BILD RSS_POLITIK Feed

all_files <- list.files(path = "./Bild/RSS_POLITIK")

all_date <- gsub(".*rssnews_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Bild/RSS_POLITIK/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from FAZ RSS_FEEDS

all_files <- list.files(path = "./FAZ/RSS_FEEDS")

all_date <- gsub(".*rss_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./FAZ/RSS_FEEDS/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from Sueddeutsche RSS_FEEDS

all_files <- list.files(path = "./Sueddeutsche/RSS_FEEDS")

all_date <- gsub(".*rss_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Sueddeutsche/RSS_FEEDS/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from Welt RSS_NEWS

all_files <- list.files(path = "./Welt/RSS_NEWS")

all_date <- gsub(".*rssnews_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Welt/RSS_NEWS/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from Welt RSS_POLITIK

all_files <- list.files(path = "./Welt/RSS_POLITIK")

all_date <- gsub(".*rsspolitik_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Welt/RSS_POLITIK/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from Zeit RSS_FEEDS

all_files <- list.files(path = "./Zeit/RSS_FEEDS")

all_date <- gsub(".*rss_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Zeit/RSS_FEEDS/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
}

# Read in Articles from Spiegel RSS_FEEDS

all_files <- list.files(path = "./Spiegel/RSS_POLITIK")

all_date <- gsub(".*rsspolitik_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Spiegel/RSS_POLITIK/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
} 

# Read in Articles from Spiegel RSS_FEEDS

all_files <- list.files(path = "./Spiegel/RSS_SCHLAGZEILEN")

all_date <- gsub(".*rssschlagz_", "", all_files)
all_date <- gsub(".txt", "", all_date)

all_date <- as.POSIXct(all_date, format = "%Y-%m-%d_%H_%M_%S")

for(r in 1:length(all_files)){
  rss <- read_xml(paste0("./Spiegel/RSS_SCHLAGZEILEN/",all_files[r]))
  links_xml <- xml_nodes(rss, "link")
  
  links <- xml_text(links_xml)
  links <- links[-c(1:2)]
  
  links <- cbind.data.frame(links, all_date[r])
  links_all <- rbind.data.frame(links_all, links)
} 

# Remove Feeds outside of timeperiod
colnames(links_all)[2] <- "datetime"

links_all$date <- format(links_all$datetime, format = "%Y-%m-%d")

links_all <- subset(links_all, links_all$date > "2021-08-18" & links_all$date < "2021-12-01")

missing_links <- links_all[!links_all$links %in% articles$link, ]

missing_welt <- articles[which(articles$outlet == "WELT" &
                               articles$text == " "),]

missing_welt <- missing_welt[c(15,18)]
colnames(missing_welt)[1] <- "links"
colnames(missing_welt)[2] <- "datetime"
missing_welt$datetime <- as.POSIXct(missing_welt$datetime, format = "%Y-%m-%d %H:%M:%S")
missing_welt$date <- format(missing_welt$datetime, format = "%Y-%m-%d")

missing_links <- rbind(missing_links, missing_welt)

missing_links <- missing_links[!duplicated(missing_links$links),]

set.seed(100)
rows <- sample(nrow(missing_links))
missing_links <- missing_links[rows,]

# Save missing_links file

write.csv(missing_links, file = "./missing_links.csv", row.names = FALSE)

