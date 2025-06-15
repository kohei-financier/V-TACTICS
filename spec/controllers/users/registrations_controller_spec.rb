require "rails_helper"

RSpec.describe "Devise新規登録", type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "configure_sign_up_params" do
    it "configure_sign_up_params" do
      controller = Users::RegistrationsController.new
      allow(controller).to receive(:devise_parameter_sanitizer)

      expect(controller.devise_parameter_sanitizer).to receive(:permit).with(:sign_up, keys: [ :attribute ])
      controller.send(:configure_sign_up_params)
    end
  end

  describe "configure_account_update_params" do
    it "configure_account_update_params" do
      controller = Users::RegistrationsController.new
      allow(controller).to receive(:devise_parameter_sanitizer)

      expect(controller.devise_parameter_sanitizer).to receive(:permit).with(:account_update, keys: [ :attribute ])
      controller.send(:configure_account_update_params)
    end
  end
end
