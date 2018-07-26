class User < ApplicationRecord
  enum user_type: {employee: 0, customer: 1}
  has_one :cart
  has_many :orders, dependent: :destroy
  has_many :employees

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :email_downcase
  has_secure_password

  validates :name, presence: true,
    length: {maximum: Settings.name_max_length}
  validates :gender,  presence: true,
    length: {maximum: Settings.gender_max_length}
  validates :birthday, presence: true
  # length: {in: Settings.birthday_min_length..Settings.birthday_max_length}
  validates :address, presence: true,
    length: {maximum: Settings.address_max_length}
  validates :phone_number, presence: true,
    length: {in: Settings.phone_number_min_length..Settings.phone_number_max_length}
  validates :card_number, allow_nil: true,
    length: {in: Settings.card_number_min_length..Settings.card_number_max_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.password_min_length}

  private

  def email_downcase
    self.email = email.downcase
  end
end
