class ApplicationController < ActionController::Base
  class PageNotFound < StandardError; end;
  protect_from_forgery with: :exception

  def raise_404
    raise PageNotFound
  end

  rescue_from PageNotFound do
    render_404
  end
end
