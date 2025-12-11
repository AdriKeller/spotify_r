# 1. Compute regressions for each genre
regressions <- spotify_songs %>%
  group_by(playlist_genre) %>%
  do(model = lm(danceability ~ energy, data = .)) %>%
  mutate(tidy = purrr::map(model, tidy),
         glance = purrr::map(model, glance)) %>%
  unnest(tidy) %>%
  select(playlist_genre, term, estimate) %>%
  pivot_wider(names_from = term, values_from = estimate) %>%
  left_join(
    regressions <- spotify_songs %>%
      group_by(playlist_genre) %>%
      do(glance = glance(lm(danceability ~ energy, data = .))) %>%
      unnest(glance) %>%
      select(playlist_genre, r.squared),
    by = "playlist_genre"
  ) %>%
  mutate(
    label = paste0(
      "danceability = ",
      round(`(Intercept)`, 3), " + ",
      round(energy, 3), " * energy\n",
      "R² = ", round(r.squared, 3)
    )
  )

# 2. Create the plot with regression lines and in-facet annotation
spotify_songs %>%
  ggplot(aes(x = energy, y = danceability)) +
  geom_point(aes(color = playlist_genre), alpha = 0.3) +
  geom_smooth(method = "lm", se = FALSE, color = "black", size = 1) +
  geom_text(
    data = regressions,
    aes(label = label),
    x = 0.1, y = 0.95,       # adjust label position within faceted panels
    hjust = 0, vjust = 1,
    size = 4,
    color = "black"
  ) +
  facet_wrap(~ playlist_genre) +
  scale_color_brewer(palette = "Dark2") +
  labs(
    title = "Energy vs Danceability with Genre-Specific Linear Regression Lines",
    x = "Energy",
    y = "Danceability",
    color = "Genre"
  ) +
  theme_minimal(base_size = 14)