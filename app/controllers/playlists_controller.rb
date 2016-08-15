class PlaylistsController < ApplicationController

  get "/", :provides => :json do
    content_type "text/html", :charset => "utf-8"
    erb :index
  end

	get "/:user_id/:playlist_id", :provides => :json do
    playlist_songs = get_spotify_playlist(params[:user_id], params[:playlist_id])		
		halt 200, { status: true, message: "OK", playlist: playlist_songs }.to_json
	end

end
