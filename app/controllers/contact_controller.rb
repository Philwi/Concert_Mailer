class ContactController < ApplicationController
  def index
  end

  def mailing
      @user = User.find(current_user.id)
    if ContactMailer.with(user: @user.email, mail: params[:kontaktanfrage] ).pers_mail.deliver_now
      flash[:notice] = "Nachricht wurde verschickt"
      redirect_to "/"
    else
      flash[:error] = "Nachricht konnte nicht verschickt werden"
      redirect_to "/"
    end
  end
end
