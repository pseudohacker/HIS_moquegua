pacman::p_load(dplyr,
               ggplot2)


age_prev |>
  ggplot(aes(x=edad, y=propHTA)) +
  geom_point()
