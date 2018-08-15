class BookingMailer < ApplicationMailer

  def gig_mail
    @body = params[:mail].body
    @band = Band.find(params[:band])
    mail(to: params[:veranstalter].email, subject: params[:mail].subject, from: @band.email)
  end
end
