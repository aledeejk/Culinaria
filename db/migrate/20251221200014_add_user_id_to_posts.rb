class AddUserIdToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :user, null: true, foreign_key: true
    
    reversible do |dir|
      dir.up do
        if User.any?
          first_user = User.first
          Post.where(user_id: nil).update_all(user_id: first_user.id) if first_user
        end
      end
    end
  end
end