module Search
  def self.search params, only_public
    query   = ""
    results = ProtectedArea
      .joins(:countries)
      .joins("LEFT JOIN designations ON designations.id = protected_areas.designation_id")
      .joins("LEFT JOIN designation_types ON designation_types.id = designations.designation_type_id")
      .joins("LEFT JOIN allocations ON allocations.protected_area_id = protected_areas.id")
      .joins("LEFT JOIN users ON users.id = allocations.user_id")
      .joins(:wdpa_releases)
      .select("""DISTINCT
        protected_areas.*,
        countries.name as countries_name,
        countries.iso3 as countries_iso3,
        designations.name as design_name,
        designation_types.name as design_type_name
      """)

    if params[:search_type] == "range"
      range = (params[:range_from]..params[:range_to])
      results = results.where(wdpa_id: range)
    end

    if params[:search_type] == "country"
      results = results.where("lower(countries.name) = ?", params[:country].downcase)
    end

    if params[:search_type] == "allocator"
      results = results.where(%q(concat(users.first_name, ' ', users.last_name) = ?), params[:allocator])
    end

    if params[:q].present?
      query = params[:q]
      type, values = reconstruct_query(query)

      if type == :wdpa_ids
        results = results.where(wdpa_id: values)
      else
        results = results.where("lower(countries.name) IN (?)", values.map(&:downcase))
      end
    end

    if only_public
      results = results.where("wdpa_releases.id IS NOT NULL")
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
