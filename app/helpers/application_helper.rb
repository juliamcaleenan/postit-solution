module ApplicationHelper
  def fix_url(str)
   str.start_with?("http://") ? str : "http://#{str}"
  end

  def format_date_time(datetime)
    datetime.strftime('%e-%b-%Y %l:%M%P %Z')
  end
end
