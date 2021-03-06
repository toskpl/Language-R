###################################################
### Dodatkowe materia�y
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
### Operatory i sta�e
###################################################

?`+` # pomoc do tematu


1+1 
2-1; 3-3 
2*2
2/2
5%%2 #reszta z dzielenia
5%/%2 #cz�� ca�kowita
2^3; 2**3 #pot�gowanie na dwa sposoby

1/0; Inf  #niesko�czono�� pozytywna
-1/0; 1/-0; -Inf  #niesko�czono�� negatywna
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
### Obs�uga pakiet�w
###################################################

install.packages("readr") # instalacja


library(readr) # wczytywanie pakietu
library(readrxxx) # sypie b��dem, je�eli pakietu nie ma

require(readr) # te� wczytywanie, ale b��dem nie sypie
require(readrxxx) # wy�wietla jedynie komunikat
(require(readr)) # zwraca TRUE je�eli pakiet jest
(require(readrxxx)) # zwraca FALSE je�eli pakietu nie ma


###################################################
### Czyszczenie pami�ci
###################################################
x = "xxxx"

rm(x) #usuwanie zmiennej

gc() #oczyszczenie pami�ci zajmowanej przez usuni�te zmienne
#tak�e odpalane automatycznie co jaki� czas
#lub jak brakuje pami�ci
#zwraca statystyki zu�ycia pami�ci



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
y; Y #wielko�� znak�w ma znaczenie


###################################################
### Nazewnictwo zmiennych
###################################################
varname1
var_name2
var.name3 # niezalecane, mo�e mie� 
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
class(x) #jak powinny by� interpretowane

x = c(1,2,3) # skalar w R te� jest wektorem, ale zawieraj�cym tylko jeden element
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
class(x) # ale ma by� interpretowany jako jedna ze zdefiniowanych warto�ci
levels(x) # lista r�nych warto�ci
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
x * x # mno�enie skalarne
x %*% x # mno�enie macierzowe


#array
x = array(1:8, c(2,2,2)) # macierz o liczbie wymiar�w > 2
x
typeof(x)
class(x)

x
x[,1,] # wybieramy elementy, kt�re na 1-szym i 3-cim wymiarze maj� dowoln� pozycj�, a na drugim pozycj� 1


#list
x = list(a = 1, b = 2, c = "s") # zbi�r nazwanych warto�ci
x
typeof(x)
class(x)


x = list(a = 1, b = 2, c = list(d = 3, e = 4)) # mo�e zawiera� listy

x
x$a
x[2] # drugi element, wynik jest list� z jednym elementem
x[[2]] # warto�� drugiego elementu
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
  stringsAsFactors = F # bo domy�lnie stringi zamieniane s� na factory
)
x
typeof(x) # bo technicznie jest list� wektor�w o tej samej d�ugo�ci
class(x)

x[1] #kolumna jako data.frame (tak na prawd�, to pierwszy element listy)
x[,1] #kolumna jako wektor
x[,"a"] #albo tak
x$a #albo tak
x[[1]] #tak te�, no bo lista
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
x = rbind(x, "Kalasanty" = list(a = 4, b = "d", c = T, d = "D")) # nie poszerza listy poziom�w factora
x
x = rbind(x, "Hilary" = list(a = 5, b = "c", c = F, d = "C")) 
x


#dodawanie kolumny
x = cbind(x, e = c(10, 20, 30, 40, 50)) # mo�emy doklei� wektor jako kolumn�
x
x = cbind(x, data.frame(f = c(2, 3, 5, 8, 13))) # mo�emy te� sklei� dwa data.framy
x

###################################################
### Wektory
###################################################

x = c(1,2,3) # wyliczamy elementy
x
x = c(1, c(2,3)) #tak na prawd� to c() skleja wektory
x

x = 1:5 # kolejne liczby od 1 do 5
x

x = 5:1 # kolejne liczby od 5 do 1
x

x = seq(1, 9, 2) # liczby od 1 do 9 z krokiem co 2
x = seq(from = 1, to = 9, by = 2) # to samo, ale z nazwami atrybut�w
x

x = rep(1:3, 2)
x

x = rep(1:3, each = 2)
x

x = 1:5
x
x * 2
x + 2
x + 1:3 # r�na d�ugo��
x + 2:6

1:6 + 1:3
# 1 2 3 4 5 6
# 1 2 3 1 2 3
# ===========
# 2 4 6 5 7 9


