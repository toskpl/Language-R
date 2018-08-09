###################
###   zad 1     ###
###################

library(MASS)
painters
Data = painters#dane
group = factor(Data$School)#school jako etykieta
Data = Data[,-5]#usuwamy etykiete z danych
model.pca = prcomp(Data)#PCA wyznaczone za pomoca funkcji prcomp
summary(model.pca)#podsumownie modelu
#model.pca$rotation#maciez rotacji
#model.pca$x
#model.pca$sdev#Odchylenia standardowe nowych zmiennych
#sum(diag(var(Data)))
#print(model.pca)
#plot(model.pca) # Screeplot

plot(model.pca$x, pch = 20, col = group)
legend("topright", inset=c(-0.2,0),title="School",horiz=FALSE,legend = c('A', 'B','C','D','E','F','G','H'), pch = 20, col = c('black', 'red','blue','green','pink','orange','yellow','chartreuse2'),bty = 'n')


###################
###   zad 2     ###
###################
ibrary(MASS)
sum(is.na(Cars93))
dim(Cars93)
Cars93 = na.omit(Cars93)
dim(Cars93)
# pominiêcie 11 wierszy, w 2 przypadkach wiersz mia³ null'a w dwóch kolumnach

library(data.table)
data_dt = data.table(Cars93)
data_dt$Cylinders = as.numeric(data_dt$Cylinders)
data = data_dt[, list(Min.Price,Price,Max.Price,MPG.city,MPG.highway,Cylinders,EngineSize,Horsepower,RPM,Rev.per.mile,Fuel.tank.capacity,Passengers,Length,Wheelbase,Width,Turn.circle,Rear.seat.room,Luggage.room,Weight)]
# zbior zmienych wejœciowych
origin_g = factor(Cars93$Origin)
# grupowanie Origin pod wykres
type_g = factor(Cars93$Type)
# grupowanie Type pod wykres

boxplot(data); var(data)
# duze roznice - skalowanie

model.pca = prcomp(data, scale. = T)
summary(model.pca)
# zmienne wyjasniaja - pc1: 64%, pc2: 12%, pc3: 6% co daje 83%, poziom ok. 95% osiagniety przy pc8

par(mfrow = c(1, 1))
screeplot(model.pca, type = 'l')
round(cor(data, model.pca$x) ^ 2, 2)

par(mfrow = c(1, 2))
plot(model.pca$x, pch = 20, col = origin_g)
plot(model.pca$x, pch = 20, col = type_g)

library(ggbiplot)
ggbiplot(model.pca, groups = origin_g, ellipse = TRUE, circle = TRUE)
ggbiplot(model.pca, groups = type_g, ellipse = TRUE, circle = TRUE)

