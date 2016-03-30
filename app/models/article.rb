class Article < ActiveRecord::Base
  WillPaginate.per_page = 10

  validates :title, presence: true,
    length: { minimum: 5 }
  validates :content, presence: true,
    length: { minimum: 10 }
  validates :status, presence: true

  validates_presence_of :title

  scope :status_active, -> {where(status: 'active')}

  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments,
    reject_if: proc { |attributes| attributes['content'].blank? },
    allow_destroy: true
  validates :content,
    presence: true
  def to_s
    content
  end

  def self.search(search)
    if search
      where(["title LIKE? or content LIKE?","%#{search}%","%#{search}%"])
    else
      all
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |comment|
        csv << comment.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)


    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      article = new
      article.attributes = row
      article.save
    end

  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
