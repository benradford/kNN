# k-Nearest Neighbors

#### Benjamin Radford
#### Duke University

Two files are included:

* kNN.R: An implementation of the k-Nearest Neighbors algorithm in R.
* demos.R: Code for three examples of classification using kNN.R file.

After sourcing kNN.R, the algorithm can be run with a call to the function kNN.  It takes the following parameters:

* __train__: A set of training data in the form of a matrix or dataframe.
* __test__: A set of test data to be classified.  Number of columns in test must match the number of columns in __train__.
* __trainlabels__: A set of categories or labels for the observations in __train__.  Number of elements of  __trainlabels__ must match the number of rows (observations) in __train__.
* __k__: Number of closest neighbors on which to base inference.  Default is 1.
* __trainsample__: Number of samples to take from the training data.  Default (NULL) is to include full training set.  If a number __n__ is specified, a random sample of size __n__ will be selected from __train__.
* __l__: The l-norm to be applied in the distance metrix.  Default is 2 (standard euclidean distance).  l=3 commonly improves predictive accuracy.