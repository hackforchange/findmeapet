class NotificationsController < ApplicationController
  def receive
    if params['Body'].downcase == 'stop'
      number = params['From'][2..-1]
      person = Person.find_by_phone(number)
      if person.present?
        person.update_attribute(:allow_texts, false)
      else
        Logger.warn "Person not found with number #{number}"
      end
      render :nothing => true
    end
  end
end
