class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.string :reply
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true
      t.references :reply, foreign_key: {to_table: :replies}
      t.timestamps
    end
  end
end
