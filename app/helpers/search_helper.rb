module SearchHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == params[:sort] && params[:dir] == "asc") ? "desc" : "asc"
    css_class = "table__column table__column--with-sorting".tap { |cl|
      cl << " is-sorted-#{direction}" if column == params[:sort]
    }

    link_to((@search_id || {}).merge({sort: column, dir: direction}), class: css_class) do
      concat title
    end
  end
end
