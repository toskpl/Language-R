mtcars#dane
dim(mtcars)
data(mtcars)
library(vegan)
dis = vegdist(sqrt(mtcars), method = 'bray')#odleglosc bray
tree.average = hclust(dis, method = 'average')#metoda wiazan skupien
plot(tree.average, labels = F)
lab.average = cutree(tree.average, 3)#podzial drzewa na 3 czesci
plot(tree.average)#Dendorgram
plot(tree.average, hang = -1) 
rect.hclust(tree.average, k = 3, border = 3, cluster = lab.average) #z podzialem na 3 grupy skupien

###############################

dist.mtcars = dist(mtcars[,1:11]) #ED
cluster.mtcars = hclust(dist.mtcars, method = 'complete')
plot(cluster.mtcars, labels = F)
plot(cluster.mtcars, hang = -1)
cutree(cluster.mtcars, k = 3)
rect.hclust(cluster.mtcars, k = 3, border = 2)

###############################
###    K-means clustering   ###
###############################

model.kmeans = kmeans(mtcars[, 1:11], centers = 3, nstart = 100) # k srednich (100 random initializations; 3 groups)
model.kmeans$cluster # Clustering vector
model.kmeans$centers # pkt centrum w klastrze
model.kmeans$size # ilosc obserwacji w kazdej klasie

library(cluster) # for pam() command
model.pam = pam(mtcars[,1:11], k = 3) # Partitioning around medoids
model.pam$clustering # Clustering vector
clusplot(model.pam, color = T, main = 'PAM clustering') # Cluster plot (in PC space)
model.clara = clara(mtcars[,1:11], k = 3) # Clara method (for big data sets)
clusplot(model.clara, color = T, main = 'Clara clustering') # Cluster plot (in PC space)

##################################
### Clustering - # of clusters ###
##################################

library(vegan) # For cascadeKM() command
model.cascade <- cascadeKM(mtcars[,1:11], 2, 5)
model.cascade$results # CH indexe
plot(model.cascade)# CH = 2

# Silhouette index
library(cluster)
sil.index = silhouette(model.kmeans$cluster, dist = dist(mtcars[,1:11], method = 'euclidean'))
summary(sil.index) # mean s(i) for each cluster 3
plot(sil.index) # No narrow silhouettes - good clustering

# CH = 2
# wspolczynnik zarysu = 3 
# liczba skupien 2 lub 3
