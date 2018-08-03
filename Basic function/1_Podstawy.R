###################################################
### Dodatkowe materia³y
###################################################
# ?ls


###################################################
### Korzystanie z pomocy
###################################################

?mean # albo F1 na nazwie
??mean

?`?`
?`??`


###################################################
### Operatory i sta³e
###################################################

?`+` # pomoc do tematu


1+1 
2-1; 3-3 
2*2
2/2
5%%2 #reszta z dzielenia
5%/%2 #czêœæ ca³kowita
2^3; 2**3 #potêgowanie na dwa sposoby

1/0; Inf  #nieskoñczonoœæ pozytywna
-1/0; 1/-0; -Inf  #nieskoñczonoœæ negatywna
0/0 #NaN
Inf / -Inf #NaN
NaN

2<3; 2<2
2<=3; 2<=2
3>2; 2>2
3>=2; 2>=2
3==2; 2==2
3!=2; 2!=2
!TRUE #negacja
TRUE&TRUE; TRUE&FALSE #logiczne AND
TRUE|TRUE; TRUE|FALSE #logiczne OR
bitwAnd(5, 4) #101 AND 100 = 100
bitwOr(5, 4)  #101 OR  100 = 101
bitwXor(5, 4) #101 XOR 100 = 001


###################################################
### Obs³uga pakietów
###################################################

install.packages("readr") # instalacja


library(readr) # wczytywanie pakietu
library(readrxxx) # sypie b³êdem, je¿eli pakietu nie ma

require(readr) # te¿ wczytywanie, ale b³êdem nie sypie
require(readrxxx) # wyœwietla jedynie komunikat
(require(readr)) # zwraca TRUE je¿eli pakiet jest
(require(readrxxx)) # zwraca FALSE je¿eli pakietu nie ma


###################################################
### Czyszczenie pamiêci
###################################################
x = "xxxx"

rm(x) #usuwanie zmiennej

gc() #oczyszczenie pamiêci zajmowanej przez usuniête zmienne
#tak¿e odpalane automatycznie co jakiœ czas
#lub jak brakuje pamiêci
#zwraca statystyki zu¿ycia pamiêci



###################################################
### Zmienne i przypisywanie
###################################################

?`<-` # pomoc do tematu

x = 1
x

x <- 4
x

5 -> x
x

x = 2 < 3
x
(x = 2 < 3)

x = y = 2
x; y

Y = 3
y; Y #wielkoœæ znaków ma znaczenie


###################################################
### Nazewnictwo zmiennych
###################################################
varname1
var_name2
var.name3 # niezalecane, mo¿e mieæ 
          # konflikty z mechanizmami R


###################################################
### Typy danych
###################################################

?typeof  # pomoc do tematu
?class


#numeric
x = 1
x
typeof(x) # format danych
class(x) #jak powinny byæ interpretowane

x = c(1,2,3) # skalar w R te¿ jest wektorem, ale zawieraj¹cym tylko jeden element
x
typeof(x)
class(x)
is.numeric(x)

#character
x = "Krzychu"
x
typeof(x)
class(x)
is.character(x)

#sklejanie
x = paste0("a","b","c") #nie wstawia separatora
x

x = paste(c("a","b","c"), 1:3, c(T, F, T))
x

x = paste(c("a","b","c"), 1:3, sep = "_")
x


#factor
x = factor(c("kot", "kot", "pies", "kot"))
x
typeof(x) # integer, czyli liczbowy
class(x) # ale ma byæ interpretowany jako jedna ze zdefiniowanych wartoœci
levels(x) # lista ró¿nych wartoœci
as.numeric(x)


x = factor(c("kot", "kot", "pies", "kot"), levels = c("pies","kot"), ordered = T)
as.numeric(x)


#matrix
x = matrix(c(1,2,3,4), nrow = 2, ncol = 2)
x
typeof(x)
class(x) # 

dim(x)

