# adulto >= 30 <60
# joven >=18 < 30
# adolescentes >= 12 <18
# niños <12


stat <- dt |>
  mutate(paq_99209.04 = as.integer(Codigo_Item == "99209.04"), #evaluación antropométrica
         paq_99403 = as.integer(Codigo_Item == "99403" | Codigo_Item == "99403.01"), #consejería nutricional
         paq_99173 = as.integer(Codigo_Item == "99173" & (Valor_Lab == "OD" | Valor_Lab == "OI")),
         paq_D0150 = as.integer(Codigo_Item == "D0150"),
         paq_99384_1 = as.integer(Codigo_Item == "99384" & Valor_Lab == "1"), #evaluación integral 1
         paq_96150.01 = as.integer(Codigo_Item == "96150.01"),
         paq_96150.02 = as.integer(Codigo_Item == "96150.02"),
         paq_96150.03 = as.integer(Codigo_Item == "96150.03"),
         paq_96150.04 = as.integer(Codigo_Item == "96150.04"),
         paq_96150.05 = as.integer(Codigo_Item == "96150.05"),
         paq_96150.08 = as.integer(Codigo_Item == "96150.08"),
         paq_Z003 = as.integer(Codigo_Item == "Z003"),
         paq_99384_2 = as.integer(Codigo_Item == "99384" & Valor_Lab == "2"), #evaluación integral 2
         paq_99384.02 = as.integer(Codigo_Item == "99384.02"),
         paq_99384_3 = as.integer(Codigo_Item == "99384" & Valor_Lab == "3"), #evaluación integral 3
         paq_99402.03 = as.integer(Codigo_Item == "99402.03"),
         paq_completo_rep = as.integer(Codigo_Item == "C8002" & Valor_Lab == "1")) |> #reporte total
  select(Id_Cita, Anio, Mes, Dia, Fecha_Atencion, Id_Ups, Id_Establecimiento, Id_Paciente,
         Id_Condicion_Establecimiento, Id_Condicion_Servicio, Edad_Reg, Tipo_Edad, Anio_Actual_Paciente,
         Valor_Lab, renipress, matches("^paq"))

# dt |>
#   filter(!Tipo_Edad == "") |>
#   select(Id_Paciente) |>
#   unique() |>
#   nrow()

by <- join_by(Id_Paciente)

index <- dt |>
  filter(!Tipo_Edad == "") |>
  mutate(edad = case_when(Tipo_Edad == "A" ~ Anio_Actual_Paciente,
                          Tipo_Edad == "M" ~ Edad_Reg/12,
                          Tipo_Edad == "D" ~ 0.1)) |>
  group_by(Id_Paciente) |>
  summarise(edad = min(edad)) |>
  mutate(etapa_vida = case_when(edad < 12 ~ "01_Niño",
                                edad >=12 & edad < 18 ~ "02_Adolescente",
                                edad >=18 & edad < 30 ~ "03_Joven",
                                edad >=30 & edad < 59 ~ "04_Adulto",
                                edad >=60 ~ "05_Adulto_mayor")) |>
  ungroup() |>
  filter(etapa_vida == "02_Adolescente") |>
  left_join(stat, by)

adolescente_result <- index |>
  group_by(Id_Paciente) |>
  summarise(across(starts_with("paq_"), ~ max(.x))) |>
  rowwise() |>
  mutate(paq_adolescente_completo = sum(c_across(starts_with("paq_"))))

adolescente_result |>
  saveRDS(here::here("DATA_TEMP","results.Rds"))
