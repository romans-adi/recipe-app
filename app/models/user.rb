class User < ApplicationRecord
  has_many :foods, foreign_key: :user_id, dependent: :destroy
  has_many :recipes, foreign_key: :user_id, dependent: :destroy
  has_many :recipe_foods, foreign_key: :user_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, uniqueness: { message: 'This email address is already in use.' }

  def admin?
    role == 'admin'
  end
end
