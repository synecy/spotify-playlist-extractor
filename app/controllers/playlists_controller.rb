class PlaylistsController < ApplicationController

  get "/", :provides => :json do
		halt 200, { status: true, message: "Playlist API End-Point" }.to_json
  end



end
