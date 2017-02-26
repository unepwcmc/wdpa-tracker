module Search
  def self.search params
    query   = ""
    results = ProtectedArea.joins(:countries).includes(:wdpa_releases)

    if params[:search_type] == "range"
      range = (params[:range_from]..params[:range_to])
      results = results.where(wdpa_id: range)
    end

    if params[:search_type] == "country"
      results = results.where("countries.name = ?", params[:country])
    end

    if params[:search_type] == "allocator"
      results = results.where(status: "reserved")
    end

    if params[:q].present?
      query = params[:q]
      type, values = reconstruct_query(query)

      if type == :wdpa_ids
        @results = @results.where(wdpa_id: values)
      else
        @results = @results.where("countries.name IN (?)", values)
      end
    end

    results = results.page(params[:page] || 1)
    {query: query, results: results}
  end

  private

  def self.reconstruct_query query
    pieces = Array.wrap(query.split(";").map(&:chomp))
    ids = pieces.map(&:to_i).reject(&:zero?)

    if ids.length > 0
      [:wdpa_ids, ids]
    else
      [:countries, pieces]
    end
  end
end
