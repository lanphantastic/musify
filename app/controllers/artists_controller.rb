class ArtistsController < ApplicationController

  require 'base64'

  def show
    @artist = Artist.find(params[:id])

    token = ENV["LASTFM_KEY"]

    response = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{@artist.name}&api_key=#{token}&format=json")
    body = JSON.parse(response.body)
    @src = body['artist']['image'][3]['#text']

    @artist_uri = spotify_artist(@artist)

  end

  def spotify_artist(artist)

    client_id            = '5f1459c2f0474f73a5aad88186bee5be'
    client_secret        = 'ab92c7f6c10f436a8fa86c0756a8c8f9'
    client_id_and_secret = Base64.strict_encode64("#{client_id}:#{client_secret}")
    refresh_token        = 'AQBBN09eUhUNK3lzGa0NnmByOuJkE3T2CRYJLfPQ1uclSEqHY5_YLrfDsj9H_8EJE26wd4OXZtVCNO7zqBXTyBRPbwnmAPB1ynnSXnJSy_VorQnD_BnGAsAccYzuOn1wKqk'

    result = HTTParty.post(
      "https://accounts.spotify.com/api/token",
      headers: {
        "Authorization" => "Basic #{client_id_and_secret}"
      },
      body: {
        grant_type:    "refresh_token",
        refresh_token: refresh_token
      }
  )

  p JSON.parse( result.body )

    access_token = JSON.parse(result.body)["access_token"]

    artist = HTTParty.get(
      "https://api.spotify.com/v1/search?q=#{@artist.name}&type=artist",
      headers: {
        "Authorization" => "Bearer #{access_token}"
      }
    ).body

    artist_result = JSON.parse(artist)

    return artist_result["artists"]["items"][0]["uri"]

  end
end
