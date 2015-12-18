# KNN-implementation

A matlab implementation for the **K-nearest neighbor algorithm (KNN)** with **K-fold cross validation**. This implementation was part of our coursework.

For calculating data accuracy. I've used 3 different formulas for nearest neighbor distance calculation and did the k-fold cross validation for each of them. 

1. Manhattan Distance
2. Chebychev Distance
3. Euclidean Distance

The KNN is implemented for K=5, K=10 and K=15 respectively.

You can simply run the program by importing the dataset given in **circular.txt** and passing it to the **KNN_crossvalidation** function. Using the following statements.

```
KNN_crossvalidation(importdata(path_to_circular.txt))
```
The **exercise sheet** is given for your ease to understand what we were required to accomplish and how. This is the implementation for the first two questions mentioned in **exercise.pdf**.

I've also uploaded the topic slides, if anyone is interested in understanding the topic.
