class Post < ActiveRecord::Base
  STATUS_NORMAL = 1
  STATUS_DELETED = -1
  #has_many :comments, :conditions=>["status>0"], :order => 'id desc'

  #before_save :process_html_content
  validates_presence_of :title,  :message => "标题不能为空"
  validates_presence_of :category,  :message => "类别不能为空"
  validates_presence_of :html_content,  :message => "内容不能为空"
  validates_uniqueness_of :title, :message => "该文章已经存在"

  def self.buy_info
    Post.find :first, :conditions => ["category=? and status>0 ",2], :order => "id desc"
  end

  def self.recent(limit)
    sql = <<-EOF
      select * from posts
      where status > 0 and category =? 
      order by id desc
      limit ?
    EOF
    Post.find_by_sql [sql, Const::NEWS_POST_CATEGORY, limit]
  end

  def self.all(category=0, limit=10, offset=0)
    if category.to_i != 0
      Post.find :all, :conditions=>["status>0 and category=?", category], :order=>'is_top desc, id desc', :limit=> limit, :offset=>offset
    else
      Post.find :all, :conditions=>["status>0 and category > 2"], :order => 'is_top desc, id desc', :limit=>limit, :offset=>offset
    end
  end

  def self.posts_count(category=0)
    if category.to_i != 0
      Post.count 'id', :conditions=>["status>0 and category=?", category]
    else
      Post.count 'id', :conditions=>["status>0 and category > 2"]
    end
  end

  def self.search_count(category, keyword)
    return 0 if category.blank? || keyword.blank?
    sql=<<-EOF
      select count(id) from posts
      where category > 2 and status > 0
      #{" and author = ?" if category.to_i == 1}
      #{" and title like '%?%'" if category.to_i == 2}
    EOF
    Post.count_by_sql [sql, keyword]
  end

  def self.search(category, keyword,limit, offset)
    return [] if category.blank? || keyword.blank?
    sql=<<-EOF
      select * from posts
      where category > 2 and status > 0
      #{" and author = ?" if category.to_i == 1}
      #{" and title like '%?%'" if category.to_i == 2}
      order by id desc
      limit ? offset ?
    EOF
    Post.find_by_sql [sql, keyword, limit, offset]
  end

  def self.ranks(limit)
    sql =<<-EOF
      select * from posts
      where category > 2 and status > 0 
      order by hits desc
      limit ?
    EOF
    Post.find_by_sql [sql, limit]
  end

  def last_post(category=0)
    if category.to_i > 0
      Post.find :first, :conditions=>["status>0 and category=? and id > ?", category, self.id], :order=>'id asc'
    else
      Post.find :first, :conditions=>["status>0 and id > ?", self.id], :order=>'id asc'
    end
  end

  def next_post(category=0)
    if category.to_i > 0
      Post.find :first, :conditions=>["status>0 and category=? and id < ?", category, self.id], :order => 'id desc'
    else
      Post.find :first, :conditions=>["status>0 and id <?", self.id], :order => 'id desc'
    end
  end

  def comments(limit=10, offset=0)
    sql =<<-EOF
      select * from comments
      where post_id = ? and status>0
      order by id desc
      limit ? offset ?
    EOF
    Comment.find_by_sql [sql,self.id, limit, offset]
  end

  def comments_count
    sql = <<-EOF
      select count(id) from comments
      where post_id = #{self.id}
      and status > 0
    EOF
    Comment.count_by_sql(sql)
  end

  private
  def process_html_content
    self.html_content = simple_format(self.content)
  end

  def simple_format(text)
    format_text = ""
    format_text << "<p>"
    format_text << text.to_s.
      gsub(/\r\n?/, "\n").                    # \r\n and \r -> \n
      gsub(/\n\n+/, "</p>\n\n<p>").           # 2+ newline  -> paragraph
      gsub(/([^\n]\n)(?=[^\n])/, '\1<br />')  # 1 newline   -> br  
    format_text << "</p>"
  end

end
