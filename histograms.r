spotify_songs = readr::read_csv('./data/spotify_songs.csv')

# creates histograms to see which data could be interesting ####

library(ggplot2)
library(plotly)
ggplot(spotify_songs,aes(x=track_popularity))+geom_histogram(binwidth = 1)+xlim(10,100)

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
