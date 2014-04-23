class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  validates :first_name, :last_name, presence: true
  validates :email, :name, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  def self.search(search, select_column)
    if search
      if connection.adapter_name == 'PostgreSQL'
        where("#{select_column} ILIKE ?", "#{search}%")
      else
        where("#{select_column} LIKE ?", "#{search}%")
      end
    else
      all
    end
  end
end
