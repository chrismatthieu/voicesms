# If inbound text call and read it and ask for reply
if !$msg.nil? or $currentCall.initialText
  if $msg
    mynumber = $number
    mymessage = $msg
  else
    mynumber = "14803194368"
    mymessage = $currentCall.initialText
  end
  
	
  call mynumber, {
    :channel => 'VOICE', 
    :network => 'PSTN',
    :onAnswer=>lambda{|event|
			newCall = event.value

			newCall.say mymessage
			result = newCall.ask "Would you like to reply?", {
        :choices => "yes,no",
        :attempts => 3}

      if result.value == 'yes'
        newCall.record "Please record a message at the beep.", {
            :beep => true,
            :maxTIme => 60,
            :silenceTimeout  => 2, 
            :transcriptionOutURI => "http://voicesms.heroku.com/transcribe",
            :transcriptionID => $currentCall.callerID + ":" + $currentCall.calledID
            }
      end
      
      newCall.say "good bye"      
      
    }
  }  
else
  # initiate a text by calling this number
  phone = ask "Say the phone number that you would like to send a message to", {
    :choices => "[10 DIGITS]",
    :attempts => 3}

  record "Please record a message at the beep.", {
      :beep => true,
      :maxTIme => 60,
      :silenceTimeout  => 2, 
      :transcriptionOutURI => "http://voicesms.heroku.com/transcribe",
      :transcriptionID => phone.value.to_s + ":" + $currentCall.calledID
      }

  say "good bye"

end

