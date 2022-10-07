class ReportMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.report.subject
  #
  def report(user, answer)
    @user = user
    @answer = answer
    @question = answer.question

    mail(to: user.email, subject: 'New answer')
  end
end
