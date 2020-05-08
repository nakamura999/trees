class Contact < ApplicationRecord

   validates :name, presence: true, length: 2..20
   validates :email, presence: true
   validates :body, presence: true, length: 2..200

end
