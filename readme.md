# k-Nearest Neighbors
Benjamin Radford 
Duke University

---------

Documentation for this code is found at: [http://www.benradford.com/simple-machine-learning-and-examples](http://www.benradford.com/simple-machine-learning-and-examples).  This includes and explanation of k-NN algorithm and descriptions of the examples included in __demos.R__ file.

## Contents:

* __kNN.R__: An implementation of the k-Nearest Neighbors algorithm in R.
* __demos.R__: Code for three examples of classification using kNN.R file.

## kNN function:

kNN(train, test, trainlabels, k=1, trainsample=NULL, l=2)

* __train__: A set of training data in the form of a matrix or dataframe.
* __test__: A set of test data to be classified.  Number of columns in test must match the number of columns in _train_.
* __trainlabels__: A set of categories or labels for the observations in _train_.  Number of elements of  _trainlabels_ must match the number of rows (observations) in _train_.
* __k__: Number of closest neighbors on which to base inference.  Default is 1.
* __trainsample__: Number of samples to take from the training data.  Default (NULL) is to include full training set.  If a number _n_ is specified, a random sample of size _n_ will be selected from _train_.
* __l__: The l-norm to be applied in the distance metrix.  Default is 2 (standard euclidean distance).  l=3 commonly improves predictive accuracy.

## Example usage:

```r
kNN(trainingdata, testdata, traininglabels, k=1, trainsample=NULL, l=2)
```