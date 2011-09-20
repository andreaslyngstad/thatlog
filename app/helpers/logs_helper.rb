module LogsHelper
  
  
  def logs_pr_day(logs, start_time)
  	
  logs_by_day = logs.where(:log_date => start_time.beginning_of_day..Time.zone.now.end_of_day).group("date(log_date)").select("log_date, sum(end_time - begin_time) as total")
  (start_time.to_date..Date.today).map do |date|
    log = logs_by_day.detect { |log| log.log_date.to_date == date }
    log && log.total || 0
  end.inspect
  end
end
  logs_by_day = Log.where(:log_date => Time.zone.now.beginning_of_week..Time.zone.now.end_of_day).group("date(log_date)").select("log_date, sum(end_time - begin_time) as total")