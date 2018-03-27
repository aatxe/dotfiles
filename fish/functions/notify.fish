function notify --description "produces a notification with the specified message"
    osascript -e "display notification \"$argv\" with title \"🐡 Fish Notification 🐡\" sound name \"default\""
end
