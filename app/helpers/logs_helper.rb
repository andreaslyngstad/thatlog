module LogsHelper
  def new_log(log)
    log = Log.new
    log.user = current_user
    log.tracking = true
    log.log = "from helper"
    log.save
  end
  
  def next_to_last(log)
    Log.last.id.to_i - 1
  end
end
