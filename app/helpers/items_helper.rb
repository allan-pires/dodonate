module ItemsHelper
  def find_item(id)
    begin
      Item.find(id)
    rescue StandardError => e
      logger.error(e.message)
      error_redirect
    end
  end

  def success_redirect
      logger.info("Operation successful")
      flash[:success] = "All done!"
      redirect_to items_path
  end

  def log_error_and_redirect(error_message)
    logger.error(error_message)
    error_redirect
  end

  def error_redirect
      flash[:danger] = "Something went wrong, sorry!"
      redirect_to items_path
  end

  def check_permission
    if !check_ownership(params[:id])
      logger.error("Permission denied!")
      error_redirect
    end
  end

  def check_ownership(item_id)
    item = find_item(item_id)
    item.user_id == current_user.id
  end
end
