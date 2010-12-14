class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :oauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :oauthable,
         :encryptable, :encryptor => :sha1

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessor :access_token
  cattr_accessor :current_user

  def oauth_facebook_token
    @oauth_facebook_token ||= self.class.oauth_access_token(:facebook, facebook_token)
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = ActiveSupport::JSON.decode(access_token.get('https://graph.facebook.com/me?'))

    REDIS.hset "uid:token", data['id'], access_token.token
    
    user = User.find_by_email(data["email"])
    if !user
      # Create an user with a stub password.
      username = "#{data['first_name']}_#{data['last_name']}_#{data['id']}".to_slug
      user = User.new(:username => username, :email => data["email"], :password => Devise.friendly_token[0,20], :first_name => data['first_name'], :last_name => data['last_name'])
      user.save!
    end

    user.access_token = access_token
    
    return user
  end

end
