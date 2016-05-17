class User < ActiveRecord::Base
  has_many :picks, dependent: :destroy
  has_many :stats, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
           foreign_key: "follower_id",
           dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_favorites, class_name:  "Favorite",
           foreign_key: "user_id",
           dependent:   :destroy
  has_many :favorites, through: :active_favorites, source: :pick

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true , length: { maximum: 20 },
            uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true , length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
                    #url: '/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                    #path: ':rails_root/public/system/:class/:attachment/:id_partition/:style/:hash.:extension',
                    #hash_secret: '<get_use_rake_secret>'
  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ },
                       size: { in: 0..1.megabytes }


  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def setprotipster
    update_attribute(:pro, 1)
  end

  def delprotipster
    update_attribute(:pro, 0)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token )
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end


  def fav(pick)
    active_favorites.create(pick_id: pick.id)
  end

  def unfav(pick)
    active_favorites.find_by(pick_id: pick.id).destroy
  end

  def faving?(pick)
    favorites.include?(pick)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Pick.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  #Crea estadistica mensual si aún no existe
  def create_stat_if_not(date)
    @stat=Stat.where("user_id = ? and created_at BETWEEN ? AND ?", id, date.beginning_of_month, date.end_of_month)
    if @stat.empty?
      @stat= self.stats.build
      @stat.save
      @stat
    else
      @stat.first
    end
  end


end
