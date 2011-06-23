class SheltersController < ApplicationController
  helper_method :shelter

  def index
  end

  def show
  end

  protected 

  def shelter
    Shelter.find(params[:id])
  end
end
