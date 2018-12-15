class BookingMailer < ApplicationMailer

  def gig_mail
    @body = params[:mail].body
    @body = @body.gsub("<br>", "\n")
    @body = ActionController::Base.helpers.strip_tags(@body)
    @band = Band.find(params[:band])
    mail(to: params[:veranstalter].email, subject: params[:mail].subject, cc: @band.email)
  end
end
