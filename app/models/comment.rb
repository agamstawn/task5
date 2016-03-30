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

  def self.import(file)
    cheader = spreadsheet.sheet(1).row(1)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[cheader, spreadsheet.row(i)].transpose]
      debugger
      comment = new
      comment.attributes = row

      comment.save
    end
    
  end
end
