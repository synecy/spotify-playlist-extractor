module ApplicationHelper

  $SPOTIFY_TOKEN = { token: nil, created_at: Time.at(99999999999) }

	def get_spotify_token
		begin
      b64_auth = Base64.encode64("#{Config::SPOTIFY[ENV['RACK_ENV'].to_sym][:client_id]}:#{Config::SPOTIFY[ENV['RACK_ENV'].to_sym][:client_secret]}").gsub(/\n/, '')
			reponse = JSON.parse(RestClient.post('https://accounts.spotify.com/api/token', 'grant_type=client_credentials', {"Authorization": "Basic #{b64_auth}"}), symbolize_names: true)
      $SPOTIFY_TOKEN = { token: reponse[:access_token], created_at: Time.now }
      reponse[:access_token]      
		rescue => e
      log("error", "Failed to authenticate spotify #{e}")
		end		
	end

  def get_spotify_playlist(user_id, playlist_id)
     access_token = ($SPOTIFY_TOKEN[:created_at] < Time.now+3500 ? $SPOTIFY_TOKEN[:token] : get_spotify_token)
     begin
      reponse = JSON.parse(RestClient.get("https://api.spotify.com/v1/users/#{user_id}/playlists/#{playlist_id}/tracks", {"Authorization": "Bearer #{access_token}"}), symbolize_names: true)
      reponse[:items].map { |item|
 				{ name: "#{item[:track][:artists][0][:name]} - #{item[:track][:name]}" }
			}
    rescue => e
      $SPOTIFY_TOKEN = { token: nil, created_at: Time.at(99999999999) }
      log("error", "Failed to load spotify playlist #{e}")
    end
  end
  
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
