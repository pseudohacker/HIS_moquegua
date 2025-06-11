pacman::p_load(dplyr, gt)

dt |>
  filter(renipress == 7732) |>
  filter(stringr::str_detect(Id_Paciente, "^[0-9].*")) |>
  # filter(Tipo_Edad == "A") |>
  # filter(Edad_Reg >= 15 & Edad_Reg < 40) |>
  filter(stringr::str_detect(Codigo_Item, "^R73[09]|^99199.22|^Z019|^Z02[0-4]|^93000|^99401.13|^C|^83036|^99209.04")) |>
  # filter(stringr::str_detect(Tipo_Diagnostico, "P")) |>
  group_by(Anio, Codigo_Item) |>
  summarize(count = n()) |>
  tidyr::pivot_wider(names_from = Anio, names_prefix = "anho_", values_from = count) -> dt_hosp_primaria

dt_hosp_primaria |>
  gt() |>
  grand_summary_rows(columns = -Codigo_Item,
                     fns = list(label = "Grand Total", fn = "sum"))
  

