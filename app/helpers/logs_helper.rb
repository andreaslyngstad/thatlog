module LogsHelper
  def logs_pr_day(logs, start_time)
  	
    logs_by_day = logs.where(:log_date => start_time.beginning_of_day..Time.zone.now.end_of_day).group("date(log_date)").select("log_date, sum(end_time - begin_time) as total")
    (start_time.to_date..Date.today).map do |date|
      log = logs_by_day.detect { |log| log.log_date.to_date == date }
      log && log.total || 0
    end.inspect
  end
  
  def check_log_status(params_log_id)
    if params_log_id != "0"
    @log = Log.find(params_log_id)
    end
    @firm = current_firm
    @customers = @firm.customers
  end
  
end
  
