class NewsController < ApplicationController
  before_action :logged_in
  def index
    sql = "SELECT club, email, stadt, bundesland FROM Bookers WHERE email IN (SELECT email FROM Bookers GROUP BY email, active HAVING COUNT(email) >= 2 AND email IS NOT NULL AND NOT (active = false OR active IS NULL )) AND NOT (active IS NULL OR active =  'false') ORDER BY email, club, stadt;"

    @booker_to_edit = ActiveRecord::Base.connection.execute(sql)

    @news = News.all.order(created_at: :desc)
  end
  protected

  def logged_in
    redirect_to "/" unless user_signed_in?
  end
end
