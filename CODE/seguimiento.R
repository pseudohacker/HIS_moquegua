dt |>
  filter(stringr::str_detect(Id_Paciente, "^[0-9].*")) |>
  # select(Id_Paciente) |>
  group_by(Id_Paciente) |>
  summarise(count_d = n_distinct(Id_Cita)) 
  # filter(count_d > 1)

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

cod_hospital <- 7732
anio_analisis <- 2024
dt_pop_filtered <- dt |> #AIS
  # filter(Anio >= anio_analisis-3) |>
  # filter(stringr::str_detect(Codigo_Item, "^E11")) |>
  filter(renipress %in% lista_eess) |>
  filter(Tipo_Edad == "A") |>
  filter(Edad_Reg >= 15) |>
  select(Id_Paciente) |>
  unique() 

dt |>
  filter(Id_Paciente %in% dt_pop_filtered$Id_Paciente) |>
  filter(!renipress %in% lista_eess)


dt_referidos <- dt |>
  # filter(renipress == cod_hospital) |>
  filter(Id_Paciente %in% dt_pop_filtered$Id_Paciente) |>
  filter(!renipress %in% lista_eess)
# table(dt_referidos$renipress)

# test <- rbind(dt_pop_filtered,dt_pop_filtered_2)
# dt_pop_filtered <- work_pop_filtered
dt_dm_filtered <- dt_referidos |>
  filter(stringr::str_detect(Codigo_Item, "^E11")) |>
  filter(Id_Paciente %in% dt_pop_filtered$Id_Paciente) |>
  filter(Id_Paciente %in% dt_referidos$Id_Paciente) |>
  # filter(Tipo_Edad == "A") |>
  # filter(Edad_Reg >= 15 & Edad_Reg < 40) |>
  filter(Tipo_Diagnostico == "D" | Tipo_Diagnostico == "R")

dt_hta_filtered <- dt_pop_filtered |>
  filter(stringr::str_detect(Codigo_Item, "^I10")) |>
  # filter(Tipo_Edad == "A") |>
  # filter(Edad_Reg >= 15 & Edad_Reg < 40) |>
  filter(Tipo_Diagnostico == "D" | Tipo_Diagnostico == "R")

list_dx <- dt_pop_filtered |>
  mutate(DM2 = as.numeric(Id_Paciente %in% dt_dm_filtered$Id_Paciente),
         HTA = as.numeric(Id_Paciente %in% dt_hta_filtered$Id_Paciente))

list_dx_40 <- list_dx |>
  filter(edad<40)

table(list_dx$DM2,list_dx$HTA)
table(list_dx_40$DM2,list_dx_40$HTA)
age_prev <- list_dx |>
  group_by(edad) |>
  summarise(propDM2 = mean(DM2), propHTA = mean(HTA)) 


dt |>
  filter()

