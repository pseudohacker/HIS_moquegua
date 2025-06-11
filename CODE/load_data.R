# Paqutes ----

pacman::p_load(dplyr,
               purrr)


# Load ----
remote_route <- "s3://files.jlh.work/his_moquegua/"
local_route <- "input"
filename <- "csvs.rar"
cmd_str <- glue::glue("s3cmd get {remote_route}{filename} {local_route}/")
cat(cmd_str)
system(cmd_str)

filename <- "his2024.tar.gz"
cmd_str <- glue::glue("s3cmd get {remote_route}{filename} {local_route}/")
cat(cmd_str)
system(cmd_str)

#
# query <- "https://files.jlh.work/HIS318.DBF"
# url_encoded <- utils::URLencode(query, reserved = F)
# url <- url_encoded
# destfile <- here::here("input",glue::glue("HIS318.DBF"))
# curl::curl_download(url, destfile)
# 
# query <- "https://files.jlh.work/HIS319.DBF"
# url_encoded <- utils::URLencode(query, reserved = F)
# url <- url_encoded
# destfile <- here::here("input",glue::glue("HIS319.DBF"))
# curl::curl_download(url, destfile)

## descomprimir ----
file <- here::here(local_route,"csvs.rar")
cmd_str <- glue::glue("unrar x {file} {local_route}/")
cat(cmd_str)
system(cmd_str)

file <- here::here(local_route,"his2024.tar.gz")
local_route <- here::here("input","csvs")
cmd_str <- glue::glue("tar xvzf {file} -C {local_route}/")
cat(cmd_str)
system(cmd_str)

cmd_str <- glue::glue("mv {local_route}/2024/* {local_route}")
cat(cmd_str)
system(cmd_str)


## cargar en memoria ----
data_path <- "input/csvs"
files <- dir(here::here(data_path), pattern = "^NOMINAL.*GENERAL_2024") # get file names
dt <- files %>%
  # read in all the files, appending the path before the filename
  map(~ rio::import(file.path(data_path, .))) %>%
  reduce(plyr::rbind.fill)

# data_path <- "input"
# files <- dir(here::here(data_path), pattern = "^HIS") # get file names
# dt_18_19 <- files %>%
#   # read in all the files, appending the path before the filename
#   map(~ rio::import(file.path(data_path, .))) %>%
#   reduce(plyr::rbind.fill)


