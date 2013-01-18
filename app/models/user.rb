require 'digest'

class User < ActiveRecord::Base

	attr_accessor   :password
	attr_accessible :email, :login, :firstname, :lastname, :password, :password_confirmation, :avatar, :hashlink

  has_many :comments
  has_many :friendships

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :login, :presence => true,
  				          :length   => { :maximum => 12 },
                    :uniqueness => { :case_sensitive => false }

	validates :email, :presence   => true,
  				          :format     => { :with => email_regex },
  				          :uniqueness => { :case_sensitive => false }

	validates :password, :presence     => true,
  						         :confirmation => true,
  					 	         :length       => { :within => 6..40 },
                       :on           => :create

  before_save :encrypt_password

  mount_uploader :avatar, AvatarUploader

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(login, submitted_password)
    user = find_by_login(login)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  	
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
	end

  	private

	  	def encrypt_password
	  		self.salt = make_salt if new_record?
	  		self.encrypted_password = encrypt(password) if !password.nil?
	  	end

	  	def encrypt(string)
	  		secure_hash("#{salt}--#{string}")
	  	end

	  	def make_salt
	  		secure_hash("#{Time.now.utc}--#{password}")
	  	end

	  	def secure_hash(string)
	  		Digest::SHA2.hexdigest(string)
	  	end
end