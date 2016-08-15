module ApplicationHelper
  
  def log(type='error', message)
		if type == 'error'
      puts "[ERROR][#{Time.now}] #{message}"
    	Log.error "[ERROR][#{Time.now}] #{message}"
  	else
			puts "[DEBUG][#{Time.now}] #{message}"
      Log.error "[DEBUG][#{Time.now}] #{message}"
		end
	end

end
