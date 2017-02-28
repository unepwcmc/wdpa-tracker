class SearchController < ApplicationController
  def index
    search = Search.search(params)

    @search_id = params.slice(:search_type, :q, :range_from, :range_to, :country, :allocator)
    @results = sort(search[:results], params[:sort], params[:dir])
    @query = search[:query]
  end

  def show
    @from_search = params[:from_search]
    @protected_area = ProtectedArea.where(wdpa_id: params[:wdpa_id]).first
    @protected_area or raise_404

    @wdpa_releases = @protected_area.wdpa_releases.order(created_at: :desc)
  end

  private

  COLUMNS = {
    "wdpa_id" => "protected_areas.wdpa_id",
    "name" => "protected_areas.name",
    "parent_iso" => "countries.iso3",
    "iso" => "countries.iso3",
    "designation" => "designations.name",
    "designation_type" => "designation_types.name",
    "wdpa_release" => "(protected_areas.status, wdpa_releases.created_at)"
  }

  def sort collection, column, direction
    order = build_column(column) + " " + build_direction(direction)
    collection.order(order)
  end

  def build_column column
    COLUMNS[column] || "protected_areas.wdpa_id"
  end

  def build_direction direction
    %w[asc desc].include?(direction) ? direction : "desc"
  end
end
