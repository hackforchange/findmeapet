class NotificationsController < ApplicationController
   def receive
     logger.info "Received: #{params.inspect}"
   end
end
