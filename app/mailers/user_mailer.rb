class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("controllers.mailer.acc")
  end

  def password_reset
    @greeting = I18n.t "controllers.mailer.hi"
    mail to: "to@example.org"
  end
end
