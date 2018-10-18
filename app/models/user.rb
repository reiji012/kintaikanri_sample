class User < ApplicationRecord
	validates :name, presence: true
	validates :kana, presence: true
	validates :amount, presence: true
	has_many :return_times
end
