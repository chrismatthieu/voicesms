require "rubygems"
require "sinatra"
require "rest_client"
require "uri"

get "/"
  "This app must be called from <a href='http://tropo.com'>Tropo</a>"
end

post "/transcribe" do
  require 'json'
  
  transcript_json = JSON.parse(request.body.read)
  identifier = transcript_json['result']['identifier']
  transcript = transcript_json['result']['transcription']
  
  data = identifier.split(":") # callerid:calledid
  
  RestClient.get 'http://api.tropo.com/1.0/sessions?action=create&token=05a4d25035b0bb479e5d6ec53c65136c872373976cc9c151e23fea03b82ede9c9a02c24b71b42fa495e73a22&number=' + data[0] + '&msg=' + URI.escape(transcript) 
  
                
end