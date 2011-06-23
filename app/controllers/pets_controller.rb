class PetsController < ApplicationController
  def show
    @pet = Pet.find_by_id(params[:id])
    render :layout => 'mobile'
  end
end
