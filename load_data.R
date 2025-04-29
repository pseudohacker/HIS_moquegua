# Paqutes ----

pacman::p_load(dplyr,
               purrr)


# Load ----

# query <- "https://files.jlh.work/csvs.rar"
# url_encoded <- utils::URLencode(query, reserved = F)
# url <- url_encoded
# destfile <- here::here("input",glue::glue("csvs.rar"))
# curl::curl_download(url, destfile)

## Rutas ----
# remote_route <- "s3://files.jlh.work/credicorp/"
local_route <- here::here("input")


## descargas ----
file <- here::here(local_route,"csvs.rar")
cmd_str <- glue::glue("unrar x {file} {local_route}/")
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

data_path <- "input/csvs"
files <- dir(here::here(data_path), pattern = "^NOMINAL.*GENERAL_2023") # get file names
dt <- files %>%
  # read in all the files, appending the path before the filename
  map(~ rio::import(file.path(data_path, .))) %>%
  reduce(plyr::rbind.fill)

data_path <- "input"
files <- dir(here::here(data_path), pattern = "^HIS") # get file names
dt_18_19 <- files %>%
  # read in all the files, appending the path before the filename
  map(~ rio::import(file.path(data_path, .))) %>%
  reduce(plyr::rbind.fill)


