class AllocationsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    max_wdpa_id = ProtectedArea.pluck("max(wdpa_id)").first
    @set1 = ReservationService.request(params[:quantity].to_i)
    @set2 = ReservationService.request(params[:quantity].to_i, @set1.last+1)
    @set3 = ReservationService.request(params[:quantity].to_i, max_wdpa_id)

    @set1 = @set1.chunk_while{|a,b| a+1 == b }.to_a
    @set2 = @set2.chunk_while{|a,b| a+1 == b }.to_a
    @set3 = @set3.chunk_while{|a,b| a+1 == b }.to_a
  end

  def create
    country = Country.where(name: params[:country]).first

    params[:wdpa_ids].each do |wdpa_id|
      protected_area = ProtectedArea.create!(wdpa_id: wdpa_id, countries: [country], status: "allocated")
      Allocation.create!(protected_area: protected_area, user: current_user, country: country)
    end

    head 201
  end
end
