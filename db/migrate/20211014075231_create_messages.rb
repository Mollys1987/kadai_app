class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.references :room, foreign_key: { to_table: :rooms }
      t.timestamp :receiver_opentime
      t.timestamps
    end
  end
  
  
end
