###################################################
### Dodatkowe materiały
###################################################

# Postgres: https://code.google.com/archive/p/rpostgresql/
#           https://cran.r-project.org/web/packages/RPostgreSQL/RPostgreSQL.pdf
# MySQL: https://cran.r-project.org/web/packages/RMySQL/README.html
#        https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
# Oracle: http://www.oracle.com/technetwork/database/database-technologies/r/roracle/201403-roracle-2167267.pdf
#         https://cran.r-project.org/web/packages/ROracle/ROracle.pdf
# MS SQL Server: https://github.com/imanuelcostigan/RSQLServer
#                https://cran.r-project.org/web/packages/RSQLServer/RSQLServer.pdf
# SQLite: https://cran.r-project.org/web/packages/RSQLite/RSQLite.pdf


###################################################
### Np. w przypadku PostgreSQL'a
###################################################

# otwieramy połączenie z bazą danych (oczywiście musisz podać dane bazy do której się łączysz)
# require("RPostgreSQL")
# drv <- dbDriver("PostgreSQL")
# con <- dbConnect(drv, dbname = "nazwa_bazy", host = "adres", port = 5432, user = "nazwa_usera", password = "hasło")



###################################################
### Np. w przypadku SQLite'a
###################################################

# Połączmy się z bazą
# install.packages("RSQLite")
require("RSQLite")
drv <- dbDriver("SQLite")

con <- dbConnect(drv, ":memory:")


# załadujmy dane
dbWriteTable(con, 'cars', mtcars)

dbListTables(con) # lista tabel
dbListFields(con, 'cars')



# pobieramy całą tabelę
d <- dbGetQuery(con, "SELECT * from cars")
d

# albo gdy nie chcemy / nie możemy pobrać całości wyniku zapytania
rs = dbSendQuery(con, "SELECT * from cars")
dbColumnInfo(rs)
d <- dbFetch(rs, n = 16) #pobieramy pierwsze 16 wierszy
d
d <- dbFetch(rs, n = 16) #pobieramy kolejne 16 wierszy
d
dbClearResult(rs) 


# pobieramy tylko wiersze mające gear = 4
d <- dbGetQuery(con, "SELECT * from cars WHERE gear = 4")
d

# dodajemy kolumnę x
dbExecute(con, "ALTER TABLE cars ADD COLUMN x NUMERIC;")

# zmieniamy wartość kolumny x
dbExecute(con, "UPDATE cars SET x = am + gear + carb;")

dbListFields(con, 'cars')
dbGetQuery(con, "SELECT * from cars")

# zamykamy połączenie
dbDisconnect(con)
