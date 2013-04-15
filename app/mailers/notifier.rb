class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def send_notification(email, calendar, period, boolean)
    if boolean
      body = "Dear #{email}, the start date of one of your calendars is coming in #{period.start_date.strftime('%d %b %Y')} at #{period.start_time}.\n"
    else
      body = "Dear #{email}, the end date of one of your calendar is coming in #{period.end_date.strftime('%d %b %Y')} at #{period.end_time}.\n"
    end
    body += "Period details:\n"
    body += "First name: #{period.first_name}\n" unless period.first_name.nil?
    body += "Lastname: #{period.last_name}\n" unless period.last_name.nil?
    body += "Email address: #{period.email}\n" unless period.email.nil?
    body += "Phone: #{period.phone}\n" unless period.phone.nil?
    body += "Check in: #{period.start_date} #{period.start_time}\n"
    body += "Check out: #{period.end_date} #{period.end_time}\n"
    body += "Adult guests: #{period.adult_guests}\n" unless period.adult_guests.nil?
    body += "Children guests: #{period.children_guests}\n" unless period.children_guests.nil?
    body += "Address 1: #{period.address1}\n" unless period.address1.nil?
    body += "Address 2: #{period.address2}\n" unless period.address2.nil?
    body += "Country: #{period.country}\n" unless period.country.nil?
    body += "City: #{period.city}\n" unless period.city.nil?
    body += "State: #{period.state}\n" unless period.state.nil?
    body += "Postal code: #{period.post_code}\n" unless period.post_code.nil?
    body += "Info: #{period.info}\n" unless period.info.nil?
    mail to: email, subject: "#{calendar} notification", body: body
  end
end