x
x[2,] # wiersz
x[,2] # kolumna
x[2,2] #konkretny element
t(x) #transpozycja

x * 2
x * x # mno¿enie skalarne
x %*% x # mno¿enie macierzowe


#array
x = array(1:8, c(2,2,2)) # macierz o liczbie wymiarów > 2
x
typeof(x)
class(x)

x
x[,1,] # wybieramy elementy, które na 1-szym i 3-cim wymiarze maj¹ dowoln¹ pozycjê, a na drugim pozycjê 1


#list
x = list(a = 1, b = 2, c = "s") # zbiór nazwanych wartoœci
x
typeof(x)
class(x)


x = list(a = 1, b = 2, c = list(d = 3, e = 4)) # mo¿e zawieraæ listy

x
x$a
x[2] # drugi element, wynik jest list¹ z jednym elementem
x[[2]] # wartoœæ drugiego elementu
x["a"]
x[["a"]]
x[c("a", "b")]

x$c
x$d # nie ma, bo d nie jest elementem x...
x$c$d # ... a x$c

#data.frame
x = data.frame(
  a = c(1,2),
  b = c("a","b"),
  c = c(T,F),
  d = factor(c("A","B")),
  stringsAsFactors = F # bo domyœlnie stringi zamieniane s¹ na factory
)
x
typeof(x) # bo technicznie jest list¹ wektorów o tej samej d³ugoœci
class(x)

x[1] #kolumna jako data.frame (tak na prawdê, to pierwszy element listy)
x[,1] #kolumna jako wektor
x[,"a"] #albo tak
x$a #albo tak
x[[1]] #tak te¿, no bo lista
x[1,] #wiersz (data.frame)

x["b"]
x[c("b","c")]

x[1,"c"]

colnames(x)
rownames(x)
rownames(x) = c("Mietek", "Zdzisiek")
x
x["Mietek","d"]

#dodawanie wiersza
x = rbind(x, "Stasiu" = data.frame(a = 3, b = "c", c = F, d = "C"))
x
x = rbind(x, "Kalasanty" = list(a = 4, b = "d", c = T, d = "D")) # nie poszerza listy poziomów factora
x
x = rbind(x, "Hilary" = list(a = 5, b = "c", c = F, d = "C")) 
x


#dodawanie kolumny
x = cbind(x, e = c(10, 20, 30, 40, 50)) # mo¿emy dokleiæ wektor jako kolumnê
x
x = cbind(x, data.frame(f = c(2, 3, 5, 8, 13))) # mo¿emy te¿ skleiæ dwa data.framy
x

###################################################
### Wektory
###################################################

x = c(1,2,3) # wyliczamy elementy
x
x = c(1, c(2,3)) #tak na prawdê to c() skleja wektory
x

x = 1:5 # kolejne liczby od 1 do 5
x

x = 5:1 # kolejne liczby od 5 do 1
x

x = seq(1, 9, 2) # liczby od 1 do 9 z krokiem co 2
x = seq(from = 1, to = 9, by = 2) # to samo, ale z nazwami atrybutów
x

x = rep(1:3, 2)
x

x = rep(1:3, each = 2)
x

x = 1:5
x
x * 2
x + 2
x + 1:3 # ró¿na d³ugoœæ
x + 2:6

1:6 + 1:3
# 1 2 3 4 5 6
# 1 2 3 1 2 3
# ===========
# 2 4 6 5 7 9


4 %in% 1:5
6 %in% 1:5
1:2 %in% 1:5
all(1:2 %in% 1:5) # prawda, je¿eli wszystkie to prawda
1:2 %in% 2:5
all(1:2 %in% 2:5)

###################################################
### Zadanie WEK1
###################################################

