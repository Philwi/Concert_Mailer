class EventMailer < ActionMailer::Base
  default from: 'schlimm_concert_mailer@gmail.com'
  def send_events(events, current_user)
    @cal = Icalendar::Calendar.new

    events.each do |ev|
      @cal.event do |e|
        e.dtstart = ev.start_time
        e.summary = ev.title
        e.description = beschreibung(ev)
        e.organizer = ev.location
      end
    end
    attachments['schlimm_concert_mailer_events.ics'] = { mime_type: 'text/calendar', content: @cal.to_ical }
    mail(to: User.find(current_user.id).email,
         subject: "Schlimm Concert Mailer - Events für deine Band(s)", body:"Deine Veranstaltungen sind in dem File zum Download bereit.")
  end

  def beschreibung(events)
    "#{events.description} \nBand: #{Band.find_by(id: events.band_id).name}\nLocation: #{events.location}\nTeilnehmende Bands: #{events.bands}\nLink zur Veranstaltung: #{events.link}"
  end
end
