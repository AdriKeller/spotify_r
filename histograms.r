spotify_songs = readr::read_csv('./data/spotify_songs.csv')

# creates histograms to see which data could be interesting ####

library(ggplot2)
library(plotly)

ggplot(spotify_songs,aes(x=track_popularity))+geom_histogram(binwidth = 1)+xlim(10,100)
ggplot(spotify_songs,aes(x=track_popularity))+geom_density(fill="#888", alpha=0.6)+theme_bw()


ggplot(spotify_songs,aes(x=danceability))+geom_histogram(binwidth = 0.01)
ggplot(spotify_songs,aes(x=energy))+geom_histogram(binwidth = 0.01)
ggplot(spotify_songs,aes(x=key))+geom_histogram()
ggplot(spotify_songs,aes(x=loudness))+geom_histogram(binwidth = 1)
ggplot(spotify_songs,aes(x=speechiness))+geom_histogram(binwidth = 0.01)
ggplot(spotify_songs,aes(x=acousticness))+geom_histogram(binwidth = 0.01)
ggplot(spotify_songs,aes(x=liveness))+geom_histogram(binwidth = 0.01)
ggplot(spotify_songs,aes(x=valence))+geom_histogram(binwidth = 0.01)
ggplot(spotify_songs,aes(x=tempo))+geom_histogram(binwidth = 5)

ggplot(spotify_songs,aes(x=instrumentalness))+geom_histogram(binwidth = 0.1)
ggplot(spotify_songs,aes(x=instrumentalness))+geom_histogram(binwidth = 0.01)+xlim(0.1,1)


# Zielstruktur: popularity, value_name, value
spotify_songs_stats = pivot_longer(
  spotify_songs %>% select(track_popularity, danceability, energy, key, loudness, mode, speechiness, acousticness, instrumentalness, liveness, valence, tempo, duration_ms),
  cols = danceability:duration_ms, names_to = "value_name", values_to = "value"
)

install.packages("ggridges")

library(tidyverse)

spotify_songs_stats = pivot_longer(
  spotify_songs %>% select(track_popularity, danceability, energy, speechiness, acousticness, instrumentalness, liveness, valence),
  cols = danceability:valence, names_to = "value_name", values_to = "value"
)

library(ggridges)

ggplot(spotify_songs_stats, aes(track_popularity, y=fct_reorder(value_name, value), group=value_name, height=value)) +
  geom_ridgeline(
    alpha = 0.4,
    fill = "#05595b",
    color = "white"
  )

