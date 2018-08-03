###################################################
### Nawigacja po folderach
###################################################

getwd()
setwd(paste0(getwd(),'/example'))
getwd()
setwd(paste0(getwd(),'/..'))
getwd()


###################################################
### Wczytanie pliku
###################################################

library(readr) 

read_csv("iris.csv") # można też użyć pełnych ścieżek
iris_data = read_csv("iris.csv")
typeof(iris_data)
class(iris_data)

iris_data2 = read_csv("iris.csv", col_types = cols(
  sepal_length = col_double(),
  sepal_width = col_double(),
  petal_length = col_skip(),
  petal_width = col_skip(),
  species = col_factor(c("setosa", "versicolor", "virginica"))
))

iris_data2 = read_csv("iris.csv", col_types = "dd__c")

# Więcej: 
vignette("column-types")
# albo: https://cran.r-project.org/web/packages/readr/vignettes/column-types.html


read_csv("https://raw.githubusercontent.com/uiuc-cse/data-fa14/gh-pages/data/iris.csv")


###################################################
### Zapisywanie pliku
###################################################

d = read_csv("iris.csv")
d$number = row.names(d)
d$letter = sample(LETTERS, length(d$number), replace = T)

write_csv(d, "iris2.csv")


###################################################
###################################################

### Z pliku https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv
### wczytaj kolumny:
### - model - jako ciąg znaków
### - mpg - jako liczbę zmiennoprzecinkową
### - cyl - jako liczbę zmiennoprzecinkową
### - hp - jako liczbę całkowitą
### - carb - jako ciąg znaków
### Pozostałe kolumny pomiń.
### Następnie:
### - dodaj do tego kolumnę "x" o treści "xxx"
### - zapisz otrzymany data.frame do pliku

f = "https://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv"

d = read_csv(f, col_types = "cdd_i______c")

d$x = "xxx"

write_csv(d, "mtcars2.csv")