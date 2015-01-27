module ApplicationHelper
  MONTHS = {
    1 => "Jan",
    2 => "Feb",
    3 => "Mar",
    4 => "Apr",
    5 => "May",
    6 => "June",
    7 => "July",
    8 => "Aug",
    9 => "Sept",
   10 => "Oct",
   11 => "Nov",
   12 => "Dec"
  }

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorized?
    if current_user.nil?
      redirect_to new_user_path
    end
  end

  def format_date(date)
    time = date.localtime
    "#{MONTHS[time.month]} #{time.day}, #{time.year}"
  end

  def posted_on(date)
    format_date(date) + " at " + format_time(date)
  end

  def format_time(date)
    time = date.localtime
    hour = time.hour
    "#{format_hour(hour)}:#{format_minute(time.min)}#{am_or_pm(hour)}"
  end

  def format_hour(hour)
    if hour == 12 || hour == 0
      return 12
    else
      return hour % 12
    end
  end

  def am_or_pm(hour)
    if hour >= 12
      return "pm"
    else
      return "am"
    end
  end

  def format_minute(minute)
    return minute if minute.to_s.length >= 2
    "0" + minute.to_s
  end
end
