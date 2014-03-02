# Title:    k-Nearest Neighbors (Demos)
# Author:   Benjamin Radford
#           Duke University
# Date:     March 3, 2014
# GitHub:   http://www.github.com/benradford
# Website:  http://www.benradford.com


# Source the k-Nearest Neighbors functions
source("kNN.R")


##################
# Colors Example #
##################

# Randomly create 1000 colors (dataframe with three columns for red, green, blue)
colors <- data.frame(matrix(round(runif(3000,0,255)), nrow=1000, ncol=3))
names(colors) <- c("red","green","blue")

# Create a fourth column of hex colors for plotting
colors$composite <- paste("#",
                          as.character(as.hexmode(colors$red)),
                          as.character(as.hexmode(colors$green)),
                          as.character(as.hexmode(colors$blue)),
                          sep="")

# Plot the random colors
plot(0, 0, type="n", xlim=c(1,1000), ylim=c(0,1), xlab="Random Colors", ylab="", yaxt="n", frame=F)
rect(0:999,rep(0,1000),1:1000,rep(1,1000), col=colors$composite, border=NA)

# Create a training set of red, green, and blue for categorization
# You can change these to get different or more categories
traincolors <- data.frame(rbind(c(255,0,0),c(0,255,0),c(0,0,255)))
trainlabels <- c("red","green","blue")

# Run the kNN algorithm on the data
colorresults <- knn(traincolors, colors[,1:3], trainlabels, k=1)

# Sort the dataframe by category
colors <- colors[order(colorresults),]

# Plot the results (ordered by predicted category)
plot(0, 0, type="n", xlim=c(1,1000), ylim=c(0,1), xlab="Sorted Colors", ylab="", yaxt="n", frame=F)
rect(0:999,rep(0,1000),1:1000,rep(1,1000), col=colors$composite, border=NA)

# Uncomment and run this to clean the workspace:
# rm(list=c("colors", "test", "train", "traincolors", "colorresults", "trainlabels"))


#################################
# Character Recognition Example #
#################################

# Load the data from web (this may take several minutes)
data <- read.csv("http://www.pjreddie.com/media/files/mnist_train.csv", header=TRUE, stringsAsFactors=F)

# Create training and test samples
sample1 <- sample(1:nrow(data), 100, replace=F)
sample2 <- setdiff(1:nrow(data), sample1)
test <- data[sample1,]
train <- data[sample2,]

# Run the kNN algorithm
testresults <- knn(train[,-1], test[,-1], trainlabels=train[,1], k=1)

# Assess and report accuracy of kNN predictions
accuracy <- mean(testresults==test[,1])
print(accuracy)

# Uncomment and run this to clean the workspace:
# rm(list=c("data","test","train","accuracy","sample1","sample2","testresults"))


###############################
# News Classification Example #
###############################

# This example requires the package spam to read data from BBC Insights
library(spam)

# Load the data from BBC (this may take several minutes)
temp <- tempfile()
download.file("http://mlg.ucd.ie/files/datasets/bbc.zip",temp)
bbc <- read.MM(unz(temp,"bbc.mtx"))
bbc <- t(as.matrix(bbc))
terms <- read.csv(unz(temp,"bbc.terms"), header=F, stringsAsFactors=F)
docs <- read.csv(unz(temp,"bbc.docs"), header=F, stringsAsFactors=F)
classes <- unlist(strsplit(docs[,1],"\\."))[seq(1,2*nrow(docs)-1,by=2)]
unlink(temp)

# Set up a vector to store results
hitormiss <- NULL

# This loop classifies all articles
# This will take several minutes to hours to complete
for(i in 1:nrow(bbc))
{
  test <- t(matrix(bbc[i,]))
  train <- bbc[-i,]
  classtrain <- classes[-i]
  classtest <- classes[i]
  results <- knn(train, test, classtrain, k=1, l=3)
  hitormiss <- append(hitormiss, results==classtest)
  cat("\r",mean(hitormiss))
}

# Print final results:
print(paste("Final proportion of correct classifications: "mean(hitormiss), sep=""))