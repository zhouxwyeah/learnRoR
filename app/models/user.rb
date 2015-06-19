class User < ActiveRecord::Base
attr_accessor :remeber_token

	before_save {self.email = email.downcase}
	validates :name,presence:true, length:{ maximum:50 }
	validates :email,presence:true,length:{maximum:50},format:{with:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},uniqueness:  { case_sensitive: false }
	validates :password,length:{minimum:6}
	has_secure_password

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remeber
		self.remeber_token=User.new_token
		update_attribute(:remeber_digest,User.digest(remeber_token));
	end

	def forget
		update_attribute(:remeber_digest,nil);
	end


	# 如果指定的令牌和摘要匹配，返回 true
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remeber_digest).is_password?(remember_token)
  end

end
