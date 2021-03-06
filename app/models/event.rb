class Event < ApplicationRecord
  include RankedModel
  ranks :row_order
  before_validation :generate_friendly_id,:on=> :create
  validates_presence_of :name

  belongs_to :category,:optional => true
  has_many :tickets,:dependent=> :destroy
  accepts_nested_attributes_for :tickets,:allow_destroy=>true,:reject_if=>:all_blank
  STATUS=["draft","public","private"]
  validates_inclusion_of :status,:in=> STATUS
  has_many :registrations,:dependent=>:destroy
  scope :only_public,->{where(:status=>"public")}
  scope :only_available,->{where(:status=>["public","private"])}

  mount_uploader :logo, EventLogoUploader
  mount_uploaders :images,EventImageUploader
  serialize :images, JSON

  has_many :attachments,:class_name=>"EventAttachment",:dependent=>:destroy
  accepts_nested_attributes_for :attachments,:allow_destroy=>true,:reject_if=>:all_blank

  def to_param
    self.friendly_id
  end
  protected
  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end
end
