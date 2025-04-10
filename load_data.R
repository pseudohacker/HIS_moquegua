pacman::p_load(dplyr,
               purrr)

# query <- "https://files.jlh.work/csvs.rar"
# url_encoded <- utils::URLencode(query, reserved = F)
# url <- url_encoded
# destfile <- here::here("input",glue::glue("csvs.rar"))
# curl::curl_download(url, destfile)

data_path <- "input/csvs"
files <- dir(here::here(data_path), pattern = "^NOMINAL.*2023") # get file names
dt <- files %>%
  # read in all the files, appending the path before the filename
  map(~ rio::import(file.path(data_path, .))) %>%
  reduce(rbind)