### Utwórz wektor postaci:
### a) 1, 2, 3, ..., 99, 100, 99, ..., 3, 2, 1
x = (1:100,99:1)
x
### b) 1, 2, 3, 1, 2, 3, ...   (10 powtórzeñ)
x = rep(1:3,  each = 10)
x
### c) 1, 1, 1, ... , 3, 3, 3, ...   (10 x 1, 10 x 3)
x = rep(1:3,  each = 10)
x
### d) 1, 2, 2, 3, 3, 3, ..., 100, 100, 100, 100
x= rep(1:100, times = 1:100)
x
###    (1 x 1, 2 x 2, 3 x 3, ..., 99 x 99, 100 x 100)
### e) 1, 4, 7, 10, ..., 100
### f) 1, 4, 9, 16, ..., 81, 100
### g) a1, b10, c100, d1000, ..., j1000000000 (9 zer)

letters # wektor z kolejnymi literami alfabetu
as.integer(2e+8) # zamienia z numeric na integer
                 # to m.in. wymusza notacjê zwyk³¹
                 # zamiast wyk³adniczej


###################################################
### Wywo³ywanie funkcji
### name(args)
### name(arg_name = value)
### name(arg1, arg2, argX_name = argX_value)
###################################################

log(1) #logarytm
exp(1) #e do potêgi...
log2(2) #log o podstawie 2
log(4, 2) #logarytm o wybranej podstawie 
pi #liczba pi
choose(6,2) #dwumian Newtona: 6!/(2!*(6-2)!), liczba mo¿liwych ró¿nych par spoœród szeœciu elementów
sqrt(4)
ceiling(4.2)
floor(4.6)
trunc(3.99)
trunc(-3.99)
round(6.492)
round(6.492, 1)
signif(123456, 3)
factorial(5) #silnia

# sprawdzanie, które elementy ci¹gu zawieraj¹ podany wzorzec
grep("woda", c("ziemia woda ziemia","ziemia","woda"))
grep("^woda$", c("ziemia woda ziemia","ziemia","woda")) 
grep("w.*", c("ziemia woda ziemia","ziemia","woda"))

x = data.frame(
  a = c(1,2,2,2,3),
  b = c("a","b","c","d","e"),
  c = c(T,F,T,NA,T),
  d = factor(c("A","B","B","B","B")),
  stringsAsFactors = F
)
summary(x)

x = seq(from = -4, to = 4, by = 0.1)
y = dnorm(x)
plot(x, y)
plot(x, y, type = "l", xlab = "Oœ X", ylab = "Oœ Y")



###################################################
### Tworzenie funkcji
### name <- function(args){
###   ... body ...
### }
###################################################


avg <- function(data){
  s = sum(data)
  l = length(data)
  return(s/l) # je¿eli nie ma return(...), zwracany jest wynik ostatniego wywo³ania
}

avg(1:5)


avg = function(data){
  s = sum(data)
  l = length(data)
  s/l
}

avg(1:5)

###################################################
### If, else oraz ifelse
###################################################

if (2 < 3) { # je¿eli spe³nione wykonaj ten kod
  print("prawda")
}

if (2 < 3) print("prawda") # klamry nie s¹ obowi¹zkowe
                           # ale bez nich tylko jedna
                           # instrukcja jest warunkowana


if (2 > 3) { # je¿eli spe³nione wykonaj ten kod
  print("prawda")
}


if (2 > 3) {
  print("prawda")
} else { # w innym przypadku wykonaj ten kod
  print("fa³sz")
}

x = c(1,2,3,4)

ifelse(x>2, "wiêksze", "nie wiêksze")


x = data.frame(
  a = c(1,2,3,4),
  b = c("B1","B2","B3","B4"),
  c = c("C1","C2","C3","C4"),
  d = c("D1","D2","D3","D4"),
  stringsAsFactors = F
)

# dodaje kolumnê e, która:
# w nieparzystych wierszach zawiera element z kolumny b,
# a w parzystych element z kolumny c
x$e = ifelse((x$a %% 2) == 1, x$b, x$c)
x


###################################################

