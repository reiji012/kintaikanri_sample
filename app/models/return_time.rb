class ReturnTime < ApplicationRecord
  belongs_to :user
  validates :return_date, presence: true
end