4 %in% 1:5
6 %in% 1:5
1:2 %in% 1:5
all(1:2 %in% 1:5) # prawda, je�eli wszystkie to prawda
1:2 %in% 2:5
all(1:2 %in% 2:5)

###################################################
### Zadanie WEK1
###################################################

### Utw�rz wektor postaci:
### a) 1, 2, 3, ..., 99, 100, 99, ..., 3, 2, 1
x = (1:100,99:1)
x
### b) 1, 2, 3, 1, 2, 3, ...   (10 powt�rze�)
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
                 # to m.in. wymusza notacj� zwyk��
                 # zamiast wyk�adniczej


###################################################
### Wywo�ywanie funkcji
### name(args)
### name(arg_name = value)
### name(arg1, arg2, argX_name = argX_value)
###################################################

log(1) #logarytm
exp(1) #e do pot�gi...
log2(2) #log o podstawie 2
log(4, 2) #logarytm o wybranej podstawie 
pi #liczba pi
choose(6,2) #dwumian Newtona: 6!/(2!*(6-2)!), liczba mo�liwych r�nych par spo�r�d sze�ciu element�w
sqrt(4)
ceiling(4.2)
floor(4.6)
trunc(3.99)
trunc(-3.99)
round(6.492)
round(6.492, 1)
signif(123456, 3)
factorial(5) #silnia

# sprawdzanie, kt�re elementy ci�gu zawieraj� podany wzorzec
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
plot(x, y, type = "l", xlab = "O� X", ylab = "O� Y")



###################################################
### Tworzenie funkcji
### name <- function(args){
###   ... body ...
### }
###################################################


