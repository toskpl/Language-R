###################################################
### Dodatkowe materiały
###################################################

# https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html
# https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html
# https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html
# https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf


###################################################
### Operator pipe: %>%
### przekazywanie wwartości z lewej, jako argument
### wywołania funkcji z prawej
###################################################

library(dplyr)
library(data.table) # nie musi być, ale lepiej używać

paste0("a","b","c")
"a" %>% paste0("b","c")

paste0("a","b") %>% paste0("c")
"a" %>% paste0("b") %>% paste0("c")

# jeżeli ma byc inna pozycja niż pierwszy argument - użyj .
"b" %>% paste0("a","c")
"b" %>% paste0("a", .,"c")


###################################################
### select - wybór kolumn
### select(dataset, kolumna1, kolumna2, ...)
###################################################
?select

data = data.table(mtcars)
data = cbind(name = row.names(mtcars), data)

data %>%
  View()
# to samo co View(data)

data %>%
  select(name, mpg) %>%
  View()
# to samo co View(select(data, name, mpg))


# zamiast wymieniać kolumny, można określić wzór nazwy, np.
data %>%
  select(name, starts_with("d")) %>%
  View()



###################################################
### arrange - sortowanie według podanych kolumn
### arrange(dataset, kolumna1, kolumna2, ...)
###################################################
?arrange

data %>%
  arrange(name) %>%
  View()

data %>%
  arrange(vs, mpg) %>%
  View()

data %>%
  arrange(vs, desc(mpg)) %>%
  View()


###################################################
### filter - wybór wierszy
### filter(dataset, warunek1, warunek2, ...)
###################################################
?filter

data %>%
  filter(gear == 4) %>%
  View()

data %>%
  filter(gear == 4, carb == 4) %>%
  View()


data %>%
  filter(gear == 4) %>%
  filter(carb == 4) %>%
  View() # ale tak jest wolniej, niż z warunkami w jednym wywołaniu
         # filter(), bo dataset musi zostać przejrzany dwukrotnie


# prównajmy prędkość przetwarzania:
microbenchmark::microbenchmark(
  data %>%
    filter(gear == 4, carb == 4)
)

microbenchmark::microbenchmark( #prawie 2 razy wolniej, a robi to samo
  data %>%
    filter(gear == 4) %>%
    filter(carb == 4)
)



data %>%
  filter(gear == 4 | carb == 4) %>% # lub (jak wszędzie indziej w R)
  View()


###################################################
### mutate / transmute - tworzenie / modyfikacja kolumn
### mutate(dataset, kolumna1 = wartość1, ...)
### transmute(dataset, kolumna1 = wartość1, ...)
###################################################

data %>%
  mutate(letter = 'x') %>%
  View()

data %>%
  mutate(kpl = 0.4251 * mpg) %>%
  View()


data %>%
  transmute(name, kpl = 0.4251 * mpg) %>%
  View() #usuwa kolumny nie wymienione



###################################################
### summarise - agregacja
### summarise(dataset, nazwa1 = funkcja1(kolumna1), ...)
###################################################
?summarise

data %>%
  summarise(mean_mpg = mean(mpg), count = n()) %>% # n() - liczba wierszy w grupie
  View()





#########################################

##########################################
### group_by - grupowanie wierszy
### group_by(dataset, kolumna1, wyrażenie2 = wartość2, ...)
###################################################
?group_by

data %>%
  group_by(cyl) %>% # dodaje informację o podziale na grupy
  summarise(mean(wt)) %>%
  View() # średnia waga zależnie od liczby cylindrów


data %>%
  group_by(cyl) %>%
  mutate(group_wt_mean = mean(wt)) %>%
  View() # do każdego wiersza została dodana wartość wyliczona dla danej grupy


data %>%
  group_by(cyl) %>%
  mutate(group_wt_mean = mean(wt)) %>%
  ungroup() %>% # usuwa informację o podziale na grupy
  mutate(total_wt_mean = mean(wt)) %>%
  View()


data %>% # kolumna według której grupujemy nie musi być wcześniej wyliczona
  group_by(kpl = floor(0.4251 * mpg)) %>% # możemy ją zdefiniować w group_by
  View()



###################################################
### do - wykonuje funkcję (która zwraca listę / data.frame)
### do(dataset, funkcja(..., ., ...))
###   . - określa gdzie idą dane
###################################################
?do

