class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact = contact
    mail to: 'nakau26@gmail.com',
         subject: 'お問い合わせいただきありがとうございます'
  end

end