### Funkcja fibonacci(n), zwracaj¹c¹ n-ty
### element ci¹gu fibonacciego, w oparciu
### podejœcie rekurencyjne.
###
### - dla n == 0 wartoœæ wynosi 0
### - dla n == 1 wartoœæ wynosi 1
### - dane wejsciowe s¹ prawid³owe

fibo <- function(n){
  if (n == 0) 
  {
    return(0)
  }
  else if (n == 1)
  {
    return(n)
  }
  else
  {
  return(fibo (n-2) + fibo(n-1))
  }
  
}
fibo(7)


###################################################
### Rodzina funckji _apply()
###################################################
?vapply
?rapply

x = 1:9
x # wektor

x2 = lapply(x, identity)
names(x2) = letters[x]
x2 # lista niezagnie¿d¿ona

x3 = x2
x3$sub = lapply(x2, '*', 10)
x3 # lista zagnie¿d¿ona


# lapply - wynik jest list¹
lapply(x, sqrt) 
lapply(x2, sqrt)
lapply(x3, sqrt) # b³¹d, bo jeden z elementów listy nie jest poprawnym argumentem


# sapply - wynik jest wektorem lub macierz¹
sapply(x, sqrt) 
sapply(x2, sqrt)
sapply(x3, sqrt)


# rapply - _apply, ale przechodzi w kolejne poziomy zag³êbienia listy
rapply(x3, sqrt)
rapply(x3, sqrt, how = 'unlist') # domyœlny, zmienia dodatkowo rekurencyjnie listê na wektor
rapply(x3, sqrt, how = 'list') # pozostawiê strukturê jaka jest

x4 = x3
x4$z = 'a' # dodajmy element nie bêd¹cy ani liczb¹, ani list¹
x4

rapply(x4, sqrt, how = 'list') # b³¹d, bo jeden z elementów nie jest liczb¹, a pierwiastek ma sens tylko dla liczb
rapply(x4, sqrt, how = 'list', classes = c('numeric','integer')) # b³¹d, bo jeden z elementów nie jest liczb¹
rapply(x4, sqrt, how = 'replace', classes = c('numeric','integer')) # replace - te które s¹ innego typu pozostaw bez zmian


# vapply - wynik jest formatu podanego jak trzeci argument
vapply(x, sqrt, 1) # tu chcemy aby wynik by³ numeryczny
vapply(x, sqrt, 'a') # a tu ¿eby by³ ci¹giem znaków, wiêc siê sypie, bo jest liczb¹
vapply(x, as.character, 'a') # a tu dzia³a, bo jest ci¹giem znaków
vapply(x, function(a) as.character(sqrt(a)), 'a') # i tu te¿
vapply(x2, sqrt, 1)


###################################################
### Zadanie APPLY1
###################################################

### a) nieparzyste elementy poni¿szej listy podwój, a parzyste podziel przez 2

x1 = as.list(1:10)
x1


zad_a <- function(x1){
  if (x1 %% 2 == 0 )
  {
    x1/2 ;
  }
  else
  {
    x1*2
  }
}


lapply(x1,zad_a)

### b) usuñ elementy puste z poni¿szej listy

x2 = list('a', 1, c(1,2,3), NULL, NA, 'koniec')
x2

x2[!sapply(x2,is.null)]

is.null(NULL) # sprawdzenie czy dana wartoœæ jest NULLem
is.null(1)

###################################################
### While - powtarzaj tak d³ugo, jak warunek jest spe³niony
###
### break - przerywa wykonywanie pêtli
### next - koñczy obecn¹ iteracjê, przechodzi do nastêpnej
###################################################
?`while`

i = 0
while (i < 8) {
  i = i + 1
  print(i)
}


i = 0
while (i < 8) {
  i = i + 1
  if(i == 4){
    break
  }
  print(i)
}

i = 0
while (i < 8) {
  i = i + 1
  if(i == 4){
    next
  }
  print(i)
}

