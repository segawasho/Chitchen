class User < ApplicationRecord

  validates :name, {presence: true, length: {maximum: 10}}
  validates :password, {length: {minimum: 6, maximum: 15}, confirmation: true, on: :create}
end
