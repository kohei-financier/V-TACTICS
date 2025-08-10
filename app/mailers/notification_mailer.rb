class NotificationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.new_technique_notification.subject
  #
  default from: "vtactics2025.info@gmail.com"

  def new_technique_notification(user, technique, category)
    @user = user
    @technique = technique
    @category = category

    mail(to: @user.email, subject: "【V-TACTICS】新投稿通知: #{@category.name}")
  end
end
