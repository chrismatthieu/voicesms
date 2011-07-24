require "rubygems"
require "sinatra"
require "rest_client"
require "uri"

post "/transcribe" do
  require 'json'
  
  transcript_json = JSON.parse(request.body.read)
  identifier = transcript_json['result']['identifier']
  transcript = transcript_json['result']['transcription']
  
  data = identifier.split(":") # callerid:calledid
  
  RestClient.get 'http://api.tropo.com/1.0/sessions?action=create&token=0a061c943b623546886b62f124d0f329a71beea4135c0e8f0b55bc61e33ffa211ce1301a15a58c37781f5715&number=' + data[0] + '&msg=' + URI.escape(transcript) 
  
                
end