class PokemonController < ApplicationController

  def show
    respond_to do |format|
      format.json do
        render json: { "message": "ok" }
      end
    end
  end

end
