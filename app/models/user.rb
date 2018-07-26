class User < ApplicationRecord
  enum user_type: {employee: 0, customer: 1}
  enum gender: {male: 1, female: 2, trans: 3}
  has_one :cart
  has_many :orders, dependent: :destroy
  has_many :employees

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save :email_downcase
  has_secure_password

  validates :name, presence: true,
    length: {maximum: Settings.name_max_length}
  validates :gender,  presence: true, inclusion: {in: genders.keys}
  validates :birthday, presence: true,
    inclusion: {in: (Date.today - 100.years..Date.today)}
  validates :address, presence: true,
    length: {maximum: Settings.address_max_length}
  validates :phone_number, presence: true,
    length: {in:
      Settings.phone_number_min_length..Settings.phone_number_max_length}
  validates :email, presence: true,
    length: {maximum: Settings.email_max_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.password_min_length}

  class << self
    def gender_attributes_for_select
      genders.map do |gender, _|
        [I18n.t("activerecord.attributes.#{model_name.i18n_key}.genders.#{gender}"), gender]
      end
    end
  end

  private

  def email_downcase
    self.email = email.downcase!
  end
end
