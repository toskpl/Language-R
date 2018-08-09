######################
###     ZAD1       ###
######################
?cars
View(cars)
Data = cars#przypisanie danych cars do zmiennej Data

plot(speed ~ dist, data = Data, pch =20,xlim = c (0, 360)) #wykres rozrzutu

#Hipoteza H0 - sa zalezne
#Hipoteza H1 - sa nie zalezne
cor.test(~ speed + dist, data = Data) # Significancy of Pearson's coeff czy speed jest zalezna od dist
#wartosc p-value = 1.49e-12 nie ma podstaw do odrzucenia hipotezy H0

#inne koleracje np spearman
cor.test(~ speed + dist, data = Data, conf.level = 0.90) # Significancy of Pearson's coeff poziom istotnosci 90%
cor.test(~ speed + dist, data = Data, method = 'spearman', exact=FALSE) # Significancy of Spearman's coeff

model.lm = lm(speed ~ dist, data = Data) # Regression regresja linowa
summary(model.lm) #podsumowanie modelu liniowego
#Pr(>|t|) = 1.49e-12 *** silna zaleznosc miedzy speed a dist
#Multiple R-squared:  0.6511 
#w modelu speed w 65 % zalezy od dist pozostale 35 % sa zalezna od innych czynnikow
#regresja liniowa w postaci f(speed) = 0.16557dist + 8.28391

abline(model.lm, lwd = 2, col = 'red')#narysowanie lini na wykresie

model2 = nlm(speed ~ dist + I(dist^2), data = Data) # Quadratic -  model kwadratowy
#lines(L.minor$conc, fitted(model.nlm))
curve(coef(model2)[1] + coef(model2)[2] * x + coef(model2)[3] * x^2, add = T, col = 'blue', lwd = 2)
summary(model2)
#Pr(>|t|) = 2.86e-07 *** silna zaleznosc miedzy speed a dist
#Multiple R-squared:  0.7101 
#w modelu speed w 71 % zalezy od dist pozostale 29 % sa zalezna od innych czynnikow
#model kwadratowy w postaci f(speed) = 0.3274544 dist - 0.0015284 dist^2

######################
###     ZAD2       ###
######################

Input = ('Price Rooms
         300 3
         250 3
         400 4
         550 5
         317 4
         389 3
         425 6
         289 3
         389 4
         559 5')
(Data = read.table(textConnection(Input), header = T))#dane
model1.lm = lm(Price ~ Rooms, data = Data) # model liniowy - gdzie cena zalezy od ilosci pokoi
summary(model1.lm) # podsumowanie modelu
#Pr(>|t|) = 0.0152 *  zaleznosc miedzy Price a Rooms
#Multiple R-squared:  0.5419
#regresja liniowa w postaci f(price) = 73.10 Rooms + 94.40
plot(Price ~ Rooms,Data, pch = 20,xlim = c(0, 6) , ylim = c(150,700)) #wykres rozrzutu
abline(model1.lm, lwd = 2, col = 'red') # prosta regresji
predict(model1.lm, list (Rooms=2))# wg modelu przewidywana cena dla 2 pokoi to 240,6
points(x=2, y = predict(model1.lm, list (Rooms = 2)) ,xlim = c(1, 6),ass = T, col = 'green', pch = 20, cex = 2,xlim = c(0:300)) #sprawdzenie na wykresie
cor.test(~ Price + Rooms, data = Data, conf.level = 0.05) # sprawdzenie koleracji przy poziomie istotnosci 5%
#p-value = 0.01521 jest zaleznosci


######################
###     ZAD3       ###
######################

library(UsingR)
?emissions
Data = emissions#dane
plot(GDP ~ CO2, data = Data, pch =20) #wykres rozrzutu
with(Data[1:1,], text(GDP~CO2, labels = row.names(Data[1:1,]),pos = 2))
model1.lm = lm(GDP ~ CO2, data = Data) # model liniowy
summary(model1.lm)# podsumowanie modelu
#Pr(>|t|) = 1.2e-13 *** *  zaleznosc GDP Price a CO2
#Multiple R-squared:  0.9028
#regresja liniowa w postaci f(GDP) = 1155.31 CO2 + 57082.67
abline(model1.lm, lwd = 2, col = 'red')
plot (model1.lm,which = 5,pch = 20)# pkt wyplywowe sa USA, a w nimiejszym stopniu Japan,Russian


Data2 = Data[-1,]#usuwamy pkt odstajacy USA z modelu
plot(GDP ~ CO2, data = Data2, pch =20) #wykres rozrzutu
with(Data2[1:1,], text(GDP~CO2, labels = row.names(Data2[1:1,]),pos = 2))
model2.lm = lm(GDP ~ CO2, data = Data2) # model liniowy
summary(model2.lm)# podsumowanie modelu
#Pr(>|t|) = 9.8e-05 *** *  zaleznosc GDP a CO2
#Multiple R-squared:  0.49
#regresja liniowa w postaci f(GDP) = 939.3 CO2 + 140052.6
abline(model2.lm, lwd = 2, col = 'red')
(MSE.model1 = mean(resid(model1.lm )^2))
(MSE.model2 = mean(resid(model2.lm )^2))
#model1 = 249257672856
#model2 = 244634276445
#model2 jest dokladniejszy po usunieciu pkt odstajacego (USA)

######################
###     ZAD4       ###
######################

library(UsingR)
?homeprice
Data = homeprice#dane
plot(sale ~ half, data = Data, pch =20) #wykres rozrzutu
model1.lm = lm(sale ~ half, data = Data)#model liniowy 
summary(model1.lm)#podsumowanie modelu
#Pr(>|t|) = 0.0344  *  zaleznosc sale a half 
#Multiple R-squared:  0.1554
#regresja liniowa w postaci f(sale) = 69.08 half + 228.27


model.lm = lm(sale ~ ., data = Data)
model.lm.final = step(model.lm)##automat 

######################
###     ZAD5       ###
######################

library(car)
library(nlrwr)

?USPop
Data = ?USPop
plot(year ~ population, USPop, pch =20) #wykres rozrzutu
model.nlm = nls(year ~ SSlogis(population, a, b,scal),data= USPop) # nieliniowy model 
summary(model.nlm)#podsumowanie modelu
lines(USPop$population, fitted(model.nlm),type="l")
model1.lm = lm(year ~ population,data= USPop) # liniowy model
abline(model1.lm, lwd = 2, col = 'red')


######################
###     ZAD6       ###
######################


Input = ('time speed
         1 10
         2 16.3
         3 23
         4 27.5
         5 31
         6 35.6
         7 39
         8 41.5
         9 42.9
         10 45
         11 46
         12 45.5
         13 46
         14 49
         15 50')
(Data = read.table(textConnection(Input), header = T))#dane
plot(Data, pch = 20,xlim = c (2, 20),ylim = c (10, 90))#wykres rozrzutu
model.nlm = nls(speed ~ SSmicmen(time, a, b), data = Data)#nieliniowy model
lines(Data$time, fitted(model.nlm),type="l")
#model1.nlm = nls(speed ~ a * time / (b + time),start= list (a = 2, b = 15 ),data = Data) # Nonlinear model 
#lines(Data$time, fitted(model1.nlm),type="l")
predict(model.nlm, list (time=17)) # wg modelu przewidywana predkosc w 17 sekundzie  to 51.84704
points(x=17, y = predict(model.nlm, list (time = 17)),
       ass = F , col = 'green', pch = 20, cex = 2) #sprawdzenie na wykresie


