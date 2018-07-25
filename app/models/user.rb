class User < ApplicationRecord
  enum user_type: {employee: 0, customer: 1}
  has_one :cart
  has_many :orders, dependent: :destroy
  has_many :employees
end
