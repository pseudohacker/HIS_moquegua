# cálculo de población atendida por UPS

lista_eess <- c(
  00002835,
  00002833,
  00002834,
  00002829,
  00002836,
  00034031,
  00002852,
  00002816,
  00002809,
  00002808,
  00002830,
  00002825,
  00024054,
  00002863)


lista_eess_piloto <- c(
00002830,
00002833,
00002835,
00002863,
00024054)


dt |>
  filter(renipress %in% lista_eess_piloto) |>
  group_by(Id_Ups) |>
  summarise(N = n()) 


result1 <- dt |>
  filter(renipress %in% lista_eess_piloto) |>
  group_by(Id_Ups) |>
  summarise(N = n()) 

result2 <- dt |>
  filter(renipress %in% lista_eess) |>
  group_by(Id_Ups) |>
  summarise(N = n()) 

results <- result1 |>
  left_join(result2, by = join_by("Id_Ups")) |>
  left_join(dt_ups, by = join_by("Id_Ups"))

rio::export(results,file = paste0(here::here("output"),"/salida.csv"))
