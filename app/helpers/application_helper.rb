module ApplicationHelper
  def fix_url(str)
   str.start_with?("http://") ? str : "http://#{str}"
  end

  def format_date_time(datetime)
    if logged_in? && !current_user.time_zone.blank?
      datetime = datetime.in_time_zone(current_user.time_zone)
    end
    datetime.strftime('%e-%b-%Y %l:%M%P %Z')
  end
end
