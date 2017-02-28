module ApplicationHelper
  PP_CONFIG = Rails.application.secrets.protected_planet

  URL_TO_PROTECTED_AREA = -> wdpa_id { File.join(PP_CONFIG["root_url"], wdpa_id.to_s) }
  def protected_planet_path page
    {
      root:              PP_CONFIG["root_url"],
      blog:              PP_CONFIG["blog_url"],
      un_list:           PP_CONFIG["un_list_url"],
      protected_area:    URL_TO_PROTECTED_AREA,
      about:             File.join(PP_CONFIG["root_url"], "c/about"),
      updates:           File.join(PP_CONFIG["root_url"], "resources?category_id=10"),
      resources:         File.join(PP_CONFIG["root_url"], "resources?category_id=1"),
      wdpa_page:         File.join(PP_CONFIG["root_url"], "c/world-database-on-protected-areas"),
      pame_page:         File.join(PP_CONFIG["root_url"], "c/protected-areas-management-effectiveness-pame"),
      connectivity_page: File.join(PP_CONFIG["root_url"], "c/connectivity-conservation"),
      terms:             File.join(PP_CONFIG["root_url"], "c/terms-and-conditions")
    }[page]
  end

  def active_link_to text, urls, html_opts={}
    urls = Array.wrap(urls)

    urls.each do |url|
      if current_controller?(url)
        html_opts[:class] ||= ""
        html_opts[:class] << " is-active"
      end
    end

    link_to text, urls.first, html_opts
  end

  def current_controller?(url)
    info = Rails.application.routes.recognize_path url
    params[:controller] == info[:controller]
  end
end
