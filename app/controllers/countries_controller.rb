class CountriesController < ApplicationController
  def index
    render json: Country.all.order(:name)
  end
end
