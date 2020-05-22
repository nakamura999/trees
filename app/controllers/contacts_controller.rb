class ContactsController < ApplicationController

   def create
   	@contact = Contact.new(contact_params)
   	if @contact.save
   		ContactMailer.contact_mail(@contact).deliver
   		redirect_to root_path
   		flash[:notice] = "送信しました"
   	else
      flash[:notice] = "送信できませんでした"
   		render template: "homes/top"
   	end
   end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :body)
  end

end
