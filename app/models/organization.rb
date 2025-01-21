# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  # Associations
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
end
