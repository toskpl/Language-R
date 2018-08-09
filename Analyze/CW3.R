library(mlbench)
?Vehicle
data(Vehicle)#dane
dim(Vehicle)#obserwacje + cechy
temp = Vehicle 

###########################
###        LDA          ###        
###########################
library(MASS)
temp = Vehicle

lda_model = (model.lda = lda(Class ~ ., temp)) 
classification.lda = predict(lda_model,temp)
lda(Class ~ ., temp, prior = c(1,1,1,1) / 4)
classification.lda$class != temp$Class

(contingency.table.lda = table(classification.lda$class, temp$Class))
table(temp$Class) # 4 klasy

print(sum(classification.lda$class != temp$Class) / nrow(temp) * 100, 3) # Error rate (resubstitution) in %
print((1 - sum(diag(contingency.table.lda) / sum(contingency.table.lda))) * 100, 3) # As above from contingency.table
mean(classification.lda$class != temp$Class)


###########################
###        QDA          ###        
###########################
qda_model = qda(Class ~ ., data = temp)
classification.qda = predict(qda_model,temp)
qda(Class ~ ., temp, prior = c(1,1,1,1) / 4)
classification.qda$class != temp$Class

(contingency.table.qda = table(classification.qda$class, temp$Class))
table(temp$Class) # 4 klasy

print(sum(classification.qda$class != temp$Class) / nrow(temp) * 100, 3) # Error rate (resubstitution) in %
print((1 - sum(diag(contingency.table.qda) / sum(contingency.table.qda))) * 100, 3) # As above from contingency.table
mean(classification.qda$class != temp$Class)

###########################
###        KNN          ###        
###########################

library(class)


knn(temp [,2:18], temp [,2:18], cl = temp$Class, k = 1) # 1NN prediction zbior uczacy  zbior testowy cl to zbior etykiel k liczba sasiadow 
knn(temp [,2:18], temp [,2:18], cl = temp$Class, k = 3) # 3NN prediction zbior uczacy  zbior testowy cl to zbior etykiel k liczba sasiadow 
model.1NN = knn(temp [,2:18], temp [,2:18], cl = temp$Class, k = 1, prob = T) # Model 1NN with posterior probabilities
model.3NN = knn(temp [,2:18], temp [,2:18], cl = temp$Class, k = 3, prob = T) # Model 3NN with posterior probabilities

attr(model.1NN, 'prob') # Posterior probabilities
attr(model.3NN, 'prob') # Posterior probabilities
100- 100 * sum(model.1NN != temp$Class) / nrow(temp) # 1NN resubs. error rate wyznacznie bledow sum(model.1NN != data$class) ile bldow = 0
100- 100 * sum(model.3NN != temp$Class) / nrow(temp) # 3NN resubs. error rate wyznacznie bledow sum(model.3NN != data$class) ile bldow = 0


table(model.1NN, temp$Class)
table(model.3NN, temp$Class)

mean(model.1NN != temp$Class)
mean(model.3NN != temp$Class)

###########################
###     Naive Bayes     ###        
###########################
library(klaR) # For NaiveBayes() command
model.nb.normal = NaiveBayes(Class ~ ., data = Vehicle) # For normal densities
(classification.nb.normal = table(predict(model.nb.normal, Vehicle)$class, Vehicle$Class))
model.nb.kernel = NaiveBayes(Class ~ ., data = Vehicle, usekernel = T) # For kernel densities #usekernel jadrowy rozklad
(classification.nb.kernel = table(predict(model.nb.kernel, Vehicle)$class, Vehicle$Class))
1 - sum(diag(classification.nb.normal)) / nrow(Vehicle) # 52%
1 - sum(diag(classification.nb.kernel)) / nrow(Vehicle) # 34%

###########################
### LDA         20,2%   ###
### QDA          8,3%   ###
### 3NN         19,2%   ###
### Naive Bayes 52,7%   ###
###########################