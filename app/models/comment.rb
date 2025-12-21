class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, optional: true 
  
  validates :body, presence: true
  validates :username, presence: true, unless: -> { user_id.present? }
  
  def display_name
    if user.present?
      user.name.present? ? user.name : user.email
    else
      username.present? ? username : "Аноним"
    end
  end
end