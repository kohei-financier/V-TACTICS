class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success
  include Pundit::Authorization

  protected
  def configure_permitted_parameters
    # 新規登録時にユーザーネームを登録できるようストロングパラメーターを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end
end
