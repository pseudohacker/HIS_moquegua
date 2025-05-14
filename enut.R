# Paquetes ----

pacman::p_load(dplyr,
               purrr)

# Load ----

## Rutas ----
## load total_data

remote_route <- "s3://files.jlh.work/INEI/ENUT2024/"
data_save <- "enut2024.tar.gz"
local_route <- here::here("input")
cmd_str <- glue::glue("s3cmd get {remote_route}{data_save} {local_route}")
cat(cmd_str)
system(cmd_str)

cmd_str <- glue::glue("tar -xvzf input/{data_save} -C input")
cat(cmd_str)
system(cmd_str)

dt_enut_2024_100 <- rio::import(here::here("input","enut2024","V_ENUT2024_100.dta"))
dt_enut_2024_200 <- rio::import(here::here("input","enut2024","V_ENUT2024_200.dta"))
dt_enut_2024_300 <- rio::import(here::here("input","enut2024","V_ENUT2024_300.dta"))
dt_enut_2024_400 <- rio::import(here::here("input","enut2024","V_ENUT2024_400.dta"))
dt_enut_2024_500 <- rio::import(here::here("input","enut2024","V_ENUT2024_500.dta"))
dt_enut_2024_600 <- rio::import(here::here("input","enut2024","V_ENUT2024_600.dta"))
dt_enut_2024_700_800_900 <- rio::import(here::here("input","enut2024","V_ENUT2024_700_800_900.dta"))

str(dt_enut_2024_100)

