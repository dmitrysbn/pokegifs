class PokemonController < ApplicationController

  def show

    pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    pokemon_body = JSON.parse(pokemon.body)

    pokemon_name = pokemon_body["name"]
    pokemon_id = params[:id]
    pokemon_types = []
    pokemon_body["types"].each do |type|
      pokemon_types << type["type"]["name"]
    end

    gif = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{pokemon_name}&rating=g")
    gif_body = JSON.parse(gif.body)
    gif_url = gif_body["data"][0]["url"]

    respond_to do |format|
      format.json do
        render json: {
          name: pokemon_name,
          id: pokemon_id,
          types: pokemon_types,
          gif: gif_url
        }
      end
    end
  end

end
