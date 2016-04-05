ThinkingSphinx::Index.define :article, :with => :active_record do
  # fields
  # indexes subject, :sortable => true
  indexes title
  indexes content
  # indexes author.name, :as => :author, :sortable => true

  # attributes
  has created_at, updated_at
end