avg <- function(data){
  s = sum(data)
  l = length(data)
  return(s/l) # je�eli nie ma return(...), zwracany jest wynik ostatniego wywo�ania
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

if (2 < 3) { # je�eli spe�nione wykonaj ten kod
  print("prawda")
}

if (2 < 3) print("prawda") # klamry nie s� obowi�zkowe
                           # ale bez nich tylko jedna
                           # instrukcja jest warunkowana


if (2 > 3) { # je�eli spe�nione wykonaj ten kod
  print("prawda")
}


if (2 > 3) {
  print("prawda")
} else { # w innym przypadku wykonaj ten kod
  print("fa�sz")
}

x = c(1,2,3,4)

ifelse(x>2, "wi�ksze", "nie wi�ksze")


x = data.frame(
  a = c(1,2,3,4),
  b = c("B1","B2","B3","B4"),
  c = c("C1","C2","C3","C4"),
  d = c("D1","D2","D3","D4"),
  stringsAsFactors = F
)

# dodaje kolumn� e, kt�ra:
# w nieparzystych wierszach zawiera element z kolumny b,
# a w parzystych element z kolumny c
x$e = ifelse((x$a %% 2) == 1, x$b, x$c)
x


###################################################

### Funkcja fibonacci(n), zwracaj�c� n-ty
### element ci�gu fibonacciego, w oparciu
### podej�cie rekurencyjne.
###
### - dla n == 0 warto�� wynosi 0
### - dla n == 1 warto�� wynosi 1
### - dane wejsciowe s� prawid�owe

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
x2 # lista niezagnie�d�ona

x3 = x2
x3$sub = lapply(x2, '*', 10)
x3 # lista zagnie�d�ona


# lapply - wynik jest list�
lapply(x, sqrt) 
lapply(x2, sqrt)
lapply(x3, sqrt) # b��d, bo jeden z element�w listy nie jest poprawnym argumentem


# sapply - wynik jest wektorem lub macierz�
sapply(x, sqrt) 
sapply(x2, sqrt)
sapply(x3, sqrt)


# rapply - _apply, ale przechodzi w kolejne poziomy zag��bienia listy
rapply(x3, sqrt)
rapply(x3, sqrt, how = 'unlist') # domy�lny, zmienia dodatkowo rekurencyjnie list� na wektor
rapply(x3, sqrt, how = 'list') # pozostawi� struktur� jaka jest

x4 = x3
x4$z = 'a' # dodajmy element nie b�d�cy ani liczb�, ani list�
x4

rapply(x4, sqrt, how = 'list') # b��d, bo jeden z element�w nie jest liczb�, a pierwiastek ma sens tylko dla liczb
rapply(x4, sqrt, how = 'list', classes = c('numeric','integer')) # b��d, bo jeden z element�w nie jest liczb�
rapply(x4, sqrt, how = 'replace', classes = c('numeric','integer')) # replace - te kt�re s� innego typu pozostaw bez zmian


# vapply - wynik jest formatu podanego jak trzeci argument
vapply(x, sqrt, 1) # tu chcemy aby wynik by� numeryczny
vapply(x, sqrt, 'a') # a tu �eby by� ci�giem znak�w, wi�c si� sypie, bo jest liczb�
vapply(x, as.character, 'a') # a tu dzia�a, bo jest ci�giem znak�w
vapply(x, function(a) as.character(sqrt(a)), 'a') # i tu te�
vapply(x2, sqrt, 1)


###################################################
### Zadanie APPLY1
###################################################

### a) nieparzyste elementy poni�szej listy podw�j, a parzyste podziel przez 2

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

### b) usu� elementy puste z poni�szej listy

x2 = list('a', 1, c(1,2,3), NULL, NA, 'koniec')
x2

x2[!sapply(x2,is.null)]

is.null(NULL) # sprawdzenie czy dana warto�� jest NULLem
is.null(1)

###################################################
### While - powtarzaj tak d�ugo, jak warunek jest spe�niony
###
### break - przerywa wykonywanie p�tli
### next - ko�czy obecn� iteracj�, przechodzi do nast�pnej
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
### Repeat - powtarzaj, a� nie wywo�am break
### break i next dzia�aj� tak samo
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
### For - wykonaj po kolei, dla ka�dego elementu z wektora
### break i next dzia�aj� tak samo
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
### Tworzenie funkcji, cz�� 2
###################################################


# Konflikty
avg <- function(data){
  print("avg") # aby�my mogli pozna�, �e to w�a�nie ta metoda zosta�a wywo�ana
  sum(data) / length(data)
}

avg(1:5)


mean = avg # nadpisanie metody mean z pakietu bazowego
mean(1:5)
conflicts()
base::mean(1:5) # odwo�ywanie si� do funkcji z konkretnego pakietu
# bez okre�lenia nazwy pakietu, jest u�ywana funkcja zdefiniona lokalnie
# a jak takiej nie ma, to z pakietu do��czonego najbardziej ostatnio
rm(mean)
mean(1:5)
conflicts()
avg(1:5) # nasza funkcja dalej istnieje pod oryginaln� nazw�
# /Konflikty

# argument z domy�ln� warto��i�
power_avg <- function(data, power = 1){ # power ma domy�ln� warto�� 1
  d = data ^ power
  m = mean(d)
  m ^ (1/power)
}

power_avg(1:5) #nie ustawiono 'power', zostala przyj�ta domy�lna warto�� - 1
power_avg(1:5,power = 2)
power_avg(1:5,2) # to samo co linia wy�ej, bo power to drugi argument
power_avg(1:5,power = -1)


#operator ...
#poszczeg�lne argumenty to ..1, ..2, ..3, ..4, etc.
moja_wspaniala_lista <- function(name, ...){
  list(imi� = name, ...)
}

x = moja_wspaniala_lista("Zdzi�", x = 7, y = "abc")
x



###################################################
###################################################

### Funkcj� fibonacci_series(n), zwracaj�c�
### n pierwszych element�w ci�gu fibonacciego.
### Przyjmij, �e:
### - dla n == 1 warto�� wynosi 1
### - dla n == 2 warto�� wynosi 1
### - n jest nie mniejsze ni� 1
### - dane wejsciowe s� prawid�owe

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
  print("Dzia�am! Dzia�am! Dzia�am!")
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

y1(x()) # x() nie zosta�a wywo�ana
y2(x()) # x() zosta�a wykonana, bo by�a potrzebna jej warto��
y3(x()) # x() zosta�a wykonana tylko raz, bo jej warto�� by�a ju� znana






f <- function(x){
  substitute(x)
}

f(1) # zwraca nie warto��, ale to co wpisali�my
f(letters[1])
f(paste0(letters[2],log2(4)))

v = (f(paste0(letters[2],log2(4))))
v
typeof(v)
class(v)
deparse(v) # je�eli chcemy mie� jako string
eval(v) # je�eli chcemy wykona�

eval(parse(text = "log2(4)")) # operacja odwrotna, wykonanie tekstu

