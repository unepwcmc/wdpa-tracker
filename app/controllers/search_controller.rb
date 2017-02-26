class SearchController < ApplicationController
  def index
    search = Search.search(params)
    @query = search[:query]
    @results = search[:results]
  end

  def show
    @from_search = params[:from_search]
    @protected_area = ProtectedArea.where(wdpa_id: params[:wdpa_id]).first
    @protected_area or raise_404

    @wdpa_releases = @protected_area.wdpa_releases.order(created_at: :desc)
  end

  private

  COLUMNS = {
    "id" => "reports.id",
    "username" => "users.first_name",
    "agency" => "agencies.name",
    "timestamp" => "reports.created_at",
    "date_of_discovery" => "reports.data->'answers'->'date_of_discovery'->>'selected'",
    "confiscated" => "reports.data->'answers'->'confiscated'->>'selected'",
    "state" => "reports.data->>'state'",
  }

  def self.sort collection, column, direction
    collection = collection.includes(user: :agency)
    order = build_column(column) + " " + build_direction(direction)

    collection.order(order)
  end

  def self.build_column column
    COLUMNS[column] || "reports.created_at"
  end

  def self.build_direction direction
    %w[asc desc].include?(direction) ? direction : "desc"
  end
end
