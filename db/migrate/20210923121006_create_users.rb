class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :prefucture
      t.string :city
      t.string :profile_image
      t.string :password_digest
      t.string :remember_digest
      t.timestamps
    end
  end
end
