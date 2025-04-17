# dt_pop_filtered_2 <- dt |>
#   filter(Anio >= 2020) |>
#   # filter(stringr::str_detect(Codigo_Item, "^E11")) |>
#   filter(Tipo_Edad == "A") |>
#   filter(Edad_Reg >= 15) |>
#   group_by(Id_Paciente) |>
#   summarise(edad = max(Edad_Reg), anio_ingreso = min(Anio), anio_analisis = 2023)



anio_analisis <- 2023
dt_pop_filtered <- dt |>
  filter(Anio >= anio_analisis-2) |>
  # filter(stringr::str_detect(Codigo_Item, "^E11")) |>
  filter(Tipo_Edad == "A") |>
  filter(Edad_Reg >= 15) |>
  group_by(Id_Paciente) |>
  summarise(edad = max(Edad_Reg), anio_ingreso = min(Anio), anio_analisis = anio_analisis)
  
# test <- rbind(dt_pop_filtered,dt_pop_filtered_2)
# dt_pop_filtered <- work_pop_filtered
dt_dm_filtered <- dt_pop_filtered |>
  filter(stringr::str_detect(Codigo_Item, "^E11")) |>
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

