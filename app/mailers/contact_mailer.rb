class ContactMailer < ActionMailer::Base

  def pers_mail
    mail(to: "philoc@freenet.de", subject: subject, from: params[:user], body: params[:mail][:body])
  end

  def subject
    "Eine Nachricht vom Concert Mailer: #{params[:mail][:subject]}"
  end
end
