class PetsController < ApplicationController
  def show
    @pet = Pet.find_by_id(params[:id])
  end
end
