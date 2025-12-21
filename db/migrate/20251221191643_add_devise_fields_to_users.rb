class AddDeviseFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    # Меняем password_digest на encrypted_password
    rename_column :users, :password_digest, :encrypted_password
    
    # Добавляем недостающие поля Devise
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime
    add_column :users, :sign_in_count, :integer, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :string
    add_column :users, :last_sign_in_ip, :string
    
    # Делаем email обязательным и добавляем дефолтное значение
    change_column :users, :email, :string, default: "", null: false
    
    # Проверяем, существует ли уже индекс на email
    # Если нет - создаем его
    unless index_exists?(:users, :email)
      add_index :users, :email, unique: true
    end
    
    # Добавляем индекс для reset_password_token
    add_index :users, :reset_password_token, unique: true
  end
end