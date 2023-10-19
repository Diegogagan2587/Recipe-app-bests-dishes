class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # user associations
  has_many :foods
  has_many :recipes
  # enables acces for the foods required in a recipe from
  # within controller like: current_user.recipe_foods
  has_many :recipe_foods, through: :recipes, source: :recipe_foods
end
