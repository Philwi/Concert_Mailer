class BookingMailer < ApplicationMailer

  def gig_mail
    @body = params[:mail].body
    @body = ActionController::Base.helpers.sanitize(@body)
    @body = @body.gsub("<div>", "")
    @body = @body.gsub("</div>", "")
    @band = Band.find(params[:band])
    mail(to: params[:veranstalter].email, subject: params[:mail].subject, from: @band.email)
  end
end
