# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Attributes
  has_secure_password

  # Associations
  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships

  # Callbacks
  before_validation :normalize_email
  before_validation :strip_extraneous_spaces

  # Validations
  validates :name, presence: true
  validates :email,
    format: { with: URI::MailTo::EMAIL_REGEXP },
    uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 8 }

  private

  def normalize_email
    self.email = email.downcase if email.present?
  end

  def strip_extraneous_spaces
    self.name = name.strip if name.present?
    self.email = email.strip if email.present?
  end
end
