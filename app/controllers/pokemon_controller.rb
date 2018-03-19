class PokemonController < ApplicationController

  def show
    pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")

    if pokemon.code == 404
      render plain: "404: Not Found"
    else
      pokemon_body = JSON.parse(pokemon.body)

      pokemon_name = pokemon_body["name"]
      pokemon_id = params[:id]
      pokemon_types = []
      pokemon_body["types"].each do |type|
        pokemon_types << type["type"]["name"]
      end

      gif = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}5&q=#{pokemon_name}&rating=g")
      if gif.code == 403
        render plain: "403: Forbidden."
      else
        gif_body = JSON.parse(gif.body)
        gif_url = gif_body["data"][rand(gif_body["data"].size)]["url"]

        render json: {
          name: pokemon_name,
          id: pokemon_id,
          types: pokemon_types,
          gif: gif_url
        }
      end
    end
  end

  def team
    pokemons = []

    6.times do
      random_number = rand(800) + 1

      pokemon = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{random_number}/")
      pokemon_body = JSON.parse(pokemon.body)

      pokemon_name = pokemon_body["name"]
      pokemon_id = random_number
      pokemon_types = []
      pokemon_body["types"].each do |type|
        pokemon_types << type["type"]["name"]
      end

      gif = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{pokemon_name}&rating=g")
      gif_body = JSON.parse(gif.body)

      # handles case if no gif for some pokemon
      if gif_body["data"].any?
        gif_url = gif_body["data"][rand(gif_body["data"].size)]["url"]
        pokemons << { name: pokemon_name, id: pokemon_id, types: pokemon_types, gif_url: gif_url }
      else
        pokemons << { name: pokemon_name, id: pokemon_id, types: pokemon_types, gif_url: "nil" }
      end
    end

    render json: pokemons
  end
end
