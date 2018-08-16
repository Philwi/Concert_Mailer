class ChartsController < ApplicationController
  def email_null
    @hash = { }
    null = Booker.where('Email IS NULL').count
    not_null = Booker.where('Email IS NOT NULL').count
    @hash['Ohne E-Mail'] = null
    @hash['Mit E-Mail'] = not_null
    render json: @hash
  end

  def email_to_booker
    @hash = { }
    anzahl = 0
    created_tmp = ''
    Mailing.select(:veranstalter, :created_at).each do |mail|
      if created_tmp == Time.at(mail.created_at).to_date
        anzahl += mail.veranstalter.count
      else
        anzahl = mail.veranstalter.count
      end
      created = Time.at(mail.created_at).to_date
      created_tmp = Time.at(mail.created_at).to_date
      @hash[created] = anzahl
    end
    render json: @hash

  end

end
