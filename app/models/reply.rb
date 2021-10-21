class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  has_many :re_rep, class_name: 'Reply', foreign_key: :reply_id, dependent: :destroy
end
