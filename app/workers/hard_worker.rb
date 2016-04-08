class HardWorker
  include Sidekiq::Worker
  def perform(article_id)
    article = Article.find(article_id)
    article.title = sanitize(article.title)
    article.content = sanitize(article.content)
    article.save!
  end

 
	BLACKLIST = {
		'poop' => 'dookie',
		'test' => 'ruby',
		'fuck' => 'eh teu kengeng kasar' 
	}

	def sanitize(str)
		BLACKLIST.each do |bad, good|
			str.gsub!(bad, good)
		end
		str
	end

end
