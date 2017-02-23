class SearchController < ApplicationController
  def index
    @query = params[:q]
    @results = ProtectedArea.joins(:countries).includes(:wdpa_releases)

    type, values = reconstruct_query(@query)

    if type == :wdpa_ids
      @results = @results.where(wdpa_id: values)
    else
      @results = @results.where("countries.name IN (?)", values)
    end

    @results = @results.page(params[:page] || 1)
  end

  def show
    @from_search = params[:from_search]
    @protected_area = ProtectedArea.where(wdpa_id: params[:wdpa_id]).first
    @protected_area or raise_404

    @wdpa_releases = @protected_area.wdpa_releases.order(created_at: :desc)
  end

  private

  def reconstruct_query query
    pieces = Array.wrap(query.split(";").map(&:chomp))
    ids = pieces.map(&:to_i).reject(&:zero?)

    if ids.length > 0
      [:wdpa_ids, ids]
    else
      [:countries, pieces]
    end
  end

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
