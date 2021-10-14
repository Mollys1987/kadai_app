class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, foreign_key: { to_table: :users }
      t.references :to_user, foreign_key: { to_table: :users }
      t.timestamp :to_user_opentime
      t.timestamps
    end
  end
  
  
end
