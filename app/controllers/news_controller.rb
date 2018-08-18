class NewsController < ApplicationController
  def index
    sql = "SELECT club, email, stadt, bundesland FROM Bookers WHERE email IN (SELECT email FROM Bookers GROUP BY email HAVING COUNT(email) >= 2 AND email IS NOT NULL) AND NOT (active IS NULL OR active =  'false') ORDER BY email, club, stadt;"
    @booker_to_edit = ActiveRecord::Base.connection.execute(sql)

    @news = News.all
  end
end
