class Api::V1::ItemsController < Api::V1::ApiController
  before_action :require_login, :only => [ :create, :edit, :delete ]

  def show
    begin
      @item = Item.find(params[:id])
      render json: @item
    rescue ActiveRecord::RecordNotFound
      render_not_found
    end
  end
end