class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def send_notification(email, str_date, time, calendar)
    body = "Dear #{email}, the end date of one of your #{calendar} calendar in coming in #{str_date} at #{time}. Sorry for spam, im backin 1-2 hours and stop testing"
    mail to: email, subject: "ecalendar notification", body: body
  end
end
