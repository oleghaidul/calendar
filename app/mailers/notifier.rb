class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def send_notification(email, calendar, boolean)
    if boolean
      body = "Dear #{email}, the start date of one of your calendars is coming in #{calendar.start_date.strftime('%d %b %Y')} at #{calendar.start_time}.\n"
    else
      body = "Dear #{email}, the end date of one of your calendar is coming in #{calendar.end_date.strftime('%d %b %Y')} at #{calendar.end_time}.\n"
    end
    body += "Period details:\n"
    body += "First name: #{calendar.first_name}\n" unless calendar.first_name.nil?
    body += "Lastname: #{calendar.last_name}\n" unless calendar.last_name.nil?
    body += "Email address: #{calendar.email}\n" unless calendar.email.nil?
    body += "Phone: #{calendar.phone}\n" unless calendar.phone.nil?
    body += "Check in: #{calendar.start_date} #{calendar.start_time}\n"
    body += "Check out: #{calendar.end_date} #{calendar.end_time}\n"
    body += "Adult guests: #{calendar.adult_guests}\n" unless calendar.adult_guests.nil?
    body += "Children guests: #{calendar.children_guests}\n" unless calendar.children_guests.nil?
    body += "Address 1: #{calendar.address1}\n" unless calendar.address1.nil?
    body += "Address 2: #{calendar.address2}\n" unless calendar.address2.nil?
    body += "Country: #{calendar.country}\n" unless calendar.country.nil?
    body += "City: #{calendar.city}\n" unless calendar.city.nil?
    body += "State: #{calendar.state}\n" unless calendar.state.nil?
    body += "Postal code: #{calendar.post_code}\n" unless calendar.post_code.nil?
    body += "Info: #{calendar.info}\n" unless calendar.info.nil?
    mail to: email, subject: "#{calendar.name} notification", body: body
  end
end
