class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def send_notification(email, str_date, time, calendar)
    body = "Dear #{email}, the end date of one of your calendars: '#{calendar}' is coming in #{str_date} at #{time}."
    mail to: email, subject: "ecalendar notification", body: body
  end
end
