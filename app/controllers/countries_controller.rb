class CountriesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Country.all.order(:name)
  end
end
