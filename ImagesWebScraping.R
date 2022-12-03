# load libraries and packages
library("rvest")
library("ralger")
library("tidyverse")
library("jpeg")
library("here")

# set the number of pages
num_pages <- 5

# set working directory for photos to be stored
setwd("~/Desktop/lab/male_generic")

# create a list to hold the output
male <- vector("list", num_pages)

# saving the urls from istockphoto
num_pages <- 5
for(page_result in 1:num_pages){
  link = paste0("https://www.istockphoto.com/search/2/image?alloweduse=availableforalluses&mediatype=photography&phrase=man&page=", 
                page_result)
  male[[page_result]] <- images_preview(link)
}

male <- unlist(male)
male <- as.data.frame(male) # make it a data frame

# adding IDs to dataset
data <- tibble::rowid_to_column(male, "ID")
summary(data)

# drop first row
test <- data[-1,]

# identifying the problematic data
test <- subset(test,test$male!='/search/assets/static/color_mood_all-426fbeb2abd7da282b67.jpg' )

# downloading loop
for (i in 1:304) {
  myurl <- paste(test[i,2], sep = "")
  a <- tempfile()
  download.file(myurl,a,mode="wb")
  pic <- readJPEG(a)
  writeJPEG(pic, paste("image", i, ".jpg", sep = "")) 
}



