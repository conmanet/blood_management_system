class User < ApplicationRecord
  attr_reader :is_signed_up_by_admin
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :histories, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :histories_created, class_name: History.name, foreign_key: :admin_id, dependent: :destroy
  has_many :admin_histories, dependent: :destroy
  has_many :admin_histories_created, class_name: AdminHistory.name, foreign_key: :admin_id, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :patients, through: :histories, class_name: History.name, foreign_key: :patient_id

  accepts_nested_attributes_for :histories, allow_destroy: true

  enum gender: [:female, :male]
  enum blood_type: [:a_pos, :a_neg, :b_pos, :b_neg, :ab_pos, :ab_neg, :o_pos, :o_neg]
  enum role: [:normal, :limited, :admin]

  ransacker :gender, formater: proc {|v| genders[v]}
  ransacker :blood_type, formater: proc {|v| blood_types[v]}
  ransacker :role, formater: proc {|r| roles[r]}

  mount_uploader :avatar, AvatarUploader

  validates :name, :gender, :blood_type, :id_number, :phone_number, presence: true, allow_nil: true
  validates :email, format: Settings.email_regex, if: -> {self.email.present?}
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true

  before_save downcase_email: -> {self.email.downcase! if self.email.present?}

  scope :blood_type_compatible_with, -> blood_type {where blood_type: blood_type}

  def status
    return :unknown unless self.histories.any?
    next_donation_due_date = self.histories.eldest.last.next_donation_due_date
    case true
    when Date.current >= next_donation_due_date
      :can_donate
    when Date.current < next_donation_due_date - 7.days
      :cannot_donate
    else
      :almost
    end
  end

  def can_donate?
    status == :can_donate
  end

  def cannot_donate?
    status == :cannot_donate
  end

  def last_donated_place
    histories.newest.first.place
  end

  def signed_up_by_admin! *args
    @is_signed_up_by_admin = args[0].nil? ? true : args[0]
  end

  def is_signed_up_by_admin?
    @is_signed_up_by_admin
  end

  def available_places current = Time.current
    if admin?
      Place.all
    else
      places = admin_histories.available.pluck :place_id
      Place.where id: places
    end
  end

  class << self
    def sort_non_attribute collection, criteria
      criteria = criteria.split " "
      collection = collection.to_a
      collection.sort_by! {|record| record.try criteria[0]}
      collection.reverse! if criteria[1].downcase == "desc"
    rescue ArgumentError
    ensure
      return collection
    end

    def search_non_attribute collection, criteria
      key = criteria.keys.first
      val = criteria.values.first.to_sym
      collection = collection.to_a.select {|record| record.try(key) == val}
    rescue ArgumentError
    ensure
      return collection
    end

    def secure_random_password
      SecureRandom.hex 4
    end

    def secure_random_uuid
      SecureRandom.uuid
    end
  end

  protected
  def email_required?
    false
  end
end