#będzie nam potrzebna funkcja
boot_ci <- function (data, FUN, rep = 10000) 
{
  if(length(data) > 1){
    res <- c()
    for (i in 1:rep) {
      d2 <- sample(data, replace = T)
      r <- FUN(d2)
      res <- c(res, r)
    }
    v <- FUN(data)
    q <- quantile(res, probs = c(0.025, 0.975), na.rm = TRUE)
    return(data.frame(min = q[1], val = v, max = q[2], se = sd(res)))
  } else {
    return(data.frame(min = NA, val = data, max = NA, se = NA))
  }
}

boot_ci(rnorm(1000, mean = 0, sd = 1), mean)

data %>%
  group_by(cyl) %>%
  do(boot_ci(.$wt, mean)) %>%
  View()
  



###################################################
### *_join - łączenie datasetów
### *_join(dataset1, dataset2, by = c(kolumny połączeniowe))
### inner_join - tylko wiersze dopasowane z obu stron
### left_join  - wiersze dopasowane z obu stron 
###   oraz wiersze z lewej, które nie zostały
###   dopasowane (uzupełnione NA)
### right_join - wiersze dopasowane z obu stron 
###   oraz wiersze z prawej, które nie zostały
###   dopasowane (uzupełnione NA)
### full_join - wiersze dopasowane z obu stron
###   oraz wiersze z prawej i lewej, które nie zostały
###   dopasowane (uzupełnione NA)
###################################################
?inner_join

# potrzebujemy drugiej tabeli
tax = data.table(cyl = c(4, 6, 8), tax = c(0.1, 0.13, 0.16))

data %>%
  inner_join(tax, by = "cyl") %>%
  View()



tax = data.table(cyl = c(4, 6), tax = c(0.1, 0.13))

data %>%
  inner_join(tax, by = "cyl") %>%
  View() # wiersze z cyl 8 zostały pominięte



tax = data.table(cyl = c(4, 6), tax = c(0.1, 0.13))

data %>%
  left_join(tax, by = "cyl") %>%
  View() # wiersze z cyl 8 zostały dodane z pustą kolumnę tax




tax = data.table(cyl = c(4, 6, 10), tax = c(0.1, 0.13, 0.19))

data %>%
  full_join(tax, by = "cyl") %>%
  View()



###################################################
### Pakiet tidyr
### gather - zmienia grupę kolumn na parę kolumn klucz-wartość
### gather(dataset, klucz, wartość, kolumna1, kolumna2, ...) #po nazwach
### gather(dataset, klucz, wartość, c(1:3, 5)) #po indeksach
###
### spread - odwrotnie niż gather
### spread(dataset, klucz, wartość)
###
### separate - podział kolumny na kilka
### separate(dataset, kolumna_źródłowa, kolumny_docelowe)
###
### unite - podział kolumny na kilka
### unite(dataset, kolumna_docelowa, kolumna_źródłowa1, kolumna_źródłowa2, ...)
###
### są też inne funkcje w pakiecie, np. ?expand
### ... a te wymienione mają więcej argumentów
###################################################

# install.packages("tidyr")
library(tidyr)


data = data.table(mtcars)
data = cbind(name = row.names(mtcars), data)


# zmiana grupy kolumn na pary <klucz,wartość>
?gather

data %>%
  gather(cecha, wartość, vs, am, gear, carb) %>% #po nazwach kolumn
  View()

data %>%
  gather(cecha, wartość, 9:12) %>% #po indeksach kolumn
  View()



?spread

#przygotujmy dane
data2 = data %>%
  gather(cecha, wartość, 9:12) %>%
  select(c(1,9,10))

data2 %>%
  spread(cecha, wartość) %>%
  View()


?separate

data.frame(id = 1:3, sum = c("a+b+c","a+b+d","r+t+b")) %>%
  separate(sum, c("v1","v2","v3"))


?unite

data.frame(id = 1:3, v1 = letters[1:3], v2 = letters[10:12]) %>%
  unite("sum", v1, v2, sep = '~')

  
  data %>%
  filter(cyl >= 6) %>%
  mutate(kpl = 0.4251 * mpg) %>%
  summarise(mean_wt = mean(wt), mean_kpl = mean(kpl))
