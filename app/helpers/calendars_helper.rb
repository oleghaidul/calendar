module CalendarsHelper

  def days_name_of_month(year, month)
    (Date.new(year, month).to_date..Date.new(year, month).at_end_of_month).map{ |date| date.strftime("%a") }
  end

  def days_of_month(year, month)
    (Date.new(year, month).to_date..Date.new(year, month).at_end_of_month).map{ |date| date.strftime("%e") }
  end

  def twelve_month
    (Date.today.to_date..11.month.since(Date.today)).map{ |date| date.strftime("%Y, %m, %B") }.uniq
  end

end