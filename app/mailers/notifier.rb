class Notifier < ActionMailer::Base
  default from: "eCalendar.asia <info@ecalendar.asia>"

  def send_notification(email, calendar, period, boolean)
    if boolean
      body = "Dear #{email}, start date of one of your calendar: #{calendar.name} is coming up soon #{period.start_date.strftime('%d %b %Y')} on #{period.start_time}.\n"
    else
      body = "Dear #{email}, end date of one of your calendar: #{calendar.name} is coming up soon #{period.end_date.strftime('%d %b %Y')} on #{period.end_time}.\n"
    end
    body += "Period details:\n"
    body += "First name: #{period.first_name}\n" unless period.first_name.empty?
    body += "Lastname: #{period.last_name}\n" unless period.last_name.empty?
    body += "Email address: #{period.email}\n" unless period.email.empty?
    body += "Phone: #{period.phone}\n" unless period.phone.empty?
    body += "Check in: #{period.start_date} #{period.start_time}\n"
    body += "Check out: #{period.end_date} #{period.end_time}\n"
    body += "Adult guests: #{period.adult_guests}\n" unless period.adult_guests.empty?
    body += "Children guests: #{period.children_guests}\n" unless period.children_guests.empty?
    body += "Address 1: #{period.address1}\n" unless period.address1.empty?
    body += "Address 2: #{period.address2}\n" unless period.address2.empty?
    body += "Country: #{period.country}\n" unless period.country.empty?
    body += "City: #{period.city}\n" unless period.city.empty?
    body += "State: #{period.state}\n" unless period.state.empty?
    body += "Postal code: #{period.post_code}\n" unless period.post_code.empty?
    body += "Info: #{period.info}\n" unless period.info.empty?
    body += "Go to calendar: "
    body += "http://#{AppConfig.host}/calendars/#{calendar.id}/edit\n\n"
    body += "eCalendar Team\n\nCherish your time!"
    mail to: email, subject: "#{calendar.name} notification", body: body
  end

  def user_registration_mail(user)
    body = "User #{user.email} has created account on eCalendar"
    mail to: User.where(role: "admin").map(&:email), subject: "New user registration", body: body
  end

  def calendar_payment(calendar)
    admin_body = "User #{calendar.user.email} has paid for calendar: #{calendar.name}"
    mail to: User.where(role: "admin").map(&:email), subject: "Payment notification", body: admin_body
  end

  def calendar_create(calendar)
    admin_body = "User #{calendar.user.email} has created a new calendar: #{calendar.name}"
    mail to: User.where(role: "admin").map(&:email), subject: "Calendars notification", body: admin_body
  end

  def calendar_payment_user(calendar)
    user_body = "Dear #{calendar.user.email}, thank you for payment. Calendar: #{calendar.name}\n\n"
    user_body += "eCalendar Team\n\nCherish your time!"
    mail to: calendar.user.email, subject: "Payment notification", body: user_body
  end

  def calendar_create_user(calendar)
    user_body = "Dear #{calendar.user.email}, you have create a new calendar: #{calendar.name}\n\n"
    user_body += "eCalendar Team\n\nCherish your time!"
    mail to: calendar.user.email, subject: "Calendars notification", body: user_body
  end

  def trial(calendar)
    body = "Dear #{calendar.user.email}, trial period of your calendar: #{calendar.name} is end, please paid fo it to continue using\n\n"
    body += "Thank you for using eCalendar!\n\neCalendar Team\n\nCherish your time!"
    mail to: calendar.user.email, subject: "End of trial period", body: body
  end

  def trial_end(calendar)
    body = "Dear #{calendar.user.email}, trial period of your calendar: #{calendar.name} is ending at #{calendar.trial_to.strftime('%d %b %Y')}\n\n"
    body += "Thank you for using eCalendar!\n\neCalendar Team\n\nCherish your time!"
    mail to: calendar.user.email, subject: "End of trial period coming soon", body: body
  end

  def paid_end(calendar)
    body = "Dear #{calendar.user.email}, paid period of your calendar: #{calendar.name} is ending at #{calendar.paid_to.strftime('%d %b %Y')}, please paid for it to continue using"
    body += "Thank you for using eCalendar!\n\neCalendar Team\n\nCherish your time!"
    mail to: calendar.user.email, subject: "End of paid period", body: body
  end

  def test_mail
    mail to: "xanderwot@gmail.com", subject: "calendars"
  end
end