###################################################
### Repeat - powtarzaj, a¿ nie wywo³am break
### break i next dzia³aj¹ tak samo
###################################################

i = 0

repeat{
  i = i + 1
  if(i > 8){
    break
  }
  print(i)
}

###################################################
### For - wykonaj po kolei, dla ka¿dego elementu z wektora
### break i next dzia³aj¹ tak samo
###################################################

for(i in 1:10){
  print(i)
}

x = 1:6
y = 1
for(i in x){
  y = y * i
}
y



###################################################
### Tworzenie funkcji, czêœæ 2
###################################################


# Konflikty
avg <- function(data){
  print("avg") # abyœmy mogli poznaæ, ¿e to w³aœnie ta metoda zosta³a wywo³ana
  sum(data) / length(data)
}

avg(1:5)


mean = avg # nadpisanie metody mean z pakietu bazowego
mean(1:5)
conflicts()
base::mean(1:5) # odwo³ywanie siê do funkcji z konkretnego pakietu
# bez okreœlenia nazwy pakietu, jest u¿ywana funkcja zdefiniona lokalnie
# a jak takiej nie ma, to z pakietu do³¹czonego najbardziej ostatnio
rm(mean)
mean(1:5)
conflicts()
avg(1:5) # nasza funkcja dalej istnieje pod oryginaln¹ nazw¹
# /Konflikty

# argument z domyœln¹ wartoœæi¹
power_avg <- function(data, power = 1){ # power ma domyœln¹ wartoœæ 1
  d = data ^ power
  m = mean(d)
  m ^ (1/power)
}

power_avg(1:5) #nie ustawiono 'power', zostala przyjêta domyœlna wartoœæ - 1
power_avg(1:5,power = 2)
power_avg(1:5,2) # to samo co linia wy¿ej, bo power to drugi argument
power_avg(1:5,power = -1)


#operator ...
#poszczególne argumenty to ..1, ..2, ..3, ..4, etc.
moja_wspaniala_lista <- function(name, ...){
  list(imiê = name, ...)
}

x = moja_wspaniala_lista("Zdziœ", x = 7, y = "abc")
x



###################################################
###################################################

### Funkcjê fibonacci_series(n), zwracaj¹c¹
### n pierwszych elementów ci¹gu fibonacciego.
### Przyjmij, ¿e:
### - dla n == 1 wartoœæ wynosi 1
### - dla n == 2 wartoœæ wynosi 1
### - n jest nie mniejsze ni¿ 1
### - dane wejsciowe s¹ prawid³owe

fibo <- function(n){
  if (n == 0) 
  {
    return(0)
  }
  else if (n == 1)
  {
    return(n)
  }
  else
  {
    return(fibo (n-2) + fibo(n-1))
  }
  
}



###########################################################################################

#lazy evaluation
x <- function(){
  print("Dzia³am! Dzia³am! Dzia³am!")
  return("Jestem z x")
}
x()

y1 <- function(a){
  print("y1")
}

y2 <- function(a){
  print(paste0("y2", " ", a))
}


y3 <- function(a){
  print(paste0("y3", " ", a, " ", a))
}

y1(x()) # x() nie zosta³a wywo³ana
y2(x()) # x() zosta³a wykonana, bo by³a potrzebna jej wartoœæ
y3(x()) # x() zosta³a wykonana tylko raz, bo jej wartoœæ by³a ju¿ znana






f <- function(x){
  substitute(x)
}

f(1) # zwraca nie wartoœæ, ale to co wpisaliœmy
f(letters[1])
f(paste0(letters[2],log2(4)))

v = (f(paste0(letters[2],log2(4))))
v
typeof(v)
class(v)
deparse(v) # je¿eli chcemy mieæ jako string
eval(v) # je¿eli chcemy wykonaæ

eval(parse(text = "log2(4)")) # operacja odwrotna, wykonanie tekstu

