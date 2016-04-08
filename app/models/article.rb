class Article < ActiveRecord::Base
  # include ThinkingSphinx::Scopes
  # include PgSearch

  # multisearchable :against => [:title, :content]

  # WillPaginate.per_page = 10


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

  def self.paginate_order(page)
    paginate(:page => page, :per_page => 10).order("created_at desc")
  end

  def self.search(search)
    if search
      where(["title LIKE? or content LIKE?","%#{search}%","%#{search}%"])
    else
      all
    end
  end

  def self.import(file)


    spreadsheet = open_spreadsheet(file)
    page_article = spreadsheet.sheet('Article')

    (2..page_article.last_row).each do |no_row|
      @article = Article.create(
        title: page_article.row(no_row)[0],
        content: page_article.row(no_row)[1],
      status: page_article.row(no_row)[2])
    end

    page_comment = spreadsheet.sheet('Comment')
    (2..page_comment.last_row).each do |no_row|
      @comments = Comment.create(
        article_id: @article.id,
        user_id: page_comment.row(no_row)[1],
      content: page_comment.row(no_row)[2])
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

  # define_index do
  #   indexes content
  #   indexes :title, :sortable => true
  #   indexes comments.content, :as => :comment_content
  #   # indexes [author.first_name, author.last_name], :as => :author_name
    
  #   has author_id, created_at
  # end
end
