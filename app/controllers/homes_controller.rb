class HomesController < ApplicationController
  layout 'tops'

  def top
  	@contact = Contact.new
  end
end
