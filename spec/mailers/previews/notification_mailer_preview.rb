# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer_mailer/new_technique_notification
  def new_technique_notification
    NotificationMailer.new_technique_notification
  end

end
