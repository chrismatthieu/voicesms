# If inbound text call and read it and ask for reply
if !$msg.nil? or $currentCall.initialText
  if $msg
    call $number
    say $msg
  else
    call "14803194368"
    say $currentCall.initialText
  end
  
  result = ask "Would you like to reply?", {
    :choices => "[1 DIGITS]",
    :attempts => 3}

  if result.value == '1'
    record "Please record a message at the beep.", {
        :beep => true,
        :maxTIme => 60,
        :silenceTimeout  => 2, 
        :transcriptionOutURI => "http://voicesms.heroku.com/transcribe",
        :transcriptionID => $currentCall.callerID + ":" + $currentCall.calledID
        }
  end
  
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
      :transcriptionID => phone + ":" + $currentCall.calledID
      }
end