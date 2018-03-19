class PokemonController < ApplicationController

  def show

    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(response.body)
    name = body["name"]
    id = params[:id]

    types = []
    body["types"].each do |type|
      types << type["type"]["name"]
    end

    respond_to do |format|
      format.json do
        render json: {
          name: name,
          id: id,
          types: types
        }
      end
    end
  end

end
