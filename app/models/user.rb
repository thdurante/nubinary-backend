class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  has_many :string_calculations, dependent: :destroy
end
