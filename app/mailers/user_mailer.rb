class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("controllers.mailer.acc")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("controllers.mailer.reset")
  end
end
