# Title:    k-Nearest Neighbors
# Author:   Benjamin Radford
#           Duke University
# Date:     March 3, 2014
# GitHub:   http://www.github.com/benradford
# Website:  http://www.benradford.com

guess.knn <- function(x, train, trainlabels, k, l)
{
  xmatrix <- matrix(as.numeric(x), nrow=nrow(train), ncol=length(x), byrow=T)
  xmatrix <- (abs(as.matrix(train)-xmatrix))^l
  diffs <- (rowSums(xmatrix))^(1/l)
  
  diffs <- data.frame(dist=diffs,label=trainlabels)
  diffs <- (diffs[order(diffs$dist),])
  diffs <- diffs[1:k,]

  guess <- names(sort(-table(diffs$label)))[1]

  return(guess)
}

knn <- function(train, test, trainlabels, k=1, trainsample=NULL, l=2)
{
  if(ncol(train)!=ncol(test))
    stop("Training and test set must contain equal number of features.")
  if(length(trainlabels)!=nrow(train))
    stop("Training labels must be of same length as training set.")
  
  if(is.null(trainsample))
    trainsample <- nrow(train)
  
  subsample <- sample(1:nrow(train), trainsample, replace=F)
  
  train <- train[subsample,]
  trainlabels <- trainlabels[subsample]
  
  results <- apply(test, 1, function(x) guess.knn(x, train, trainlabels, k, l))
  
  return(results)
}

