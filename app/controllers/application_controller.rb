class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure :development do
    enable :logging, :static
  end

  before do
    content_type "application/json", :charset => "utf-8"
    headers 'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
            'Access-Control-Allow-Headers' => 'Content-Type'
  end

  set :protection, except: :http_origin

  options "*" do
    200
  end

  get "/", :provides => :json do
		halt 200, { status: true, message: "API End-Point" }.to_json
  end

  error Sinatra::NotFound do
    content_type :json
    halt 404, { status: false, message: "Resource not found." }.to_json
  end
end
