class Comment < ActiveRecord::Base
  before_create :default_status

  belongs_to :article
  belongs_to :user

  validates :content,
    presence: true, length: { minimum: 10 }
    
  def to_s
    content
  end

  def default_status
    self.status = "not active"
  end

end
