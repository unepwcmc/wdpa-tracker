class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.json { render json: User.all.order(:last_name).to_json(methods: :full_name) }
      format.html { }
    end
  end
end

